import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:passenger_tyvaa/app/config/environment.dart';
import 'package:passenger_tyvaa/app/core/service_initializer.dart';
import 'package:passenger_tyvaa/app/i18n/translations.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';
import 'package:passenger_tyvaa/app/services/connectivity_listener.dart';
import 'package:passenger_tyvaa/app/services/local_notification_service.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔔 =============== BACKGROUND MESSAGE RECEIVED ===============");
  print("🔔 Message ID: ${message.messageId}");
  print("🔔 From: ${message.from}");
  print("🔔 Data: ${message.data}");
  print("🔔 Notification Title: ${message.notification?.title}");
  print("🔔 Notification Body: ${message.notification?.body}");
  print("🔔 ========================================================");

  if (message.notification != null) {
    print("🔔 Storing and showing background notification...");

    LocalNotificationService.initialize();
    await LocalNotificationService.createNotificationChannel();

    await LocalNotificationService.showNotificationFromFCM(message);
    await _storeBackgroundNotification(message);
    print("🔔 Background notification processed successfully");
  }
}

Future<void> _storeBackgroundNotification(RemoteMessage message) async {
  try {
    const String NOTIFICATIONS_KEY = 'tyvaa_notifications';
    const storage = FlutterSecureStorage();

    String? existingNotificationsJson = await storage.read(
      key: NOTIFICATIONS_KEY,
    );
    List<dynamic> storedNotifications = [];

    if (existingNotificationsJson != null) {
      storedNotifications = jsonDecode(existingNotificationsJson);
    }

    String notificationType = 'reminder';
    if (message.data.containsKey('type')) {
      switch (message.data['type']) {
        case 'message':
          notificationType = 'message';
          break;
        case 'tripAccepted':
          notificationType = 'tripAccepted';
          break;
        case 'tripCancelled':
          notificationType = 'tripCancelled';
          break;
        case 'promo':
          notificationType = 'promo';
          break;
        case 'reminder':
          notificationType = 'reminder';
          break;
      }
    }

    final notificationData = {
      'id':
          message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      'title': message.notification?.title ?? 'New notification',
      'message': message.notification?.body ?? '',
      'type': 'NotificationType.$notificationType',
      'time': DateTime.now().toIso8601String(),
      'isRead': false,
      'actionData': message.data,
    };

    storedNotifications.add(notificationData);

    if (storedNotifications.length > 50) {
      storedNotifications = storedNotifications.sublist(
        storedNotifications.length - 50,
      );
    }

    await storage.write(
      key: NOTIFICATIONS_KEY,
      value: jsonEncode(storedNotifications),
    );
    print("🔔 Notification stored in background: ${notificationData['title']}");
  } catch (e) {
    print('❌ Error storing background notification: $e');
  }
}

void main() async {
  final initializer = ServiceInitializer();
  await initializer.init();

  await Environment.load();

  if (Environment.isDevelopment) {
    Environment.printConfig();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final storage = const FlutterSecureStorage();
  String? token = '';

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
        fallbackLocale: Locale('en'),
        initialRoute: token.isNotEmpty ? AppPages.INITIAL : Routes.LOGIN,
        getPages: AppPages.routes,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
      ),
    ),
  );
}
