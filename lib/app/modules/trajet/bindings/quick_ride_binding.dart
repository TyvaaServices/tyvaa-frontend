import 'package:get/get.dart';
import '../controllers/quick_ride_controller.dart';

class QuickRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuickRideController>(
      () => QuickRideController(),
    );
  }
}
