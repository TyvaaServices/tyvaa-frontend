import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';
import 'dart:async';



class SplashController extends GetxController {
  final RxDouble visibility = 0.0.obs;
  final RxDouble letterSpacing = 8.0.obs;

  @override
  void onInit() {
    super.onInit();
    _startSimpleAnimation();
  }

  void _startSimpleAnimation() async {
    // Fade in
    await Future.delayed(Duration(milliseconds: 100));
    visibility.value = 1.0;

    // Letter spacing animation
    await Future.delayed(Duration(milliseconds: 300));
    letterSpacing.value = 2.0;

    // Brief pause for visibility
    await Future.delayed(Duration(milliseconds: 800));

    // Fade out and navigate
    visibility.value = 0.0;
    await Future.delayed(Duration(milliseconds: 300));
    Get.offAllNamed('/onboarding');
  }

  @override
  void onClose() {
    super.onClose();
  }
}

// Add this splash screen as your initial route:
// GetMaterialApp(
//   initialRoute: '/splash',
//   getPages: [
//     GetPage(name: '/splash', page: () => SplashScreen()),
//     GetPage(name: '/main', page: () => MainScreen()),
//   ],
// )