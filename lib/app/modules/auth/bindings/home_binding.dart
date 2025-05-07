import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class Authentication extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(fenix: true, () => LoginController());
    //TODO : register controller here
  }
}
