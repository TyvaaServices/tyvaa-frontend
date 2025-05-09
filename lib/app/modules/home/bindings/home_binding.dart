import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/home/controllers/splash_controller.dart';
import 'package:passenger_tyvaa/app/modules/profile/controllers/profile_controller.dart';

import '../../auth/controllers/login_controller.dart';
import '../../search/controllers/search_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(fenix: true, () => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SearchViewController>(
      fenix: true,
      () => SearchViewController(),
    );
  }
}
