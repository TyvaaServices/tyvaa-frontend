import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/messages_controller.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.slate50, // 1. Background
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.slate900),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.conversations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 48.w,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Aucun message",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Vos discussions avec les conducteurs\napparaîtront ici.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.slate500,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          itemCount: controller.conversations.length,
          itemBuilder: (context, index) {
            final chat = controller.conversations[index];
            final isUnread = (chat['unread'] as int) > 0;

            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: isUnread
                    ? Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                        width: 1,
                      )
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => controller.openChat(chat['id']),
                  borderRadius: BorderRadius.circular(16.r),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 28.r,
                              backgroundColor: AppColors.slate100,
                              child:
                                  chat['avatar'] != null &&
                                      chat['avatar'].isNotEmpty
                                  ? ClipOval(child: Image.asset(chat['avatar']))
                                  : Text(
                                      chat['name']
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: AppColors.slate700,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                            ),
                            if (isUnread)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 12.w,
                                  height: 12.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    chat['name'],
                                    style: TextStyle(
                                      fontWeight: isUnread
                                          ? FontWeight.w800
                                          : FontWeight.w700,
                                      fontSize: 16.sp,
                                      color: AppColors.slate900,
                                    ),
                                  ),
                                  Text(
                                    chat['time'],
                                    style: TextStyle(
                                      color: isUnread
                                          ? AppColors.primary
                                          : AppColors.slate400,
                                      fontSize: 12.sp,
                                      fontWeight: isUnread
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                chat['lastMessage'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isUnread
                                      ? AppColors.slate800
                                      : AppColors.slate500,
                                  fontWeight: isUnread
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
