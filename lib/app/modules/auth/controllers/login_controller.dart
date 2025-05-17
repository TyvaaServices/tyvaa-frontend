import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

import '../../../api/api_client.dart';

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

  final _apiClient = ApiClient();

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

      await Future.delayed(3.seconds);
      final response = await _apiClient.dio.post(
        '/users/login',
        data: {'phoneNumber': unmasked.value},
      );
      final data = response.data;
      User user = User.fromJson(data['user']);
      final box = Hive.box<User>('users');
      var logger = Logger();
      logger.d(user);
      await box.put('currentUser', user);

      Get.toNamed('/otp', arguments: [data['otp'], data['token']]);
    } catch (e) {
      Get.snackbar('Error', 'Login failed. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}
