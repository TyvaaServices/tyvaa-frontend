import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';

import '../controllers/notification_controller.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'notifications'.tr,
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textColor,
            size: 22,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(
            () =>
                controller.notifications.isNotEmpty
                    ? PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, color: AppColors.textColor),
                      onSelected: (value) {
                        if (value == 'markAllRead') {
                          controller.markAllAsRead();
                        } else if (value == 'clearAll') {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text('delete_notifications'.tr),
                                  content: Text('delete_confirmation'.tr),
                                  actions: [
                                    TextButton(
                                      child: Text('cancel'.tr),
                                      onPressed:
                                          () => Navigator.of(context).pop(),
                                    ),
                                    TextButton(
                                      child: Text('delete'.tr),
                                      onPressed: () {
                                        controller.clearAllNotifications();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                          );
                        }
                      },
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              value: 'markAllRead',
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle_outline, size: 20),
                                  SizedBox(width: 10),
                                  Text('Marquer tout comme lu'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'clearAll',
                              child: Row(
                                children: [
                                  Icon(Icons.delete_outline, size: 20),
                                  SizedBox(width: 10),
                                  Text('Supprimer tout'),
                                ],
                              ),
                            ),
                          ],
                    )
                    : SizedBox(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
            ),
          );
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 60,
                  color: Color(0xFFFF6B6B),
                ),
                SizedBox(height: 16),
                Text(
                  'retry'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => controller.fetchNotifications(),
                  child: Text('Réessayer'),
                ),
              ],
            ),
          );
        }

        if (controller.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF6C63FF).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_off_outlined,
                    size: 50,
                    color: Color(0xFF6C63FF),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'no_notifications'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'no_notifications_message'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textColor.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => controller.fetchNotifications(),
                  child: Text('refresh'.tr),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: Color(0xFF6C63FF),
          onRefresh: () => controller.fetchNotifications(),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            itemCount: controller.notifications.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              final notification = controller.notifications[index];
              return Dismissible(
                key: Key(notification.id),
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFF6B6B),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.delete_outline, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'delete_notification'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  controller.deleteNotification(notification.id);
                },
                child: _buildNotificationCard(
                  notification,
                  AppColors.surfaceColor,
                  AppColors.textColor,
                  AppColors.isDark,
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildNotificationCard(
    NotificationModel notification,
    Color surfaceColor,
    Color textColor,
    bool isDark,
  ) {
    return GestureDetector(
      onTap: () {
        controller.markAsRead(notification.id);

        //TODO
        // Example navigation based on notification type
        // In a real app, you'd use the actionData to navigate
        switch (notification.type) {
          case NotificationType.message:
            Get.snackbar(
              'Navigation',
              'Naviguer vers la conversation',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Color(0xFF4ECDC4),
              colorText: Colors.white,
            );
            break;
          case NotificationType.tripAccepted:
            Get.snackbar(
              'Navigation',
              'Naviguer vers les détails du trajet',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Color(0xFF6C63FF),
              colorText: Colors.white,
            );
            break;
          default:
            break;
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
          border:
              notification.isRead
                  ? null
                  : Border.all(color: notification.color, width: 1.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: notification.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                notification.icon,
                color: notification.color,
                size: 22,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              notification.isRead
                                  ? FontWeight.w500
                                  : FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: notification.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    notification.message,
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor.withOpacity(0.7),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatTime(notification.time),
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (!notification.isRead)
                        GestureDetector(
                          onTap: () => controller.markAsRead(notification.id),
                          child: Text(
                            'mark_as_read'.tr,
                            style: TextStyle(
                              fontSize: 12,
                              color: notification.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return 'days_ago'.trParams({'days': difference.inDays.toString()});
    } else if (difference.inHours > 0) {
      return 'hours_ago'.trParams({'hours': difference.inHours.toString()});
    } else if (difference.inMinutes > 0) {
      return 'minutes_ago'.trParams({
        'minutes': difference.inMinutes.toString(),
      });
    } else {
      return 'just_now'.tr;
    }
  }
}
