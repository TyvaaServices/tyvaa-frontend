import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_constants.dart';

class OtpVerificationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final int otpLength = AppConstants.otpLength;
  String correctOtp = AppConstants.demoCorrectOtp;
  final int resendDelaySeconds = AppConstants.otpResendDelaySeconds;

  late List<TextEditingController> digitControllers;
  late List<FocusNode> focusNodes;

  final isVerifying = false.obs;
  final isVerified = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
  final canResend = true.obs;
  final resendCountdown = 0.obs;

  late AnimationController shakeController;
  late Animation<double> shakeAnimation;

  @override
  void onInit() {
    super.onInit();

    digitControllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
    focusNodes.first.requestFocus();

    shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    shakeAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(shakeController);

    for (final node in focusNodes) {
      node.addListener(() => update());
    }
  }

  @override
  void onClose() {
    for (int i = 0; i < otpLength; i++) {
      digitControllers[i].dispose();
      focusNodes[i].dispose();
    }
    shakeController.dispose();
    super.onClose();
  }

  void resetFields() {
    for (final controller in digitControllers) {
      controller.clear();
    }
    focusNodes.first.requestFocus();
  }

  String get completeOtp =>
      digitControllers.map((controller) => controller.text).join();

  bool get isOtpComplete =>
      digitControllers.every((controller) => controller.text.isNotEmpty);

  void verifyOtp() async {
    if (isVerifying.value || !isOtpComplete) return;

    hasError.value = false;
    isVerifying.value = true;

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (completeOtp == correctOtp) {
        isVerified.value = true;
        await Future.delayed(const Duration(milliseconds: 800));
        Get.offAllNamed('/main');
      } else {
        hasError.value = true;
        errorMessage.value = 'Code incorrect. Veuillez réessayer.';
        shakeController.forward().then((_) => shakeController.reset());
        resetFields();
      }
    } catch (_) {
      hasError.value = true;
      errorMessage.value = 'Une erreur est survenue. Réessayez plus tard.';
    } finally {
      isVerifying.value = false;
    }
  }

  void resendOtp() async {
    if (!canResend.value) return;

    canResend.value = false;
    resendCountdown.value = resendDelaySeconds;

    final random = Random();
    correctOtp = List.generate(otpLength, (_) => random.nextInt(9) + 1).join();

    // Affiche un message temporaire contenant le code OTP généré (à supprimer en production)
    Get.snackbar(
      'Votre OTP',
      'Votre code OTP est : $correctOtp',
      backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  void onDigitChanged(String value, int index) {
    if (value.isEmpty) {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    } else {
      if (index < otpLength - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
        if (isOtpComplete) {
          Future.delayed(const Duration(milliseconds: 300), verifyOtp);
        }
      }
    }
  }
}

// Get.snackbar(
//   'Code envoyé',
//   'Un nouveau code a été envoyé à votre numéro WhatsApp',
//   backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
//   colorText: Colors.white,
//   snackPosition: SnackPosition.BOTTOM,
//   margin: const EdgeInsets.all(16),
//   borderRadius: 12,
// );
