import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

import '../../../../data/repositories/auth_repository.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(
      () => SettingsController(Get.find<IAuthRepository>()),
    );
  }
}
