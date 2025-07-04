import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../constants/app_constants.dart';
import '../../../repositories/user_repository.dart';

class OtpVerificationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final int otpLength = AppConstants.otpLength;
  String phoneNumber = "";
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

  final _userRepository = UserRepository();
  final _secureStorage = const FlutterSecureStorage();
  final _logger = Logger();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      phoneNumber = Get.arguments['phone'] ?? '';
      _logger.d(Get.arguments);
      print(Get.arguments);
      debugPrint("Phone number for OTP verification: $phoneNumber");
    }

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

    isVerifying.value = true;
    hasError.value = false;
    errorMessage.value = '';

    try {
      final isRegistration = Get.arguments?['isRegistration'] ?? false;
      if (isRegistration) {
        final user = Get.arguments?['user'];
        final success = await _userRepository.createUser(
          user: user.toJson(),
          otp: completeOtp,
        );
        if (success) {
          isVerified.value = true;
          final needsPermission = await _needsLocationPermission();
          if (needsPermission) {
            Get.offAllNamed('/location-permission');
          } else {
            Get.offAllNamed('/main');
          }
        } else {
          hasError.value = true;
          errorMessage.value = 'Registration failed. Please try again.';
          _shakeError();
        }
      } else {
        final success = await _userRepository.verifyOtp(
          phone: phoneNumber,
          otp: completeOtp,
        );
        if (success) {
          // Login OTP verified: you may want to fetch user data here if needed
          isVerified.value = true;
          final needsPermission = await _needsLocationPermission();
          if (needsPermission) {
            Get.offAllNamed('/location-permission');
          } else {
            Get.offAllNamed('/main');
          }
        } else {
          hasError.value = true;
          errorMessage.value = 'Invalid OTP. Please try again.';
          _shakeError();
        }
      }
    } catch (e) {
      _logger.e('OTP verification error: $e');
      hasError.value = true;
      errorMessage.value = 'An error occurred. Please try again later.';
      _shakeError();
    } finally {
      isVerifying.value = false;
    }
  }

  // Check if location permission is needed without requesting it
  Future<bool> _needsLocationPermission() async {
    final permissionStatus = await Geolocator.checkPermission();
    final locationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    return permissionStatus == LocationPermission.denied ||
        permissionStatus == LocationPermission.deniedForever ||
        !locationServiceEnabled;
  }

  void _shakeError() {
    shakeController.reset();
    shakeController.forward();
  }

  void resendOtp() async {
    if (!canResend.value) return;

    canResend.value = false;
    resendCountdown.value = resendDelaySeconds;

    try {
      final isRegistration = Get.arguments?['isRegistration'] ?? false;
      final success = await _userRepository.resendOtp(
        phoneNumber: phoneNumber,
        isRegistration: isRegistration,
      );
      if (success) {
        Get.snackbar(
          'OTP Sent',
          'A new OTP has been sent to your phone',
          backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to resend OTP. Please try again.',
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
        canResend.value = true;
        return;
      }
    } catch (e) {
      _logger.e('Resend OTP error: $e');
      Get.snackbar(
        'Error',
        'Failed to resend OTP. Please try again.',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      canResend.value = true;
      return;
    }

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
