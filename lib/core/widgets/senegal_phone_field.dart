import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

/// Custom Senegal phone input with +221 prefix
/// Clean design, no Material bloat
class SenegalPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String hint;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  const SenegalPhoneField({
    super.key,
    required this.controller,
    this.label,
    this.hint = '77 000 00 00',
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textMain,
            ),
          ),
          SizedBox(height: 8.h),
        ],
        Container(
          decoration: BoxDecoration(
            color: Colors
                .white, // Changed from AppColors.background to white for better visibility
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.slate200),
          ),
          child: Row(
            children: [
              // Country Code - Fixed +221
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: AppColors.slate200)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Senegal Flag Emoji
                    Text('🇸🇳', style: TextStyle(fontSize: 20.sp)),
                    SizedBox(width: 8.w),
                    Text(
                      '+221',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMain,
                      ),
                    ),
                  ],
                ),
              ),

              // Phone Number Input
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: enabled,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                    _SenegalPhoneFormatter(),
                  ],
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.slate400,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                  ),
                  onChanged: (value) {
                    onChanged?.call('+221${value.replaceAll(' ', '')}');
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Formats phone number as: 77 000 00 00
class _SenegalPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 5 || i == 7) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
