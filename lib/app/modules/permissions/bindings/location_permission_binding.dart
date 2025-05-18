import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/permissions/controllers/location_permission_controller.dart';

class LocationPermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationPermissionController>(
      () => LocationPermissionController(),
    );
  }
}
