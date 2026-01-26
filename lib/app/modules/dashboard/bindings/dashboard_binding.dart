import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../home/bindings/home_binding.dart';
import '../../my_rides/bindings/my_rides_binding.dart';
import '../../messages/bindings/messages_binding.dart';
import '../../profile/bindings/profile_binding.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());

    // Initialize dependencies for all tabs
    HomeBinding().dependencies();
    MyRidesBinding().dependencies();
    MessagesBinding().dependencies();
    ProfileBinding().dependencies();
  }
}
