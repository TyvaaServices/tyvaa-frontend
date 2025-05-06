import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/home/controllers/login_controller.dart';
import 'package:passenger_tyvaa/app/modules/home/controllers/profile_controller.dart';
import 'package:passenger_tyvaa/app/modules/home/controllers/splash_controller.dart';

import '../../../data/repositories/chat_repository_impl.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      fenix: true,
          () =>
          HomeController(
            chatRepository: ChatRepositoryImpl(baseUrl: 'http://10.0.2.2:3073'
            ),
          ),


    );
    Get.lazyPut<ProfileController>(
          () =>
          ProfileController(
          ),


    );    Get.lazyPut<SplashController>(
          () =>
          SplashController(
          ),


    ); Get.lazyPut<LoginController>(
          () =>
          LoginController(
          ),


    );
  }
}
