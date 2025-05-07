import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TypingIndicator extends StatelessWidget {
  final Color botColor;

  const TypingIndicator({super.key, required this.botColor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      // Aligns the indicator to the bottom-left of the screen
      child: Container(
        width: 80,
        margin: EdgeInsets.symmetric(vertical: 8),
        // Adds margin around the indicator
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: botColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: botColor.withOpacity(0.3), width: 1.5),
        ),
        child: SpinKitThreeBounce(
          color: botColor,
          size: 16, // The size of the typing indicator
        ),
      ),
    );
  }
}
