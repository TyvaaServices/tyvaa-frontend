import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// We can remove this later if we strictly don't use it, but I'll write a pure native one.
import '../theme/app_colors.dart';

/// A custom, high-performance OTP field that uses a single invisible TextField
/// to handle input, ensuring perfect keyboard behavior and no focus jumping issues.
class CustomOtpField extends StatefulWidget {
  final TextEditingController controller;
  final int length;
  final ValueChanged<String>? onCompleted;

  const CustomOtpField({
    super.key,
    required this.controller,
    this.length = 6,
    this.onCompleted,
  });

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Invisible Native Input (Handles focus, paste, deletion)
        SizedBox(
          width: double.infinity,
          height: 60.h,
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(widget.length),
            ],
            // Make it invisible but tappable
            showCursor: false,
            enableSuggestions: false,
            autocorrect: false,
            autofocus: true, // Auto-focus when screen opens
            style: const TextStyle(color: Colors.transparent),
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              counterText: '',
              fillColor: Colors.transparent,
              filled: true,
            ),
            onChanged: (value) {
              setState(() {}); // Rebuild visual boxes
              if (value.length == widget.length) {
                widget.onCompleted?.call(value);
              }
            },
          ),
        ),

        // 2. Visual Representation (The Boxes)
        Positioned.fill(
          child: GestureDetector(
            onTap: () => _focusNode.requestFocus(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.length, (index) {
                final text = widget.controller.text;
                final isFilled = index < text.length;
                final isFocused = index == text.length && _focusNode.hasFocus;
                final char = isFilled ? text[index] : '';

                return _buildDigitBox(char, isFilled, isFocused);
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDigitBox(String char, bool isFilled, bool isFocused) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 48.w, // Adjusted for 6 digits on typical screen width
      height: 60.h,
      decoration: BoxDecoration(
        color: isFilled ? Colors.white : AppColors.slate50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isFocused
              ? AppColors.primary
              : (isFilled ? AppColors.slate300 : AppColors.slate200),
          width: isFocused ? 2 : 1,
        ),
        boxShadow: isFocused
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Center(
        child: isFocused
            ? _buildCursor()
            : Text(
                char,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMain,
                ),
              ),
      ),
    );
  }

  Widget _buildCursor() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: (value * 2).floor().isEven ? 1 : 0,
          child: Container(
            width: 2.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        );
      },
      onEnd:
          () {}, // Loop handled by parent rebuild or could be infinite controller
    );
  }
}
