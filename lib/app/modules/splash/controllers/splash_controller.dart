import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../app/routes/app_pages.dart';

class SplashController extends GetxController {
  final _storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2)); // Logo display time

    // Check if user has seen onboarding
    String? hasSeenOnboarding = await _storage.read(key: 'has_seen_onboarding');

    if (hasSeenOnboarding == 'true') {
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      Get.offAllNamed(Routes.ONBOARDING);
    }
  }
}
