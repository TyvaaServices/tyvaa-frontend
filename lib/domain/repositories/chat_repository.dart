import '../entities/message.dart';

abstract class ChatRepository {
  Future<Message> sendMessage(
    String content,
    String personality,
    List<Message> history,
  );
}
