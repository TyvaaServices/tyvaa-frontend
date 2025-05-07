import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/login/controllers/login_controller.dart';

class Authentication extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(fenix: true, () => LoginController());
    //TODO : register controller here
  }
}
