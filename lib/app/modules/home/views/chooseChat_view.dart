import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/widgets/typing_indicator.dart';
import '../../../themes/tyvaa_theme.dart';
import '../controllers/home_controller.dart';

class ChooseChatbotScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    final brightness = Theme.of(context).brightness;

    final backgroundColor = brightness == Brightness.dark ? AppColors.darkBackground : AppColors.background;
    final textColor = brightness == Brightness.dark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final buttonColor = brightness == Brightness.dark ? AppColors.primaryDark : AppColors.primary;
    final warningColor = brightness == Brightness.dark ? AppColors.warning : AppColors.warning;

    return Obx(() {
      return controller.showChatInterface.value
          ? _buildChatInterface(context, controller, backgroundColor, textColor, buttonColor)
          : _buildChatbotSelectionUI(context, controller, backgroundColor, textColor, buttonColor, warningColor);
    });
  }

  Widget _buildChatbotSelectionUI(BuildContext context, HomeController controller, Color backgroundColor, Color textColor, Color buttonColor, Color warningColor) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Choisissez l'assistant qui vous accompagnera dans votre parcours",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.subtitle1.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 36),
                    Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildChatbotCard(
                            context: context,
                            name: 'Oulyx',
                            description:
                            'Votre guide stratégique et organisé. Oulyx est un chatbot analytique, précis et empathique qui vous aidera dans vos voyages',
                            personality: 'Analytique • Précise • Empathique',
                            imagePath: 'assets/chatbot_pic/oulyx_avatar.png',
                            isSelected: controller.selectedChatbot.value == 'Oulyx',
                            onPressed: () => controller.selectedChatbot.value = 'Oulyx',
                            primaryColor: Color(0xFF3498DB),
                            secondaryColor: Color(0xFFE1F0FA),
                          ),
                          SizedBox(width: 16),
                          _buildChatbotCard(
                            context: context,
                            name: 'Chyx',
                            description:
                            'Votre compagnon créatif et intuitif. Chyx est un chatbot créatif et drole vous aidant lors de vos voyages.',
                            personality: 'Créatif • Drole • Inspirant',
                            imagePath: 'assets/chatbot_pic/chyx_avatar.png',
                            isSelected: controller.selectedChatbot.value == 'Chyx',
                            onPressed: () => controller.selectedChatbot.value = 'Chyx',
                            primaryColor: Color(0xFFE74C3C),
                            secondaryColor: Color(0xFFFCE4E2),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            Obx(() => _buildBottomButton(controller, buttonColor, warningColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(HomeController controller, Color buttonColor, Color warningColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: controller.selectedChatbot.value.isNotEmpty
              ? buttonColor
              : warningColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: controller.selectedChatbot.value.isNotEmpty
              ? [
            BoxShadow(
              color: buttonColor.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              if (controller.selectedChatbot.value.isNotEmpty) {
                controller.saveChatbotPreference(controller.selectedChatbot.value);
                controller.showChatInterface.value = true;
              } else {
                Get.snackbar(
                  'Selection requise',
                  'Veuillez choisir un assistant avant de continuer',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: warningColor,
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
                    controller.selectedChatbot.value.isNotEmpty
                        ? "Commencer avec ${controller.selectedChatbot.value}"
                        : "Sélectionnez un assistant",
                    style: AppTextStyles.button.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatbotCard({
    required BuildContext context,
    required String name,
    required String description,
    required String personality,
    required String imagePath,
    required bool isSelected,
    required VoidCallback onPressed,
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    // Checking if the current theme is dark mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? secondaryColor.withOpacity(0.1) // Lighter selection in dark mode
                : isDarkMode
                ? Colors.grey[800] // Darker background in dark mode
                : Colors.white, // Light background in light mode
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? primaryColor
                  : isDarkMode
                  ? Colors.grey[700]!
                  : Colors.grey.shade300,
              width: isSelected ? 2.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? primaryColor.withOpacity(0.3)
                    : isDarkMode
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.1),
                spreadRadius: isSelected ? 2 : 0,
                blurRadius: isSelected ? 15 : 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.2 : 1.0,
                duration: Duration(milliseconds: 300),
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: secondaryColor,
                    border: Border.all(
                      color: primaryColor.withOpacity(0.5),
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                name,
                style: AppTextStyles.h2.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              AnimatedSize(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  height: isSelected ? null : 50,
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: isDarkMode ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  personality,
                  style: AppTextStyles.bodySecondary.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 40,
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sélectionné",
                        style: AppTextStyles.bodySecondary.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildChatInterface(BuildContext context, HomeController controller, Color backgroundColor, Color textColor, Color buttonColor) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                controller.selectedChatbot.value == 'Oulyx'
                    ? 'assets/chatbot_pic/oulyx_avatar.png'
                    : 'assets/chatbot_pic/chyx_avatar.png',
              ),
              radius: 16,
            ),
            SizedBox(width: 12),
            Text(
              controller.selectedChatbot.value,
              style: AppTextStyles.h3.copyWith(color: textColor),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final msgList = [...controller.messages];
              if (controller.isTyping.value) {
                msgList.add(Message(
                  text: 'typing',
                  isUserMessage: false,
                  timestamp: DateTime.now(),
                ));
              }
              return ListView.builder(
                controller: controller.chatScrollController,
                padding: EdgeInsets.all(16),
                itemCount: msgList.length,
                itemBuilder: (context, index) {
                  final message = msgList[index];
                  if (controller.isTyping.value && index == msgList.length - 1) {
                    return TypingIndicator(botColor: controller.selectedChatbot.value == 'Oulyx'
                        ? Color(0xFF3498DB)
                        : Color(0xFFE74C3C));
                  }
                  return ChatBubble(
                    message: message.text,
                    isUserMessage: message.isUserMessage,
                    timestamp: message.timestamp,
                    botColor: controller.selectedChatbot.value == 'Oulyx'
                        ? Color(0xFF3498DB)
                        : Color(0xFFE74C3C),
                  );
                },
              );
            }),
          ),
          _buildMessageInput(controller),
        ],
      ),
    );
  }

  Widget _buildMessageInput(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              decoration: InputDecoration(
                hintText: 'Tapez votre message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              onSubmitted: (_) => controller.sendMessage(),
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: controller.sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}


class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUserMessage;
  final DateTime timestamp;
  final Color botColor;

  const ChatBubble({
    required this.message,
    required this.isUserMessage,
    required this.timestamp,
    required this.botColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUserMessage ? AppColors.primary : botColor.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: isUserMessage ? Radius.circular(20) : Radius.circular(4),
            bottomRight: isUserMessage ? Radius.circular(4) : Radius.circular(20),
          ),
          border: Border.all(
            color: isUserMessage ? Colors.transparent : botColor.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: AppTextStyles.body.copyWith(
                color: isUserMessage ? Colors.white : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}',
              style: AppTextStyles.caption.copyWith(
                color: isUserMessage ? Colors.white70 : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
