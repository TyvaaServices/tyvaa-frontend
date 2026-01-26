import 'package:get/get.dart';

import '../controllers/booking_requests_controller.dart';

import '../../../../data/repositories/booking_repository.dart';

class BookingRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingRequestsController>(
      () => BookingRequestsController(Get.find<IBookingRepository>()),
    );
  }
}
