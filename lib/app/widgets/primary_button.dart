import 'package:flutter/material.dart';

import '../themes/design_system.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final bool isWide; // Marked as final to make it immutable

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.isWide = true, // Adjusted initialization order
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 0 : 24),
      // Removed unnecessary `const`
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? TColors.primary,
          // High-contrast CTA
          foregroundColor: Colors.white,
          elevation: 10,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
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
