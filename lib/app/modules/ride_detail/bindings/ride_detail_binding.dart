import 'package:get/get.dart';

import '../controllers/ride_detail_controller.dart';

import '../../../../data/repositories/booking_repository.dart';

class RideDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideDetailController>(
      () => RideDetailController(Get.find<IBookingRepository>()),
    );
  }
}
