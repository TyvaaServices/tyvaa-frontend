import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:passenger_tyvaa/app/repositories/user_repository.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

import '../../../api/api_client.dart';
import '../../../services/connectivity_service.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final phoneMask = MaskTextInputFormatter(
    mask: '+221 ## ### ## ##',
    filter: {"#": RegExp(r'\d')},
  );

  late AnimationController animationController;
  late Animation<double> fadeInAnimation;

  late ScrollController scrollController;

  var isLoading = false.obs;
  var unmasked = ''.obs;

  bool get hasInput => unmasked.value.isNotEmpty;

  bool get isValid => unmasked.value.length == 9;
  final phoneFocus = FocusNode();

  final _apiClient = Get.find<ApiClient>();
  final _userRepository = UserRepository();
  final _connectivityController = Get.find<ConnectivityController>();
  final _logger = Logger();

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
        // No internet connection, show error message
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

      // Online login flow
      final response = await _apiClient.loginUser(unmasked.value);

      if (response == null) {
        isLoading.value = false;
        Get.snackbar(
          'Erreur',
          'Échec de connexion. Vérifiez votre numéro et réessayez.',
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
        return;
      }

      // Save user to local storage using repository
      final user = User.fromJson(response['user']);
      await _userRepository.saveUser(user);
      _logger.d('User saved to local storage after login: ${user.fullName}');

      isLoading.value = false;
      // Navigate to OTP verification
      Get.toNamed('/otp', arguments: [response['otp'], response['token']]);
    } catch (e) {
      HapticFeedback.heavyImpact();
      _logger.e('Login error: $e');
      isLoading.value = false;
      Get.snackbar(
        'Erreur',
        'Erreur lors de la connexion: $e',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }
}
