import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:passenger_tyvaa/app/api/api_client.dart';

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneFocus = FocusNode();

  final isLoading = false.obs;
  final unmasked = ''.obs;
  final isDriver = false.obs;
  final hasInput = false.obs;
  final isValid = false.obs;

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

    fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
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
    bool isRegistered =  await ApiClient().registerUser(fullName, phoneNumber);

    await Future.delayed(const Duration(seconds: 2));
    if (!isRegistered) {
      isLoading.value = false;
      Get.snackbar('Erreur', 'Échec de l\'inscription');
      return;
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