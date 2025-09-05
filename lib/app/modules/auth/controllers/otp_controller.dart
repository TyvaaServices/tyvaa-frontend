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
    _logger.d('=== verifyOtp method called ===');

    try {
      if (isVerifying.value || !isOtpComplete) {
        _logger.d(
          'Early return - isVerifying: ${isVerifying.value}, isOtpComplete: $isOtpComplete',
        );
        return;
      }

      isVerifying.value = true;
      hasError.value = false;
      errorMessage.value = '';

      _logger.d('Starting verification process...');

      final isRegistration = Get.arguments?['isRegistration'] ?? false;
      _logger.d('Raw Get.arguments: ${Get.arguments}');
      _logger.d('isRegistration value: $isRegistration');
      _logger.d('isRegistration type: ${isRegistration.runtimeType}');

      _logger.d(
        'Starting OTP verification - isRegistration: $isRegistration, phone: $phoneNumber, otp: $completeOtp',
      );

      if (isRegistration) {
        _logger.d('Taking REGISTRATION branch');
        final user = Get.arguments?['user'];
        _logger.d('Registration flow - user data: ${user?.toJson()}');
        final success = await _userRepository.createUser(
          user: user.toJson(),
          otp: completeOtp,
        );
        _logger.d('Registration result: $success');
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
        _logger.d('Taking LOGIN branch');
        _logger.d(
          'Login flow - starting OTP verification for phone: $phoneNumber',
        );

        try {
          final success = await _userRepository.verifyOtp(
            phone: phoneNumber,
            otp: completeOtp,
          );
          _logger.d('Login OTP verification result: $success');

          if (success) {
            // Login OTP verified: Add a small delay to ensure user data is fully saved
            isVerified.value = true;
            _logger.d(
              'OTP verification successful, waiting before navigation...',
            );

            // Wait a moment to ensure user data is fully saved to Hive
            await Future.delayed(const Duration(milliseconds: 500));

            // Verify user was actually saved before navigating
            final userRepo = UserRepository();
            final savedUser = userRepo.getCurrentUser();
            _logger.d(
              'Current user after verification: ${savedUser?.toJson()}',
            );

            final needsPermission = await _needsLocationPermission();
            if (needsPermission) {
              _logger.d('Navigating to location permission screen');
              Get.offAllNamed('/location-permission');
            } else {
              _logger.d('Navigating to main screen');
              Get.offAllNamed('/main');
            }
          } else {
            _logger.e('OTP verification failed');
            hasError.value = true;
            errorMessage.value = 'Invalid OTP. Please try again.';
            _shakeError();
          }
        } catch (verifyError) {
          _logger.e('Error during UserRepository.verifyOtp: $verifyError');
          hasError.value = true;
          errorMessage.value = 'Verification failed. Please try again.';
          _shakeError();
        }
      }
    } catch (e, stackTrace) {
      _logger.e('Top-level error in verifyOtp: $e');
      _logger.e('Stack trace: $stackTrace');
      hasError.value = true;
      errorMessage.value = 'An error occurred. Please try again later.';
      _shakeError();
    } finally {
      _logger.d('Setting isVerifying to false');
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
    _logger.d(
      'onDigitChanged called - value: "$value", index: $index, isOtpComplete after: $isOtpComplete',
    );

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
          _logger.d('OTP is complete, scheduling verification in 300ms...');
          Future.delayed(const Duration(milliseconds: 300), () {
            _logger.d('About to call verifyOtp from onDigitChanged');
            verifyOtp();
          });
        }
      }
    }
  }
}
