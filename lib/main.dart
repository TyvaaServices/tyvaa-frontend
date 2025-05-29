import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:passenger_tyvaa/app/core/service_initializer.dart';
import 'package:passenger_tyvaa/app/i18n/translations.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';
import 'package:passenger_tyvaa/app/services/connectivity_listener.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';
// Import deprecated theme for backward compatibility until migration is complete
// @deprecated - Will be removed in future versions
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart'
    hide lightTheme, darkTheme;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔙 Background Message: ${message.notification?.title}");
}

void main() async {
  final initializer = ServiceInitializer();
  await initializer.init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final storage = FlutterSecureStorage();
  final token = await storage.read(key: "auth_token");
  // await storage.deleteAll();
  Jiffy.setLocale('fr');
  runApp(
    ConnectivityListener(
      child: GetMaterialApp(
        title: "Tyvaa",
        debugShowCheckedModeBanner: false,
        translations: TyvaaTranslation(),
        locale: Locale('fr'),
        // TODO: Replace with Get.deviceLocale in production
        fallbackLocale: Locale('en'),
        //tu intervertis ici rek si tu veux sauter le login
        initialRoute: token == null ? AppPages.INITIAL : Routes.LOGIN,
        getPages: AppPages.routes,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
      ),
    ),
  );
}
