import 'package:get/get.dart';

import '../controllers/my_bookings_controller.dart';

import '../../../../data/repositories/booking_repository.dart';

class MyBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyBookingsController>(
      () => MyBookingsController(Get.find<IBookingRepository>()),
    );
  }
}
