import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';

import '../../../themes/design_system.dart';

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late PageController pageController;
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

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
  final selectedGender = ''.obs;

  final isPhoneValid = false.obs;
  final hasPhoneInput = false.obs;
  final isNameValid = false.obs;
  final isDetailsValid = false.obs;

  @override
  void onInit() {
    super.onInit();
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
  }

  void _validateNames() {
    isNameValid.value =
        firstNameController.text.trim().length >= 2 &&
        lastNameController.text.trim().length >= 2;
  }

  void _validateDetails() {
    final email = emailController.text.trim();
    isDetailsValid.value =
        (email.isEmpty || GetUtils.isEmail(email)) &&
        selectedDate.value != null &&
        selectedGender.value.isNotEmpty;
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
      initialDate: DateTime.now().subtract(
        const Duration(days: 6570),
      ), // 18 years ago
      firstDate: DateTime(1950),
      lastDate: DateTime.now().subtract(
        const Duration(days: 4380),
      ), // 12 years ago
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
      _validateDetails();
    }
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
    _validateDetails();
  }

  Future<void> _handleRegistration() async {
    if (!_validateCurrentStep()) return;

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    Get.snackbar(
      'Succès',
      'Compte créé avec succès!',
      backgroundColor: TColors.success,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );

    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(Routes.WELCOMEVIEW);
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
