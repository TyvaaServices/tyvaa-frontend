import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';



class LoginController extends GetxController with SingleGetTickerProviderMixin {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final phoneMask = MaskTextInputFormatter(
    mask: '+221 ## ### ## ##',
    filter: {"#": RegExp(r'\d')},
  );

  late AnimationController animationController;
  late Animation<double> fadeInAnimation;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      phoneFocus.requestFocus();
    });
    phoneController.addListener(() {
      unmasked.value = phoneMask.getUnmaskedText();
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    phoneController.dispose();
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
