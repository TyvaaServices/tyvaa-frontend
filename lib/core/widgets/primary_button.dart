import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final double? width;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.width,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width ?? double.infinity,
      height: 60.h,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                // Override style if custom colors provided
                foregroundColor: textColor,
                side: backgroundColor != null
                    ? BorderSide(color: backgroundColor!)
                    : null,
              ),
              child: _buildChild(theme),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: textColor,
              ),
              child: _buildChild(theme),
            ),
    );
  }

  Widget _buildChild(ThemeData theme) {
    if (isLoading) {
      return SizedBox(
        width: 24.w,
        height: 24.w,
        child: CircularProgressIndicator(
          color: isOutlined
              ? (backgroundColor ?? AppColors.primary)
              : (textColor ?? Colors.white),
          strokeWidth: 2.5,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[Icon(icon, size: 20.w), SizedBox(width: 12.w)],
        Text(text),
      ],
    );
  }
}
