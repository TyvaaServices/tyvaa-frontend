import 'package:get/get.dart';

import '../../../domain/entities/message.dart';
import '../../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends GetConnect implements ChatRepository {
  @override
  final String baseUrl;

  ChatRepositoryImpl({required this.baseUrl}) {
    httpClient.baseUrl = baseUrl;
  }

  @override
  Future<Message> sendMessage(
    String content,
    String personality,
    List<Message> history,
  ) async {
    final response = await post('/support/chat', {
      'message': content,
      'personality': personality,
      'history':
          history
              .map(
                (m) => {
                  'text': m.text,
                  'isUserMessage': m.isUserMessage,
                  'timestamp': m.timestamp.toIso8601String(),
                },
              )
              .toList(),
    });

    if (response.statusCode == 200) {
      await Future.delayed(3.seconds);
      return Message.fromJson({'text': response.body['reply']});
    } else {
      await Future.delayed(3.seconds);
      throw Exception(response.body['error'] ?? 'Server error');
    }
  }
}
