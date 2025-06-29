import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/chatbot/controllers/chatbot_controller.dart';

import '../../../data/repositories/chat_repository_impl.dart';

class ChatbotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatbotController>(
      fenix: true,
      () => ChatbotController(
        chatRepository: ChatRepositoryImpl(
          baseUrl: 'http://10.0.2.2:3000/api/v1',
        ),
      ),
    );
  }
}
