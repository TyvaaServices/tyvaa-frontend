import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final phoneFocus = FocusNode();

  final isLoading = false.obs;
  final isValid = false.obs;
  final hasInput = false.obs;
  final isDriver = false.obs;

  late AnimationController animationController;
  late Animation<double> fadeInAnimation;

  final phoneMask = MaskTextInputFormatter(mask: '## ### ## ##');

  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);

    phoneController.addListener(_validatePhone);
    animationController.forward();
  }

  void _validatePhone() {
    final phone = phoneMask.getUnmaskedText();
    hasInput.value = phone.isNotEmpty;
    isValid.value = RegExp(r'^(7[05678]\d{7})$').hasMatch(phone);
  }

  void handleRegister() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2)); // simulation API call
    //redirige au niveau du formulaire pour permetrre AU USER SOUHAITANT DEVENIR chauffeur de remplir les infos
    if (isDriver.value) {}
    isLoading.value = false;
    Get.snackbar('Succès', 'Compte créé avec succès !');
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
