import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../domain/entities/message.dart';
import '../../../../domain/repositories/chat_repository.dart';

class ChatbotController extends GetxController {
  final ChatRepository chatRepository;

  final RxList<Message> messages = <Message>[].obs;
  final TextEditingController messageController = TextEditingController();
  final selectedChatbot = ''.obs;
  final isTyping = false.obs;
  final ScrollController chatScrollController = ScrollController();
  final RxBool showChatInterface = false.obs;
  final isPressingSend = false.obs;

  final _storage = const FlutterSecureStorage();
  static const _chatbotKey = 'selected_chatbot';

  ChatbotController({required this.chatRepository});

  @override
  void onInit() {
    super.onInit();
    _loadSavedChatbot();
  }

  @override
  void onClose() {
    messageController.dispose();
    chatScrollController.dispose();
    super.onClose();
  }

  void scrollToBottom() {
    if (chatScrollController.hasClients) {
      chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent + 450,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> saveChatbotPreference(String chatbotName) async {
    selectedChatbot.value = chatbotName;
    await _storage.write(key: _chatbotKey, value: chatbotName);
    messages.clear();
    _sendBotGreeting();
    print("Chatbot selected: $chatbotName");
  }

  void _sendBotGreeting() {
    final greeting =
        selectedChatbot.value == 'Oulyx'
            ? 'Bonjour ! Je suis Oulyx, votre assistant stratégique. Comment puis-je vous aider à organiser votre projet aujourd\'hui ?'
            : 'Salut ! Je suis Chyx, prêt à booster votre créativité ! De quoi avons-nous besoin aujourd\'hui ?';

    messages.add(
      Message(text: greeting, isUserMessage: false, timestamp: DateTime.now()),
    );
    HapticFeedback.lightImpact();
  }

  Future<void> _loadSavedChatbot() async {
    final saved = await _storage.read(key: _chatbotKey);
    if (saved != null && saved.isNotEmpty) {
      selectedChatbot.value = saved;
      _sendBotGreeting();
      print("✅ Restored saved chatbot: $saved");
    }
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final userMsg = Message(
      text: text,
      isUserMessage: true,
      timestamp: DateTime.now(),
    );
    messages.add(userMsg);
    isTyping.value = true;
    messageController.clear();
    scrollToBottom();

    String personality = selectedChatbot.value == 'Oulyx' ? 'f' : 'm';

    try {
      final botReply = await chatRepository.sendMessage(
        text,
        personality,
        messages.take(50).toList(),
      );
      messages.add(botReply);
      HapticFeedback.lightImpact();
      SystemSound.play(SystemSoundType.alert);
    } catch (e) {
      messages.add(
        Message(
          text:
              personality == 'm'
                  ? "Euh vérifier votre connexion svp mdr"
                  : "Uhm vous êtes actuellement pas connecté ?",
          isUserMessage: false,
          timestamp: DateTime.now(),
        ),
      );
      HapticFeedback.mediumImpact();
      SystemSound.play(SystemSoundType.alert);
    }

    isTyping.value = false;
    scrollToBottom();
  }
}
