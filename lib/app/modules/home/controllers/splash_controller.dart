import 'dart:async';

import 'package:get/get.dart';

class SplashController extends GetxController {
  final RxDouble visibility = 0.0.obs;
  final RxDouble letterSpacing = 8.0.obs;

  @override
  void onInit() {
    super.onInit();
    _animate();
  }

  void _animate() async {
    await Future.delayed(Duration(milliseconds: 100));
    visibility.value = 1.0;

    await Future.delayed(Duration(milliseconds: 300));
    letterSpacing.value = 2.0;

    await Future.delayed(Duration(milliseconds: 800));

    visibility.value = 0.0;
    await Future.delayed(Duration(milliseconds: 300));
    Get.offAllNamed('/onboarding');
  }
}
