import 'package:get/get.dart';
import '../views/chat_detail_view.dart';

class MessagesController extends GetxController {
  final conversations = <Map<String, dynamic>>[
    {
      "id": "1",
      "name": "Arjun Singh",
      "lastMessage": "J'arrive dans 5 minutes !",
      "time": "11:30",
      "unread": 2,
      "avatar": "assets/icons/nav_profile.png",
    },
    {
      "id": "2",
      "name": "Fatou Diop",
      "lastMessage": "Merci pour le trajet.",
      "time": "Hier",
      "unread": 0,
      "avatar": "assets/icons/nav_profile.png",
    },
  ].obs;

  void openChat(String id) {
    Get.to(() => const ChatDetailView(), arguments: id);
  }
}
