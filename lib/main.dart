import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/api/api_client.dart';

import 'app/routes/app_pages.dart';
import 'app/services/notification_service.dart';
import 'app/themes/tyvaa_theme.dart';
import 'firebase_options.dart';

// This handler is called when messages are received in the background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔙 Background Message: ${message.notification?.title}");
  // Background notifications are automatically displayed by the OS
  // We can't access the app's state here (like controllers)
}

void main() async {
  Get.put(ApiClient(), permanent: true);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize notification service
  final notificationService = Get.put(NotificationService());
  await notificationService.init();

  runApp(
    GetMaterialApp(
      title: "Tyvaa",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
    ),
  );
}
