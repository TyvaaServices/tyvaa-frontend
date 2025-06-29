import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:passenger_tyvaa/app/repositories/user_repository.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

import '../../../services/connectivity_service.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final phoneMask = MaskTextInputFormatter(
    mask: '+221 ## ### ## ##',
    filter: {"#": RegExp(r'\d')},
  );
  User user = User();

  late AnimationController animationController;
  late Animation<double> fadeInAnimation;

  late ScrollController scrollController;

  var isLoading = false.obs;
  var unmasked = ''.obs;

  bool get hasInput => unmasked.value.isNotEmpty;

  bool get isValid => unmasked.value.length == 9;
  final phoneFocus = FocusNode();

  final _userRepository = UserRepository();
  final _connectivityController = Get.find<ConnectivityController>();
  final _logger = Logger();
  String token = '';

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      phoneFocus.requestFocus();
    });

    void setupKeyboardHandling() {
      phoneFocus.addListener(() {
        if (phoneFocus.hasFocus) {
          Future.delayed(const Duration(milliseconds: 200), () {
            final offset = _calculateOptimalOffset();
            if (scrollController.hasClients) {
              scrollController.animateTo(
                offset,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
              );
            }
          });
        }
      });
    }

    phoneController.addListener(() {
      unmasked.value = phoneMask.getUnmaskedText();
    });
  }

  double _calculateOptimalOffset() {
    return scrollController.position.maxScrollExtent * 1.65;
  }

  @override
  void onClose() {
    animationController.dispose();
    phoneController.dispose();
    scrollController.dispose();
    phoneFocus.dispose();
    super.onClose();
  }

  Future<void> handleLogin() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      if (!_connectivityController.hasInternet.value) {
        Get.snackbar(
          'Pas de connexion internet',
          'Veuillez vérifier votre connexion internet et réessayer.',
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoading.value = false;
        return;
      }

      // Always send the masked phone (with +221) to the repository
      final phone = '+221${unmasked.value}';
      final response = await _userRepository.requestLoginOtp(phone);

      if (response) {
        isLoading.value = false;
        _logger.d('Login OTP requested successfully');
        Get.toNamed(
          '/otp',
          arguments: {'phone': phone, 'isRegistration': false},
        );
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Erreur',
          'Échec de la demande d\'OTP. Vérifiez votre numéro et réessayez.',
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      HapticFeedback.heavyImpact();
      _logger.e('Login error: $e');
      isLoading.value = false;
      String errorMessage = 'Erreur lors de la connexion';
      if (e.toString().contains('400')) {
        errorMessage = 'Numéro de téléphone invalide';
      }
      Get.snackbar(
        'Erreur',
        errorMessage,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
