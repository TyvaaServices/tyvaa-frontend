import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final TextAlign textAlign;
  final TextStyle? style;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          textAlign: textAlign,
          style: style ?? theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: prefixIcon,
                  )
                : null,
            prefixIconConstraints: BoxConstraints(minWidth: 40.w),
            suffixIcon: suffixIcon,
            // Uses theme.inputDecorationTheme automatically
          ),
        ),
      ],
    );
  }
}
