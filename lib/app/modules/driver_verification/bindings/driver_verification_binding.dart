import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/driver_verification/controllers/driver_verification_controller.dart';

class DriverVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverVerificationController>(
      () => DriverVerificationController(),
    );
  }
}
