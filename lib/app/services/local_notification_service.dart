import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null && response.payload!.isNotEmpty) {
          handleNotificationTap(response.payload!);
        }
      },
    );
  }

  static void handleNotificationTap(String payload) {
    try {
      final data = jsonDecode(payload) as Map<String, dynamic>;

      if (data.containsKey('route')) {
        Get.toNamed(data['route']);
      } else if (data.containsKey('type')) {
        switch (data['type']) {
          case 'tripAccepted':
            Get.toNamed(Routes.RIDE_DETAILS, arguments: data['tripId']);
            break;
          case 'message':
            Get.toNamed(Routes.MAIN);
            break;
          case 'promo':
            Get.toNamed(Routes.MAIN);
            break;
          default:
            Get.toNamed(Routes.NOTIFICATION);
            break;
        }
      } else {
        Get.toNamed(Routes.NOTIFICATION);
      }
    } catch (e) {
      print('Error handling notification tap: $e');
      Get.toNamed(Routes.NOTIFICATION);
    }
  }

  static Future<void> createNotificationChannel() async {
    if (Platform.isAndroid) {
      final AndroidNotificationChannel channel = AndroidNotificationChannel(
        'tyvaa_notifications',
        'Tyvaa Notifications',
        description: 'Notifications for Tyvaa app',
        importance: Importance.max,
        enableVibration: true,
        vibrationPattern: Int64List.fromList([0, 300, 100, 300]),
        enableLights: true,
        ledColor: Color(0xFF6C63FF),
        showBadge: true,
        playSound: true,
      );

      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      await _checkAndConfigureNotificationSettings();
    }
  }

  static Future<void> _checkAndConfigureNotificationSettings() async {
    if (Platform.isAndroid) {
      final androidPlugin =
          _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      if (androidPlugin != null) {
        final List<AndroidNotificationChannel>? channels =
            await androidPlugin.getNotificationChannels();

        print('📱 Available notification channels: ${channels?.length ?? 0}');

        final bool? areNotificationsEnabled =
            await androidPlugin.areNotificationsEnabled();
        print('📱 Notifications enabled: $areNotificationsEnabled');

        if (areNotificationsEnabled == false) {
          print('❌ Notifications are disabled for this app');
        }
      }
    }
  }

  static Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
          _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      if (androidPlugin != null) {
        await androidPlugin.requestNotificationsPermission();
        await androidPlugin.requestExactAlarmsPermission();
      }
    } else if (Platform.isIOS) {
      final IOSFlutterLocalNotificationsPlugin? iosPlugin =
          _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >();

      if (iosPlugin != null) {
        await iosPlugin.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
    }
  }

  static Future<void> showNotificationFromFCM(RemoteMessage message) async {
    final NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'tyvaa_notifications',
        'Tyvaa Notifications',
        channelDescription: 'Notifications for Tyvaa app',
        importance: Importance.max,
        priority: Priority.max,
        showWhen: true,
        enableVibration: true,
        vibrationPattern: Int64List.fromList([0, 300, 100, 300]),
        enableLights: true,
        ledColor: Color(0xFF6C63FF),
        color: Color(0xFF6C63FF),
        colorized: true,
        icon: '@drawable/ic_notification',
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        styleInformation: BigTextStyleInformation(
          message.notification?.body ?? '',
          htmlFormatBigText: true,
          contentTitle: message.notification?.title ?? 'Tyvaa',
          htmlFormatContentTitle: true,
        ),
        autoCancel: true,
        playSound: true,
        sound: null,
        fullScreenIntent: false,
        category: AndroidNotificationCategory.message,
        visibility: NotificationVisibility.public,
        actions: <AndroidNotificationAction>[
          AndroidNotificationAction(
            'MARK_READ',
            'Mark as Read',
            icon: DrawableResourceAndroidBitmap('@drawable/ic_notification'),
          ),
        ],
        ongoing: false,
        onlyAlertOnce: false,
        when: DateTime.now().millisecondsSinceEpoch,
        usesChronometer: false,
        channelShowBadge: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'default',
        badgeNumber: null,
        categoryIdentifier: 'tyvaa_category',
        interruptionLevel: InterruptionLevel.timeSensitive,
        threadIdentifier: 'tyvaa_notifications',
      ),
    );

    await _notificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'Tyvaa',
      message.notification?.body ?? '',
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  static Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'tyvaa_notifications',
        'Tyvaa Notifications',
        channelDescription: 'Notifications for Tyvaa app',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
        enableLights: true,
        ledColor: Color(0xFF6C63FF),
        color: Color(0xFF6C63FF),
        colorized: true,
        icon: '@drawable/ic_notification',
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        styleInformation: BigTextStyleInformation(''),
        autoCancel: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'default',
        badgeNumber: null,
      ),
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: data != null ? jsonEncode(data) : null,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  static Future<List<ActiveNotification>> getActiveNotifications() async {
    if (Platform.isAndroid) {
      return await _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.getActiveNotifications() ??
          [];
    }
    return [];
  }

  static Future<int> getBadgeCount() async {
    if (Platform.isIOS) {
      return 0;
    }
    return 0;
  }

  static Future<void> setBadgeCount(int count) async {
    print('Setting badge count to: $count');
  }

  static Future<void> showTestNotification() async {
    await showLocalNotification(
      id: 999,
      title: 'Test Notification',
      body: 'This is a test notification with sound and vibration',
    );
  }
}
