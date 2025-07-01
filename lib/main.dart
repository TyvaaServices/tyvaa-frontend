import 'dart:convert';

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

  // Store notification when app is in background/terminated
  if (message.notification != null) {
    print("🔔 Storing and showing background notification...");

    // Initialize local notifications for background
    LocalNotificationService.initialize();
    await LocalNotificationService.createNotificationChannel();

    // Show the notification in system tray
    await LocalNotificationService.showNotificationFromFCM(message);

    // Store notification for in-app list
    await _storeBackgroundNotification(message);
    print("🔔 Background notification processed successfully");
  }
}

Future<void> _storeBackgroundNotification(RemoteMessage message) async {
  try {
    const String NOTIFICATIONS_KEY = 'tyvaa_notifications';
    const storage = FlutterSecureStorage();

    // Get existing notifications from secure storage
    String? existingNotificationsJson = await storage.read(
      key: NOTIFICATIONS_KEY,
    );
    List<dynamic> storedNotifications = [];

    if (existingNotificationsJson != null) {
      storedNotifications = jsonDecode(existingNotificationsJson);
    }

    // Determine notification type from data
    String notificationType = 'reminder'; // Default
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

    // Create notification object
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

    // Add new notification
    storedNotifications.add(notificationData);

    // Limit to 50 notifications to avoid excessive storage
    if (storedNotifications.length > 50) {
      storedNotifications = storedNotifications.sublist(
        storedNotifications.length - 50,
      );
    }

    // Store back to secure storage
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
