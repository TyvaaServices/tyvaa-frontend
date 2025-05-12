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
    isLoading.value = true;
    hasError.value = false;

    try {
      // Get stored notifications from service
      final storedNotifications =
          await _notificationService.getStoredNotifications();

      if (storedNotifications.isNotEmpty) {
        notifications.value = storedNotifications;
      }
      // else {
      //   // Fallback to mock data for demonstration
      //   await Future.delayed(Duration(milliseconds: 800));
      //   notifications.value = [
      //     // NotificationModel(
      //     //   id: '1',
      //     //   title: 'Demande acceptée',
      //     //   message:
      //     //       'Votre demande pour rejoindre le trajet Dakar → Saint-Louis a été acceptée par le conducteur.',
      //     //   type: NotificationType.tripAccepted,
      //     //   time: DateTime.now().subtract(Duration(minutes: 15)),
      //     //   isRead: false,
      //     //   actionData: {'tripId': 'T123', 'driverId': 'D456'},
      //     // ),
      //     // NotificationModel(
      //     //   id: '2',
      //     //   title: 'Nouveau message',
      //     //   message: 'Amadou: À quelle heure comptez-vous arriver à Thiès?',
      //     //   type: NotificationType.message,
      //     //   time: DateTime.now().subtract(Duration(hours: 2)),
      //     //   isRead: false,
      //     //   actionData: {'chatId': 'C789', 'senderId': 'U567'},
      //     // ),
      //     // NotificationModel(
      //     //   id: '3',
      //     //   title: 'Rappel de trajet',
      //     //   message:
      //     //       'Votre trajet vers Mbour démarre dans 2 heures. Préparez-vous!',
      //     //   type: NotificationType.reminder,
      //     //   time: DateTime.now().subtract(Duration(hours: 6)),
      //     //   isRead: true,
      //     //   actionData: {'tripId': 'T456'},
      //     // ),
      //     // NotificationModel(
      //     //   id: '4',
      //     //   title: 'Annulation de trajet',
      //     //   message:
      //     //       'Désolé, le trajet Dakar → Touba du 10 mai a été annulé par le conducteur.',
      //     //   type: NotificationType.tripCancelled,
      //     //   time: DateTime.now().subtract(Duration(days: 1)),
      //     //   isRead: true,
      //     //   actionData: {'tripId': 'T789'},
      //     // ),
      //     // NotificationModel(
      //     //   id: '5',
      //     //   title: 'Promotion spéciale',
      //     //   message:
      //     //       '50% de réduction sur votre prochain trajet! Utilisez le code TYVAA50.',
      //     //   type: NotificationType.promo,
      //     //   time: DateTime.now().subtract(Duration(days: 2)),
      //     //   isRead: true,
      //     //   actionData: {'promoCode': 'TYVAA50'},
      //     // ),
      //   ];
      // }
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

      // Update in storage via service
      _notificationService.markAsRead(notificationId);
    }
  }

  void markAllAsRead() {
    for (var i = 0; i < notifications.length; i++) {
      final notification = notifications[i];
      notification.isRead = true;
      notifications[i] = notification;

      // Update each in storage
      _notificationService.markAsRead(notification.id);
    }
    notifications.refresh();
  }

  void deleteNotification(String notificationId) {
    notifications.removeWhere((n) => n.id == notificationId);
    // TODO: Add method to remove individual notification from storage
  }

  void clearAllNotifications() {
    notifications.clear();
    _notificationService.clearAllNotifications();
  }

  // Method to add a new notification (called from service)
  void addNotification(NotificationModel notification) {
    // Add to the beginning of the list
    notifications.insert(0, notification);
    notifications.refresh();
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
