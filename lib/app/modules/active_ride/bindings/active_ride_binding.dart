import 'package:get/get.dart';

import '../controllers/active_ride_controller.dart';

import '../../../../data/repositories/ride_repository.dart';

class ActiveRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActiveRideController>(
      () => ActiveRideController(Get.find<IRideRepository>()),
    );
  }
}
