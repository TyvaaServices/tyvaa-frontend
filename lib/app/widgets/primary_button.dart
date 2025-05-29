import 'package:flutter/material.dart';

import '../themes/design_system.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final bool isWide;
  final Widget? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.isWide = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 0 : 24),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? TColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: TColors.neutral400,
          elevation: 10,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child:
            icon != null
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon!,
                    const SizedBox(width: 8),
                    Text(
                      text,
                      style: TTextStyles.buttonStatic.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                : Text(
                  text,
                  style: TTextStyles.buttonStatic.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }
}
