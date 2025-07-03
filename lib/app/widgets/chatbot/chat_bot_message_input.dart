import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/chatbot/controllers/chatbot_controller.dart';

class ChatMessageInput extends StatelessWidget {
  final ChatbotController controller;
  final bool isDark;
  final Color botColor;

  const ChatMessageInput({
    super.key,
    required this.controller,
    required this.isDark,
    required this.botColor,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDark ? Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDark ? Colors.white : Color(0xFF2D3142);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: textColor.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.mic, color: textColor.withOpacity(0.7), size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: controller.messageController,
                decoration: InputDecoration(
                  hintText: 'Tapez votre message...',
                  hintStyle: TextStyle(
                    color: textColor.withOpacity(0.5),
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                style: TextStyle(color: textColor, fontSize: 15),
                onSubmitted: (_) => controller.sendMessage(),
              ),
            ),
          ),
          SizedBox(width: 12),
          GestureDetector(
            onTapDown: (_) => controller.isPressingSend.value = true,
            onTapUp: (_) => controller.isPressingSend.value = false,
            onTapCancel: () => controller.isPressingSend.value = false,
            onTap: controller.sendMessage,
            child: Obx(
              () => AnimatedScale(
                scale: controller.isPressingSend.value ? 0.9 : 1.0,
                duration: Duration(milliseconds: 150),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [botColor, botColor.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: botColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
