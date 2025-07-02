import 'package:hive/hive.dart';

part 'message.g.dart';


@HiveType(typeId: 4)
class Message extends HiveObject {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final bool isUserMessage;
  @HiveField(2)
  final DateTime timestamp;

  Message({
    required this.text,
    required this.isUserMessage,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'] ?? '',
      isUserMessage: false,
      timestamp: DateTime.now(),
    );
  }
}
