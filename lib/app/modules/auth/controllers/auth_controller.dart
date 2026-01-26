import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_feedback.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final IAuthRepository _authRepository;

  AuthController(this._authRepository);

  // Controllers
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController(); // Just text for now or helper

  // State
  final currentStep =
      0.obs; // 0: Phone, 1: OTP, 2: Name, 3: Email, 4: DOB/Gender
  final totalSteps = 5;
  final isLoading = false.obs;
  final selectedGender = RxnString();
  final isLoginMode = true.obs; // Detected after phone check

  // Step 0: Submit Phone
  Future<void> submitPhone() async {
    if (phoneController.text.length < 9) {
      AppFeedback.showError(
        'Numéro invalide',
        'Veuillez entrer un numéro correct (9 chiffres).',
      );
      return;
    }

    isLoading.value = true;
    try {
      // Mock check: In real app, check if phone exists to determine flow
      // For now, we assume everyone goes through OTP first
      await _authRepository.sendOtp(phoneController.text);
      currentStep.value = 1; // Go to OTP
    } catch (e) {
      AppFeedback.showError('Erreur', 'Impossible d\'envoyer le code.');
    } finally {
      isLoading.value = false;
    }
  }

  // Step 1: Verify OTP
  Future<void> verifyOtp() async {
    if (otpController.text.length < 6) return;

    isLoading.value = true;
    try {
      final user = await _authRepository.verifyOtp(
        phoneController.text,
        otpController.text,
      );
      if (user != null) {
        // Mock logic: If user has no name, it's a new registration -> Go to Step 2
        // If user has name -> Login success
        if (user.fullName.isEmpty) {
          isLoginMode.value = false;
          currentStep.value = 2; // Go to Name
        } else {
          Get.offAllNamed(Routes.DASHBOARD);
        }
      } else {
        AppFeedback.showError('Code invalide', 'Le code est incorrect.');
      }
    } catch (e) {
      AppFeedback.showError('Erreur', 'Vérification échouée.');
    } finally {
      isLoading.value = false;
    }
  }

  // Step 2: Name
  void submitName() {
    if (firstNameController.text.isEmpty || lastNameController.text.isEmpty) {
      AppFeedback.showError('Oups', 'Veuillez remplir votre nom et prénom.');
      return;
    }
    currentStep.value = 3;
  }

  // Step 3: Email
  void submitEmail() {
    // Optional or Regex check
    currentStep.value = 4;
  }

  // Step 4: DOB & Gender (Final)
  Future<void> completeRegistration() async {
    if (dobController.text.isEmpty || selectedGender.value == null) {
      AppFeedback.showError('Oups', 'Date de naissance et genre requis.');
      return;
    }

    isLoading.value = true;
    try {
      // Update User Profile with all collected data
      // final fullName = "${firstNameController.text} ${lastNameController.text}";
      // Mock Update:
      // await _authRepository.updateProfile(...);

      Get.offAllNamed(Routes.DASHBOARD);
      AppFeedback.showSuccess(
        "Bienvenue !",
        "Votre compte a été créé avec succès.",
      );
    } catch (e) {
      AppFeedback.showError(
        'Erreur',
        'Impossible de finaliser l\'inscription.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void prevStep() {
    if (currentStep.value > 0) {
      // If we are at Step 2 (Name) and it was a login flow initially, maybe go back to phone?
      // For simplified logic:
      currentStep.value--;
    }
  }
}
