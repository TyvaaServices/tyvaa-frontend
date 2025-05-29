import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/ride_search/controllers/ride_search_controller.dart';

class RideSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideSearchController>(() => RideSearchController());
  }
}
