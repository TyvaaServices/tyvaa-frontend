import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/chatbot/bindings/chatbot_binding.dart';
import 'package:passenger_tyvaa/app/modules/chatbot/views/chooseChat_view.dart';
import 'package:passenger_tyvaa/app/modules/home/views/login_view.dart';
import 'package:passenger_tyvaa/app/modules/home/views/main_screen.dart';
import 'package:passenger_tyvaa/app/modules/home/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => MainScreen(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 800),
      showCupertinoParallax: true,
      bindings: [ChatbotBinding()],
    ),
    GetPage(
      name: _Paths.CHOOSE,
      page: () => ChooseChatbotScreen(),
      binding: ChatbotBinding(),
      transition: Transition.zoom,
      transitionDuration: Duration(milliseconds: 800),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingScreen(),
      binding: HomeBinding(),
      transition: Transition.zoom,
      transitionDuration: Duration(milliseconds: 800),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 800),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
      binding: HomeBinding(),
      transition: Transition.zoom,
      transitionDuration: Duration(milliseconds: 800),
    ),
  ];
}
