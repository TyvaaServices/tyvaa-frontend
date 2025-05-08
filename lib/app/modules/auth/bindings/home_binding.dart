import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/auth/controllers/otp_controller.dart';

import '../controllers/login_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(fenix: true, () => LoginController());
    //TODO : register controller here

    Get.lazyPut<OtpVerificationController>(
      fenix: true,
      () => OtpVerificationController(),
    );
  }
}
