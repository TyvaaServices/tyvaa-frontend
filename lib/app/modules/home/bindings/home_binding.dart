import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../../../data/repositories/ride_repository.dart';
import '../../../../data/repositories/auth_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        Get.find<IRideRepository>(),
        Get.find<IAuthRepository>(),
      ),
    );
  }
}
