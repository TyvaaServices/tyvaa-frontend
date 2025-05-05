import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Existing banner functionality
  final bannerController = PageController(viewportFraction: 0.9);
  final currentBanner = 0.obs;
  final selectedIndex = 0.obs;
  final RxBool showChatInterface = false.obs;
  final isTyping = false.obs;


  late Timer _bannerTimer;
  final ScrollController chatScrollController = ScrollController(); // Define a scroll controller


  final banners = [
    {
      'image': 'assets/promo1.png',
      'title': 'Voyagez en toute sérénité',
      'subtitle': 'Des trajets vérifiés et sécurisés'
    },
    {
      'image': 'assets/promo2.png',
      'title': 'Éco-mobilité intelligente',
      'subtitle': 'Réduisez votre empreinte carbone'
    },
    {
      'image': 'assets/promo3.png',
      'title': 'Communauté bienveillante',
      'subtitle': 'Rejoignez des milliers de membres'
    },
  ];

  // Chatbot functionality
  final RxList<Message> messages = <Message>[].obs;
  final TextEditingController messageController = TextEditingController();
  final selectedChatbot = ''.obs;

  @override
  void onInit() {
    // Initialize banner timer
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (currentBanner.value + 1) % banners.length;
      if (bannerController.hasClients) {
        bannerController.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    _bannerTimer.cancel();
    bannerController.dispose();
    messageController.dispose();

    chatScrollController.dispose();
    super.onClose();
  }
  // Method to scroll to the bottom
  void scrollToBottom() {
    if (chatScrollController.hasClients) {
      chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent+450,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  void changeTab(int index) => selectedIndex.value = index;

  void saveChatbotPreference(String chatbotName) {
    selectedChatbot.value = chatbotName;
    messages.clear();
    _sendBotGreeting();
    // Add actual storage implementation here
    print("Chatbot selected: $chatbotName");
  }

  void _sendBotGreeting() {
    final greeting = selectedChatbot.value == 'Oulyx'
        ? 'Bonjour ! Je suis Oulyx, votre assistant stratégique. Comment puis-je vous aider à organiser votre projet aujourd\'hui ?'
        : 'Salut ! Je suis Chyx, prêt à booster votre créativité ! De quoi avons-nous besoin aujourd\'hui ?';

    messages.add(Message(
      text: greeting,
      isUserMessage: false,
      timestamp: DateTime.now(),
    ));
  }

  void sendMessage() {
    if (messageController.text.isEmpty) return;

    // Add user message
    messages.add(Message(
      text: messageController.text,
      isUserMessage: true,
      timestamp: DateTime.now(),
    ));
    isTyping.value = true;
    scrollToBottom();
    // Simulate bot response
    Future.delayed(const Duration(seconds: 4), () {
      final response = selectedChatbot.value == 'Oulyx'
          ? 'Je comprends votre demande. Procédons étape par étape pour maximiser l\'efficacité.'
          : 'Excellente idée ! Explorons ensemble des solutions innovantes pour cela.';

      messages.add(Message(
        text: response,
        isUserMessage: false,
        timestamp: DateTime.now(),
      ));
      isTyping.value = false;

      scrollToBottom();

    });

    messageController.clear();
  }
}

class Message {
  final String text;
  final bool isUserMessage;
  final DateTime timestamp;

  Message({
    required this.text,
    required this.isUserMessage,
    required this.timestamp,
  });
}