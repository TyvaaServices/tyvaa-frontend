import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:passenger_tyvaa/app/widgets/chatbot/chat_bot_card.dart';
import 'package:passenger_tyvaa/app/widgets/typing_indicator.dart';

import '../../../../domain/entities/message.dart';

class ChooseChatbotScreen extends GetView<ChatbotController> {
  const ChooseChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    // Updated color palette
    final backgroundColor = isDark ? Color(0xFF121212) : Color(0xFFF8F9FD);
    final cardColor = isDark ? Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Color(0xFF2D3142);
    final accentBlue = Color(0xFF3370FF);
    final accentRed = Color(0xFFFF4757);

    return Obx(() {
      return controller.showChatInterface.value
          ? _buildChatInterface(context, controller, isDark)
          : _buildChatbotSelectionUI(
            context,
            controller,
            backgroundColor,
            cardColor,
            textColor,
            accentBlue,
            accentRed,
          );
    });
  }

  Widget _buildChatbotSelectionUI(
    BuildContext context,
    ChatbotController controller,
    Color backgroundColor,
    Color cardColor,
    Color textColor,
    Color accentBlue,
    Color accentRed,
  ) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                // Animated header
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [accentBlue, accentRed],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    "Rencontrez votre compagnon de voyage",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Choisissez l'assistant qui vous accompagnera dans votre parcours",
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor.withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 40),
                // Chatbot selection cards
                Obx(
                  () => _buildSelectionCards(
                    context,
                    controller,
                    cardColor,
                    textColor,
                    accentBlue,
                    accentRed,
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(
        controller,
        backgroundColor,
        textColor,
      ),
    );
  }

  Widget _buildSelectionCards(
    BuildContext context,
    ChatbotController controller,
    Color cardColor,
    Color textColor,
    Color accentBlue,
    Color accentRed,
  ) {
    return Column(
      children: [
        ChatBotCard(
          context: context,
          name: 'Oulyx',
          description:
              'Votre guide stratégique et organisé. Analytique et précis, Oulyx vous aidera à planifier et organiser vos voyages avec efficacité.',
          personality: 'Analytique • Précise • Empathique',
          imagePath: 'assets/chatbot_pic/oulyx_avatar.png',
          isSelected: controller.selectedChatbot.value == 'Oulyx',
          onPressed: () => controller.selectedChatbot.value = 'Oulyx',
          primaryColor: accentBlue,
          secondaryColor: accentBlue.withOpacity(0.1),
          cardColor: cardColor,
          textColor: textColor,
        ),
        SizedBox(height: 20),
        ChatBotCard(
          context: context,
          name: 'Chyx',
          description:
              'Votre compagnon créatif et intuitif. Inspirant et plein d\'humour, Chyx vous accompagnera avec spontanéité et originalité.',
          personality: 'Créatif • Drole • Inspirant',
          imagePath: 'assets/chatbot_pic/chyx_avatar.png',
          isSelected: controller.selectedChatbot.value == 'Chyx',
          onPressed: () => controller.selectedChatbot.value = 'Chyx',
          primaryColor: accentRed,
          secondaryColor: accentRed.withOpacity(0.1),
          cardColor: cardColor,
          textColor: textColor,
        ),
      ],
    );
  }

  Widget _buildBottomButton(
    ChatbotController controller,
    Color backgroundColor,
    Color textColor,
  ) {
    final bool hasSelection = controller.selectedChatbot.value.isNotEmpty;
    final Color buttonColor =
        controller.selectedChatbot.value == 'Oulyx'
            ? Color(0xFF3370FF)
            : controller.selectedChatbot.value == 'Chyx'
            ? Color(0xFFFF4757)
            : Colors.grey;

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 0,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 60,
        decoration: BoxDecoration(
          gradient:
              hasSelection
                  ? LinearGradient(
                    colors: [buttonColor, buttonColor.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : null,
          color: hasSelection ? null : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          boxShadow:
              hasSelection
                  ? [
                    BoxShadow(
                      color: buttonColor.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: Offset(0, 5),
                    ),
                  ]
                  : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              if (hasSelection) {
                controller.saveChatbotPreference(
                  controller.selectedChatbot.value,
                );
                controller.showChatInterface.value = true;
              } else {
                Get.snackbar(
                  'Selection requise',
                  'Veuillez choisir un assistant avant de continuer',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(16),
                  borderRadius: 8,
                );
              }
            },
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    hasSelection
                        ? "Commencer avec ${controller.selectedChatbot.value}"
                        : "Veuillez sélectionner un assistant",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          hasSelection
                              ? Colors.white
                              : textColor.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color:
                        hasSelection
                            ? Colors.white
                            : textColor.withOpacity(0.5),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatInterface(
    BuildContext context,
    ChatbotController controller,
    bool isDark,
  ) {
    final botColor =
        controller.selectedChatbot.value == 'Oulyx'
            ? Color(0xFF3370FF)
            : Color(0xFFFF4757);

    final backgroundColor = isDark ? Color(0xFF121212) : Color(0xFFF8F9FD);
    final cardColor = isDark ? Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Color(0xFF2D3142);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildChatAppBar(
        context,
        controller,
        backgroundColor,
        textColor,
        botColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final msgList = [...controller.messages];
              if (controller.isTyping.value) {
                msgList.add(
                  Message(
                    text: 'typing',
                    isUserMessage: false,
                    timestamp: DateTime.now(),
                  ),
                );
              }
              return ListView.builder(
                controller: controller.chatScrollController,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                itemCount: msgList.length,
                itemBuilder: (context, index) {
                  final message = msgList[index];
                  if (controller.isTyping.value &&
                      index == msgList.length - 1) {
                    return TypingIndicator(botColor: botColor);
                  }
                  return _buildMessageBubble(
                    message: message.text,
                    isUserMessage: message.isUserMessage,
                    timestamp: message.timestamp,
                    botColor: botColor,
                    isDark: isDark,
                    isFirst:
                        index == 0 ||
                        (index > 0 &&
                            msgList[index - 1].isUserMessage !=
                                message.isUserMessage),
                    isLast:
                        index == msgList.length - 1 ||
                        (index < msgList.length - 1 &&
                            msgList[index + 1].isUserMessage !=
                                message.isUserMessage),
                  );
                },
              );
            }),
          ),
          _buildMessageInput(controller, isDark, botColor),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildChatAppBar(
    BuildContext context,
    ChatbotController controller,
    Color backgroundColor,
    Color textColor,
    Color botColor,
  ) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          SizedBox(width: 16),
          Hero(
            tag: 'avatar_${controller.selectedChatbot.value}',
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [botColor, botColor.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  controller.selectedChatbot.value == 'Oulyx'
                      ? 'assets/chatbot_pic/oulyx_avatar.png'
                      : 'assets/chatbot_pic/chyx_avatar.png',
                ),
                radius: 16,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          SizedBox(width: 12),
          // Bot name and status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.selectedChatbot.value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              Text(
                controller.isTyping.value
                    ? 'En train d\'écrire...'
                    : 'En ligne',
                style: TextStyle(
                  fontSize: 12,
                  color:
                      controller.isTyping.value
                          ? botColor
                          : textColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Spacer(),
          // Options button
          // Options button
          // Options popup menu
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'change_bot') {
                controller.showChatInterface.value = false;
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: textColor.withOpacity(0.7),
              size: 20,
            ),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'change_bot',
                    child: Row(
                      children: [
                        Icon(
                          Icons.sync,
                          color: textColor.withOpacity(0.7),
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Changer d’assistant',
                          style: TextStyle(color: textColor),
                        ),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required String message,
    required bool isUserMessage,
    required DateTime timestamp,
    required Color botColor,
    required bool isDark,
    required bool isFirst,
    required bool isLast,
  }) {
    final textColor = isDark ? Colors.white : Color(0xFF2D3142);

    return Padding(
      padding: EdgeInsets.only(top: isFirst ? 8 : 4, bottom: isLast ? 8 : 4),
      child: Row(
        mainAxisAlignment:
            isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUserMessage && isFirst)
            Container(
              margin: EdgeInsets.only(right: 8),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [botColor, botColor.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  botColor == Color(0xFF3370FF)
                      ? 'assets/chatbot_pic/oulyx_avatar.png'
                      : 'assets/chatbot_pic/chyx_avatar.png',
                ),
                backgroundColor: Colors.transparent,
              ),
            )
          else if (!isUserMessage && !isFirst)
            SizedBox(width: 36),

          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color:
                    isUserMessage
                        ? botColor
                        : isDark
                        ? Color(0xFF2A2A2A)
                        : botColor.withOpacity(0.08),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isUserMessage || !isFirst ? 18 : 4),
                  topRight: Radius.circular(isUserMessage && !isFirst ? 4 : 18),
                  bottomLeft: Radius.circular(
                    isUserMessage || !isLast ? 18 : 4,
                  ),
                  bottomRight: Radius.circular(
                    isUserMessage && !isLast ? 4 : 18,
                  ),
                ),
                boxShadow:
                    isUserMessage
                        ? [
                          BoxShadow(
                            color: botColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ]
                        : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 15,
                      color: isUserMessage ? Colors.white : textColor,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 10,
                      color:
                          isUserMessage
                              ? Colors.white.withOpacity(0.7)
                              : textColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isUserMessage && isFirst)
            Container(
              margin: EdgeInsets.only(left: 8),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? Color(0xFF2A2A2A) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.person,
                color: textColor.withOpacity(0.7),
                size: 16,
              ),
            )
          else if (isUserMessage && !isFirst)
            SizedBox(width: 36),
        ],
      ),
    );
  }

  Widget _buildMessageInput(
    ChatbotController controller,
    bool isDark,
    Color botColor,
  ) {
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
          // Optional icons
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: textColor.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.mic, color: textColor.withOpacity(0.7), size: 20),
          ),
          SizedBox(width: 12),
          // Text field
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
          // Send button
          GestureDetector(
            onTapDown: (_) => controller.isPressingSend.value = true,
            onTapUp: (_) => controller.isPressingSend.value = false,
            onTapCancel: () => controller.isPressingSend.value = false,
            onTap: controller.sendMessage,
            child: Obx(
              () => AnimatedScale(
                scale: controller.isPressingSend.value ? 0.8 : 1.0,
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
