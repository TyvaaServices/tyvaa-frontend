import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/home/views/chooseChat_view.dart';
import 'package:passenger_tyvaa/app/modules/home/views/login_view.dart';
import 'package:passenger_tyvaa/app/modules/home/views/main_screen.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/onboarding_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => MainScreen(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 1500),
    ),
    GetPage(
      name: _Paths.CHOOSE,
      page: () => ChooseChatbotScreen(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 1500),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingScreen(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 2500),
    ),    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 800),
    ),

  ];
}
