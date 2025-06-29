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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔙 Background Message: ${message.notification?.title}");
}

void main() async {
  final initializer = ServiceInitializer();
  await initializer.init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final storage = const FlutterSecureStorage();
  String? token = '';

  // await storage.deleteAll();
  if (await storage.containsKey(key: "auth_token")) {
    token = await storage.read(key: "auth_token");
    print("un token ici :" + token!);
  }
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
        initialRoute: token.isNotEmpty ? AppPages.INITIAL : Routes.LOGIN,
        // initialRoute: Routes.RIDE_SEARCH,
        getPages: AppPages.routes,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
      ),
    ),
  );
}
