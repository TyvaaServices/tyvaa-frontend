import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/profile/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(fenix: true, () => ProfileController());
  }
}
