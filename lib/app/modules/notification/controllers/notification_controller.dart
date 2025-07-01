import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/notification_service.dart';

class NotificationController extends GetxController {
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final isLoading = false.obs;
  final hasError = false.obs;

  late NotificationService _notificationService;

  @override
  void onInit() {
    super.onInit();
    _initializeNotificationService();
    fetchNotifications();
  }

  @override
  void onReady() {
    super.onReady();
    // Force refresh when controller is ready
    print('🔄 Controller: Ready - fetching notifications again...');
    fetchNotifications();
  }

  void _initializeNotificationService() {
    if (Get.isRegistered<NotificationService>()) {
      _notificationService = Get.find<NotificationService>();
    } else {
      _notificationService = Get.put(NotificationService());
      if (!_notificationService.isInitialized.value) {
        _notificationService.init();
      }
    }
  }

  Future<void> fetchNotifications() async {
    print('🔄 Controller: Fetching notifications...');
    isLoading.value = true;
    hasError.value = false;

    try {
      final storedNotifications =
          await _notificationService.getStoredNotifications();

      print(
        '🔄 Controller: Retrieved ${storedNotifications.length} notifications from storage',
      );

      // Always update the notifications list, even if empty
      notifications.value = storedNotifications;
      print(
        '🔄 Controller: Updated notifications list with ${notifications.length} items',
      );
    } catch (e) {
      hasError.value = true;
      print('Error fetching notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  void markAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      final notification = notifications[index];
      notification.isRead = true;
      notifications[index] = notification;
      notifications.refresh();

      _notificationService.markAsRead(notificationId);
    }
  }

  void markAllAsRead() {
    for (var i = 0; i < notifications.length; i++) {
      final notification = notifications[i];
      notification.isRead = true;
      notifications[i] = notification;

      _notificationService.markAsRead(notification.id);
    }
    notifications.refresh();
  }

  void deleteNotification(String notificationId) {
    print('🗑️ Controller: Deleting notification: $notificationId');
    final initialCount = notifications.length;
    notifications.removeWhere((n) => n.id == notificationId);
    final finalCount = notifications.length;
    print(
      '🗑️ Controller: Notifications count changed from $initialCount to $finalCount',
    );

    _notificationService.deleteNotification(notificationId);
  }

  void clearAllNotifications() {
    notifications.clear();
    _notificationService.clearAllNotifications();
  }

  void addNotification(NotificationModel notification) {
    print('🔔 Controller: Adding notification: ${notification.title}');
    notifications.insert(0, notification);
    notifications.refresh();
    print(
      '🔔 Controller: Total notifications after add: ${notifications.length}',
    );
    // Force update
    update();
  }

  // Force refresh method that can be called externally
  void forceRefresh() {
    print('🔄 Controller: Force refresh triggered');
    fetchNotifications();
  }
}

enum NotificationType { message, tripAccepted, tripCancelled, promo, reminder }

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime time;
  bool isRead;
  final Map<String, dynamic> actionData;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.time,
    required this.isRead,
    required this.actionData,
  });

  IconData get icon {
    switch (type) {
      case NotificationType.message:
        return Icons.chat_bubble_outline_rounded;
      case NotificationType.tripAccepted:
        return Icons.check_circle_outline_rounded;
      case NotificationType.tripCancelled:
        return Icons.cancel_outlined;
      case NotificationType.promo:
        return Icons.card_giftcard_rounded;
      case NotificationType.reminder:
        return Icons.access_time_rounded;
    }
  }

  Color get color {
    switch (type) {
      case NotificationType.message:
        return Color(0xFF4ECDC4);
      case NotificationType.tripAccepted:
        return Color(0xFF6C63FF);
      case NotificationType.tripCancelled:
        return Color(0xFFFF6B6B);
      case NotificationType.promo:
        return Color(0xFFFFB347);
      case NotificationType.reminder:
        return Color(0xFF8A6FFF);
    }
  }
}
