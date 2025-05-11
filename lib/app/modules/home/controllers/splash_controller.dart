import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final RxDouble visibility = 0.0.obs;
  final RxDouble letterSpacing = 8.0.obs;

  @override
  void onInit() {
    super.onInit();
    _animate();
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    final secureStorage = const FlutterSecureStorage();
    final token = await secureStorage.read(key: 'auth_token');

    if (token != null) {
      Get.offAllNamed(Routes.MAIN);
    }
  }

  void _animate() async {
    await Future.delayed(Duration(milliseconds: 300));
    // Get.offAllNamed('/onboarding');
  }
}
