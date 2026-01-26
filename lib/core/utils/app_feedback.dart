import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class AppFeedback {
  static void showSuccess(String title, String message) {
    _show(title: title, message: message, type: _FeedbackType.success);
  }

  static void showError(String title, String message) {
    _show(title: title, message: message, type: _FeedbackType.error);
  }

  static void showInfo(String title, String message) {
    _show(title: title, message: message, type: _FeedbackType.info);
  }

  static void _show({
    required String title,
    required String message,
    required _FeedbackType type,
  }) {
    Color mainColor;
    IconData icon;
    Color bgColor;

    switch (type) {
      case _FeedbackType.success:
        mainColor = AppColors.success;
        icon = Icons.check_circle_rounded;
        bgColor = AppColors.success.withValues(alpha: 0.1);
        break;
      case _FeedbackType.error:
        mainColor = AppColors.error;
        icon = Icons.error_rounded;
        bgColor = AppColors.error.withValues(alpha: 0.1);
        break;
      case _FeedbackType.info:
        mainColor = AppColors.info;
        icon = Icons.info_rounded;
        bgColor = AppColors.info.withValues(alpha: 0.1);
        break;
    }

    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    Get.snackbar(
      title,
      message,
      titleText: Text(
        title,
        style: TextStyle(
          color: AppColors.textMain,
          fontWeight: FontWeight.w700,
          fontSize: 16.sp,
          fontFamily: 'Urbanist', // Ensure font consistency
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14.sp,
          fontFamily: 'Urbanist',
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      borderRadius: 16.r,
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      icon: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        child: Icon(icon, color: mainColor, size: 24.w),
      ),
      shouldIconPulse: false,
      barBlur: 0,
      overlayBlur: 0,
      borderColor: AppColors.slate200,
      borderWidth: 1,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 400),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}

enum _FeedbackType { success, error, info }
