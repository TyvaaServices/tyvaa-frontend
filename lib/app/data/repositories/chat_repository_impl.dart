import 'package:get/get_connect/connect.dart';

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
    final response = await post('/api/support/chat', {
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
      return Message.fromJson({'text': response.body['reply']});
    } else {
      throw Exception(response.body['error'] ?? 'Server error');
    }
  }
}
