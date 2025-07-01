import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/user.dart';
import '../api/api_client.dart';
import '../modules/notification/controllers/notification_controller.dart';
import 'local_notification_service.dart';

class NotificationService extends GetxService {
  static const String NOTIFICATIONS_KEY = 'tyvaa_notifications';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final RxBool isInitialized = false.obs;
  late ApiClient _apiClient;
  User? user;

  Future<NotificationService> init() async {
    print('🔔 Initializing NotificationService...');

    // Initialize local notifications first
    LocalNotificationService.initialize();
    await LocalNotificationService.createNotificationChannel();

    // Initialize ApiClient
    _apiClient = Get.find<ApiClient>();
    user = Hive.box<User>('users').get('currentUser');

    // Request permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      criticalAlert: false,
      carPlay: false,
      announcement: false,
    );

    print('🔔 User granted permission: ${settings.authorizationStatus}');

    // Also request local notification permissions
    await _requestLocalNotificationPermissions();

    // Get FCM token
    String? token = await _firebaseMessaging.getToken();
    print('🔔 FCM Token obtained: $token');
    if (token != null) {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'fcm_token', value: token);
      print('🔔 FCM Token saved to secure storage');
      _saveFCMTokenToBackend(token);
    } else {
      print('❌ Failed to get FCM token');
    }

    // Handle token refresh
    _firebaseMessaging.onTokenRefresh.listen((String token) {
      print('🔔 FCM Token refreshed: $token');
      const storage = FlutterSecureStorage();
      storage.write(key: 'fcm_token', value: token);
      _saveFCMTokenToBackend(token);
    });

    // Set up message handlers
    _setupMessageHandlers();

    isInitialized.value = true;
    print('🔔 NotificationService initialized successfully');
    return this;
  }

  Future<void> _requestLocalNotificationPermissions() async {
    try {
      await LocalNotificationService.requestPermissions();
    } catch (e) {
      print('Error requesting local notification permissions: $e');
    }
  }

  void _setupMessageHandlers() {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('🔔 =============== FOREGROUND MESSAGE RECEIVED ===============');
      print('🔔 Message ID: ${message.messageId}');
      print('🔔 From: ${message.from}');
      print('🔔 Data: ${message.data}');
      print('🔔 Notification Title: ${message.notification?.title}');
      print('🔔 Notification Body: ${message.notification?.body}');
      print('🔔 ======================================================');

      if (message.notification != null) {
        // Store notification
        final notification = _convertMessageToNotification(message);
        _storeNotification(notification);

        // Show local notification with enhanced settings for foreground
        LocalNotificationService.showNotificationFromFCM(message);

        // Update in-app notification list if controller exists
        if (Get.isRegistered<NotificationController>()) {
          final controller = Get.find<NotificationController>();
          controller.addNotification(notification);
          print(
            '🔔 Notification added to in-app list. Total: ${controller.notifications.length}',
          );
        }

        print('🔔 Foreground notification processed');
      } else {
        print('⚠️ Message received but no notification payload found');
        print('⚠️ Data-only message: ${message.data}');
      }
    });

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('🔔 Notification tapped in background!');
      _handleNotificationTap(message);
    });

    // Check for initial message (app opened from terminated state)
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        print('🔔 App opened from terminated state via notification!');
        _handleNotificationTap(message);
      }
    });
  }

  void _handleNotificationTap(RemoteMessage message) {
    // Convert FCM message to NotificationModel and mark as read
    final notification = _convertMessageToNotification(message);
    markAsRead(notification.id);

    // Handle navigation based on notification data
    LocalNotificationService.handleNotificationTap(jsonEncode(message.data));
  }

  NotificationModel _convertMessageToNotification(RemoteMessage message) {
    NotificationType type = NotificationType.reminder; // Default

    // Determine notification type from data
    if (message.data.containsKey('type')) {
      switch (message.data['type']) {
        case 'message':
          type = NotificationType.message;
          break;
        case 'tripAccepted':
          type = NotificationType.tripAccepted;
          break;
        case 'tripCancelled':
          type = NotificationType.tripCancelled;
          break;
        case 'promo':
          type = NotificationType.promo;
          break;
        case 'reminder':
          type = NotificationType.reminder;
          break;
      }
    }

    return NotificationModel(
      id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ?? 'New notification',
      message: message.notification?.body ?? '',
      type: type,
      time: DateTime.now(),
      isRead: false,
      actionData: message.data,
    );
  }

  Future<void> _storeNotification(NotificationModel notification) async {
    try {
      const storage = FlutterSecureStorage();

      // Get existing notifications from secure storage
      String? existingNotificationsJson = await storage.read(
        key: NOTIFICATIONS_KEY,
      );
      List<dynamic> storedNotifications = [];

      if (existingNotificationsJson != null) {
        storedNotifications = jsonDecode(existingNotificationsJson);
      }

      // Add new notification
      storedNotifications.add({
        'id': notification.id,
        'title': notification.title,
        'message': notification.message,
        'type': notification.type.toString(),
        'time': notification.time.toIso8601String(),
        'isRead': notification.isRead,
        'actionData': notification.actionData,
      });

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
    } catch (e) {
      print('Error storing notification: $e');
    }
  }

  Future<List<NotificationModel>> getStoredNotifications() async {
    try {
      const storage = FlutterSecureStorage();
      String? notificationsJson = await storage.read(key: NOTIFICATIONS_KEY);

      if (notificationsJson == null || notificationsJson.isEmpty) {
        return [];
      }

      List<dynamic> storedNotifications = jsonDecode(notificationsJson);

      return storedNotifications.map((data) {
        return NotificationModel(
          id: data['id'],
          title: data['title'],
          message: data['message'],
          type: _getTypeFromString(data['type']),
          time: DateTime.parse(data['time']),
          isRead: data['isRead'] ?? false,
          actionData: data['actionData'] ?? {},
        );
      }).toList();
    } catch (e) {
      print('Error loading notifications: $e');
      return [];
    }
  }

  NotificationType _getTypeFromString(String typeStr) {
    switch (typeStr) {
      case 'NotificationType.message':
        return NotificationType.message;
      case 'NotificationType.tripAccepted':
        return NotificationType.tripAccepted;
      case 'NotificationType.tripCancelled':
        return NotificationType.tripCancelled;
      case 'NotificationType.promo':
        return NotificationType.promo;
      default:
        return NotificationType.reminder;
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      const storage = FlutterSecureStorage();
      String? notificationsJson = await storage.read(key: NOTIFICATIONS_KEY);

      if (notificationsJson == null) return;

      List<dynamic> storedNotifications = jsonDecode(notificationsJson);

      // Update the specific notification
      for (var notification in storedNotifications) {
        if (notification['id'] == notificationId) {
          notification['isRead'] = true;
          break;
        }
      }

      // Store back to secure storage
      await storage.write(
        key: NOTIFICATIONS_KEY,
        value: jsonEncode(storedNotifications),
      );

      // Update controller if available
      if (Get.isRegistered<NotificationController>()) {
        Get.find<NotificationController>().markAsRead(notificationId);
      }
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }

  Future<void> clearAllNotifications() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.delete(key: NOTIFICATIONS_KEY);

      // Update controller if available
      if (Get.isRegistered<NotificationController>()) {
        Get.find<NotificationController>().clearAllNotifications();
      }
    } catch (e) {
      print('Error clearing notifications: $e');
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      const storage = FlutterSecureStorage();
      String? notificationsJson = await storage.read(key: NOTIFICATIONS_KEY);

      if (notificationsJson == null) return;

      List<dynamic> storedNotifications = jsonDecode(notificationsJson);

      // Remove the specific notification
      storedNotifications.removeWhere(
        (notification) => notification['id'] == notificationId,
      );

      // Store back to secure storage
      await storage.write(
        key: NOTIFICATIONS_KEY,
        value: jsonEncode(storedNotifications),
      );
      print('🗑️ Notification deleted from storage: $notificationId');
    } catch (e) {
      print('Error deleting notification: $e');
    }
  }

  // Save FCM token to your backend server using ApiClient
  void _saveFCMTokenToBackend(String? token) async {
    if (token == null) return;

    try {
      final response = await _apiClient.dio.post(
        '/users/${user!.id}/fcm-token',
        data: {
          'fcmToken': token, // Replace with actual user ID from storage
        },
      );

      if (response.statusCode == 200) {
        print('FCM token successfully saved to backend');
      } else {
        print('Failed to save FCM token: ${response.data}');
      }
    } on DioException catch (e) {
      print('DioError saving FCM token: ${e.message}');
      if (e.response != null) {
        print('Error response: ${e.response?.data}');
      }
    } catch (e) {
      print('Error saving FCM token: $e');
    }
  }
}
