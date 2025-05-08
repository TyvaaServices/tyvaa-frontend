// lib/app/ui/otp_verification_screen.dart

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/auth/controllers/login_controller.dart';

import '../controllers/otp_controller.dart';

class OtpVerificationScreen extends GetView<OtpVerificationController> {
  OtpVerificationScreen({Key? key}) : super(key: key);
  LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    // Get theme and screen metrics
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDark = theme.brightness == Brightness.dark;

    // Define colors based on theme
    final backgroundColor = theme.scaffoldBackgroundColor;
    final cardColor = theme.cardColor;
    final primaryColor = theme.primaryColor;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final secondaryTextColor = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: textColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Vérification',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Illustration
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      isDark
                          ? 'assets/otp_illustration.png'
                          : 'assets/otp_illustration.png',
                      width: size.width * 0.6,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Header and instructions
                Text(
                  'Code de vérification',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                Text(
                  'Nous avons envoyé un code à 6 chiffres à votre\nnuméro ${loginController.phoneController.text} sur WhatsApp',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: secondaryTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // OTP Input Section
                GetBuilder<OtpVerificationController>(
                  builder:
                      (_) => AnimatedBuilder(
                        animation: controller.shakeAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              controller.shakeController.value *
                                  sin(
                                    controller.shakeController.value * 3 * pi,
                                  ),
                              0.0,
                            ),
                            child: child,
                          );
                        },
                        child: Obx(
                          () => AbsorbPointer(
                            absorbing: controller.isVerifying.value,
                            child: _buildOtpDigitRow(
                              context: context,
                              controller: controller,
                              theme: theme,
                              primaryColor: primaryColor,
                              textColor: textColor,
                            ),
                          ),
                        ),
                      ),
                ),

                const SizedBox(height: 16),

                // Error message
                Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        controller.hasError.value
                            ? Container(
                              key: const ValueKey('error'),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                controller.errorMessage.value,
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                            : const SizedBox(
                              key: ValueKey('no_error'),
                              height: 36,
                            ),
                  ),
                ),

                const SizedBox(height: 40),

                // Verify button
                Obx(
                  () => AnimatedOpacity(
                    opacity: controller.isOtpComplete ? 1.0 : 0.6,
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed:
                            controller.isOtpComplete &&
                                    !controller.isVerifying.value
                                ? controller.verifyOtp
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          shadowColor: primaryColor.withOpacity(0.3),
                        ),
                        child:
                            controller.isVerifying.value
                                ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Text(
                                  'Vérifier',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Resend code option
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          'Vous n\'avez pas reçu de code?',
                          style: TextStyle(color: secondaryTextColor),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      TextButton(
                        onPressed:
                            controller.canResend.value
                                ? controller.resendOtp
                                : null,
                        child: Text(
                          controller.canResend.value
                              ? 'Renvoyer'
                              : 'Renvoyer dans ${controller.resendCountdown.value}s',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
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
  }

  // Build the row of OTP digit input fields
  Widget _buildOtpDigitRow({
    required BuildContext context,
    required OtpVerificationController controller,
    required ThemeData theme,
    required Color primaryColor,
    required Color textColor,
  }) {
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final digitWidth = (size.width - 80) / controller.otpLength;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.otpLength,
        (index) => Container(
          width: digitWidth > 50 ? 50 : digitWidth,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                controller.focusNodes[index].hasFocus
                    ? primaryColor.withOpacity(0.1)
                    : isDark
                    ? Colors.grey[800]!.withOpacity(0.5)
                    : Colors.grey[200]!,
                controller.focusNodes[index].hasFocus
                    ? primaryColor.withOpacity(0.05)
                    : isDark
                    ? Colors.grey[900]!
                    : Colors.grey[100]!,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  controller.focusNodes[index].hasFocus
                      ? primaryColor
                      : controller.digitControllers[index].text.isNotEmpty
                      ? primaryColor.withOpacity(0.3)
                      : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    controller.focusNodes[index].hasFocus
                        ? primaryColor.withOpacity(0.2)
                        : Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Focus(
            onKey: (node, event) {
              if (event.logicalKey == LogicalKeyboardKey.backspace &&
                  event is RawKeyDownEvent &&
                  controller.digitControllers[index].text.isEmpty &&
                  index > 0) {
                controller.focusNodes[index - 1].requestFocus();
                controller.digitControllers[index - 1].clear();
              }
              return KeyEventResult.ignored;
            },
            child: TextField(
              controller: controller.digitControllers[index],
              focusNode: controller.focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              showCursor: false,
              enableInteractiveSelection: false,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              maxLength: 1,
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) => controller.onDigitChanged(value, index),
            ),
          ),
        ),
      ),
    );
  }
}
