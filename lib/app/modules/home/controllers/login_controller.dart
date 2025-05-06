import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';




class LoginController extends GetxController with SingleGetTickerProviderMixin {
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

    phoneFocus.addListener(() {
      if (phoneFocus.hasFocus) {
        Future.delayed(const Duration(milliseconds: 400), () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent+100,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });

    phoneController.addListener(() {
      unmasked.value = phoneMask.getUnmaskedText();
    });
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
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    Get.offAllNamed('/home');
  }
}
