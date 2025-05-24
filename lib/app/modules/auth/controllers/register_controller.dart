import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:passenger_tyvaa/app/api/api_client.dart';
import 'package:passenger_tyvaa/app/repositories/user_repository.dart';
import 'package:passenger_tyvaa/app/services/connectivity_service.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneFocus = FocusNode();
  var otp = '';
  var token = '';

  final isLoading = false.obs;
  final unmasked = ''.obs;
  final isDriver = false.obs;
  final hasInput = false.obs;
  final isValid = false.obs;

  // Reference to our repositories and services
  final _userRepository = UserRepository();
  final _apiClient = Get.find<ApiClient>();
  final _connectivityController = Get.find<ConnectivityController>();

  late AnimationController animationController;
  late Animation<double> fadeInAnimation;
  late ScrollController scrollController;

  final phoneMask = MaskTextInputFormatter(
    mask: '+221 ## ### ## ##',
    filter: {"#": RegExp(r'\d')},
  );

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      phoneFocus.requestFocus();
    });

    phoneFocus.addListener(() {
      if (phoneFocus.hasFocus) {
        Future.delayed(const Duration(milliseconds: 400), () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent + 100,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });

    phoneController.addListener(() {
      unmasked.value = phoneMask.getUnmaskedText();
      hasInput.value = unmasked.value.isNotEmpty;
      isValid.value = unmasked.value.length == 9;
    });
  }

  void handleRegister() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    final fullName = nameController.text;
    final phoneNumber = unmasked.value;

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

      // Online registration flow
      final registerResult = await _apiClient.registerUser(
        fullName,
        phoneNumber,
        isDriver: isDriver.value,
      );

      if (registerResult != null) {
        // Extract OTP and token from registration result
        otp = registerResult['otp'];
        token = registerResult['token'];

        // Save user using repository
        final user = User.fromJson(registerResult['user']);
        await _userRepository.saveUser(user);

        isLoading.value = false;
        // Navigate to OTP screen with required data
        Get.offAllNamed('/otp', arguments: [otp, token]);
        return;
      } else {
        // Server registration failed
        Get.snackbar(
          'Erreur',
          'Échec de l\'inscription sur le serveur. Réessayez plus tard.',
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur inattendue s\'est produite: $e',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    animationController.dispose();
    scrollController.dispose();
    phoneFocus.dispose();
    super.onClose();
  }
}
