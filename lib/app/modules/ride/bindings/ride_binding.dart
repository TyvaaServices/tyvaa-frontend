import 'package:get/get.dart';

import '../controllers/ride_controller.dart';

import '../../../../data/repositories/ride_repository.dart';

class RideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideController>(
      () => RideController(Get.find<IRideRepository>()),
    );
  }
}
