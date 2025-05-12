import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart'; // Import for ApiClient
import '../modules/notification/controllers/notification_controller.dart';

class NotificationService extends GetxService {
  static const String NOTIFICATIONS_KEY = 'tyvaa_notifications';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final RxBool isInitialized = false.obs;
  late ApiClient _apiClient; // ApiClient instance

  Future<NotificationService> init() async {
    // Initialize ApiClient
    _apiClient = Get.find<ApiClient>();

    // Request permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // Get FCM token
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    // Save FCM token to your backend using ApiClient
    _saveFCMTokenToBackend(token);

    // Handle background messages in main.dart

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');

        // Convert FCM message to our NotificationModel
        NotificationModel notification = _convertMessageToNotification(message);

        // Store notification
        _storeNotification(notification);

        // Show snackbar
        Get.snackbar(
          message.notification?.title ?? 'New notification',
          message.notification?.body ?? '',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 4),
          borderRadius: 8,
        );

        // Update notification controller if it exists
        if (Get.isRegistered<NotificationController>()) {
          Get.find<NotificationController>().addNotification(notification);
        }
      }
    });

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification tapped in background!');

      if (message.notification != null) {
        // Handle notification tap action
        _handleNotificationTap(message);
      }
    });

    // Check for initial message (app opened from terminated state)
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        print('App opened from terminated state via notification!');
        // Handle notification tap action
        _handleNotificationTap(message);
      }
    });

    isInitialized.value = true;
    return this;
  }

  void _handleNotificationTap(RemoteMessage message) {
    // Convert FCM message to NotificationModel
    NotificationModel notification = _convertMessageToNotification(message);

    // Mark as read
    _markAsRead(notification.id);

    // Navigate based on notification type
    if (message.data.containsKey('route')) {
      final String route = message.data['route'];
      Get.toNamed(route);
    } else if (message.data.containsKey('type')) {
      switch (message.data['type']) {
        case 'tripAccepted':
          Get.toNamed('/trip-details', arguments: message.data['tripId']);
          break;
        case 'message':
          Get.toNamed('/chat', arguments: message.data['chatId']);
          break;
        // Add other navigation cases as needed
      }
    }
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
      final prefs = await SharedPreferences.getInstance();
      List<String> storedNotifications =
          prefs.getStringList(NOTIFICATIONS_KEY) ?? [];

      // Add new notification
      storedNotifications.add(
        jsonEncode({
          'id': notification.id,
          'title': notification.title,
          'message': notification.message,
          'type': notification.type.toString(),
          'time': notification.time.toIso8601String(),
          'isRead': notification.isRead,
          'actionData': notification.actionData,
        }),
      );

      // Limit to 50 notifications to avoid excessive storage
      if (storedNotifications.length > 50) {
        storedNotifications = storedNotifications.sublist(
          storedNotifications.length - 50,
        );
      }

      await prefs.setStringList(NOTIFICATIONS_KEY, storedNotifications);
    } catch (e) {
      print('Error storing notification: $e');
    }
  }

  Future<List<NotificationModel>> getStoredNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? storedNotifications = prefs.getStringList(
        NOTIFICATIONS_KEY,
      );

      if (storedNotifications == null || storedNotifications.isEmpty) {
        return [];
      }

      return storedNotifications.map((jsonString) {
        final Map<String, dynamic> data = jsonDecode(jsonString);
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
      final prefs = await SharedPreferences.getInstance();
      List<String>? storedNotifications = prefs.getStringList(
        NOTIFICATIONS_KEY,
      );

      if (storedNotifications == null) return;

      List<String> updatedNotifications =
          storedNotifications.map((jsonString) {
            final Map<String, dynamic> data = jsonDecode(jsonString);
            if (data['id'] == notificationId) {
              data['isRead'] = true;
            }
            return jsonEncode(data);
          }).toList();

      await prefs.setStringList(NOTIFICATIONS_KEY, updatedNotifications);

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
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(NOTIFICATIONS_KEY);

      // Update controller if available
      if (Get.isRegistered<NotificationController>()) {
        Get.find<NotificationController>().clearAllNotifications();
      }
    } catch (e) {
      print('Error clearing notifications: $e');
    }
  }

  // Save FCM token to your backend server using ApiClient
  void _saveFCMTokenToBackend(String? token) async {
    if (token == null) return;

    try {
      final response = await _apiClient.dio.post(
        '/users/fcm-token',
        data: {
          'token': token,
          'userId':
              'current_user_id', // Replace with actual user ID from storage
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

  Future<void> _markAsRead(String notificationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? storedNotifications = prefs.getStringList(
        NOTIFICATIONS_KEY,
      );

      if (storedNotifications == null) return;

      List<String> updatedNotifications =
          storedNotifications.map((jsonString) {
            final Map<String, dynamic> data = jsonDecode(jsonString);
            if (data['id'] == notificationId) {
              data['isRead'] = true;
            }
            return jsonEncode(data);
          }).toList();

      await prefs.setStringList(NOTIFICATIONS_KEY, updatedNotifications);

      // Update controller if available and notifications screen is open
      if (Get.isRegistered<NotificationController>()) {
        final controller = Get.find<NotificationController>();
        if (controller != null) {
          controller.markAsRead(notificationId);
        }
      }
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }
}
