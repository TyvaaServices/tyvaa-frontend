import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';

import '../../../../domain/entities/user.dart';
import '../../../repositories/user_repository.dart';
import '../../../themes/design_system.dart';

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late PageController pageController;
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  final UserRepository _userRepository = UserRepository();
  String token = '';
  late User user;

  final formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final phoneController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  final phoneMask = MaskTextInputFormatter(
    mask: '+221 ## ### ## ##',
    filter: {"#": RegExp(r'\d')},
  );

  final phoneFocus = FocusNode();
  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final emailFocus = FocusNode();

  final currentStep = 0.obs;
  final isLoading = false.obs;
  final selectedDate = Rxn<DateTime>();
  final selectedSexe = ''.obs;

  final isPhoneValid = false.obs;
  final hasPhoneInput = false.obs;
  final isNameValid = false.obs;
  final isDetailsValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    user = User();
    pageController = PageController();
    animationController = AnimationController(
      duration: TAnimations.medium,
      vsync: this,
    );
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );
    animationController.forward();

    phoneController.addListener(_validatePhone);
    firstNameController.addListener(_validateNames);
    lastNameController.addListener(_validateNames);
    emailController.addListener(_validateDetails);
  }

  void _validatePhone() {
    final phone = phoneMask.unmaskText(phoneController.text);
    hasPhoneInput.value = phone.isNotEmpty;
    isPhoneValid.value = phone.length >= 9;
    user.phoneNumber = phone;
  }

  void _validateNames() {
    isNameValid.value =
        firstNameController.text.trim().length >= 2 &&
        lastNameController.text.trim().length >= 2;
    user.fullName = '${firstNameController.text} ${lastNameController.text}';
  }

  void _validateDetails() {
    final email = emailController.text.trim();
    isDetailsValid.value =
        (email.isEmpty || GetUtils.isEmail(email)) &&
        selectedDate.value != null &&
        selectedSexe.value.isNotEmpty;
  }

  void nextStep() {
    if (currentStep.value < 2) {
      if (_validateCurrentStep()) {
        currentStep.value++;
        pageController.nextPage(
          duration: TAnimations.medium,
          curve: Curves.easeInOut,
        );
      }
    } else {
      _handleRegistration();
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      pageController.previousPage(
        duration: TAnimations.medium,
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentStep() {
    switch (currentStep.value) {
      case 0:
        return formKeys[0].currentState?.validate() ?? false;
      case 1:
        return formKeys[1].currentState?.validate() ?? false;
      case 2:
        return formKeys[2].currentState?.validate() ?? false;
      default:
        return false;
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6570)),
      // 18 years ago
      firstDate: DateTime(1950),
      lastDate: DateTime.now().subtract(const Duration(days: 4380)),
      // 12 years ago
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: TColors.primary),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      selectedDate.value = date;
      user.dateOfBirth = selectedDate.value!;
      _validateDetails();
    }
  }

  void selectSexe(String gender) {
    selectedSexe.value = gender;
    _validateDetails();
    user.sexe = selectedSexe.value;
  }

  Future<void> _handleRegistration() async {
    if (!_validateCurrentStep()) return;

    isLoading.value = true;

    try {
      user.email = emailController.text.trim();
      final phoneNumber = '+221${phoneMask.unmaskText(phoneController.text)}';
      final response = await _userRepository.requestRegisterOtp(
        phoneNumber: phoneNumber,
      );

      if (response) {
        isLoading.value = false;
        Get.snackbar(
          'Succès',
          'OTP envoyé avec succès!',
          backgroundColor: TColors.success,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(
          Routes.OTP,
          arguments: {
            'phone': phoneNumber,
            'user': user,
            'isRegistration': true,
          },
        );
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Erreur',
          'Échec de l\'envoi de l\'OTP. Veuillez réessayer.',
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      isLoading.value = false;
      String errorMessage = 'Erreur lors de l\'inscription: $e';
      if (e.toString().contains('400')) {
        errorMessage = 'Données invalides. Vérifiez vos informations.';
      }
      Get.snackbar(
        'Erreur',
        errorMessage,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    animationController.dispose();
    phoneController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneFocus.dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    super.onClose();
  }
}
