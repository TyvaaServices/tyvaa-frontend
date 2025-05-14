import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/api/api_client.dart';
import 'package:passenger_tyvaa/app/i18n/translations.dart';
import 'package:passenger_tyvaa/app/services/connectivity_listener.dart';

import 'app/routes/app_pages.dart';
import 'app/services/connectivity_service.dart';
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
  Get.put(ConnectivityController(), permanent: true);
  Get.put(ApiClient(), permanent: true);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize notification service
  final notificationService = Get.put(NotificationService());
  await notificationService.init();
  // print("im here");
  // print(Get.deviceLocale!.languageCode);
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? token = await storage.read(key: "auth_token");
  var logger = Logger();

  // await storage.deleteAll();
  logger.d(token);

  runApp(
    ConnectivityListener(
      child: GetMaterialApp(
        title: "Tyvaa",
        debugShowCheckedModeBanner: false,
        translations: TyvaaTranslation(),
        locale: Locale('fr'), //TODO en pro on remplace par Get.deviceLocale
        fallbackLocale: Locale('en'),
        initialRoute: token != null ? AppPages.INITIAL : Routes.LOGIN,
        getPages: AppPages.routes,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
      ),
    ),
  );
}
