import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/auth/views/otp_view.dart';
import 'package:passenger_tyvaa/app/modules/chatbot/bindings/chatbot_binding.dart';
import 'package:passenger_tyvaa/app/modules/chatbot/views/chooseChat_view.dart';
import 'package:passenger_tyvaa/app/modules/home/views/main_screen.dart';
import 'package:passenger_tyvaa/app/modules/home/views/onboarding_chauffeur.dart';
import 'package:passenger_tyvaa/app/modules/home/views/splash_view.dart';
import 'package:passenger_tyvaa/app/modules/notification/bindings/notification_binding.dart';
import 'package:passenger_tyvaa/app/modules/notification/views/notification_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/onboarding_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => MainScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 800),
      showCupertinoParallax: true,
      bindings: [HomeBinding(), ChatbotBinding(), NotificationBinding()],
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
      binding: AuthenticationBinding(),
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
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationsScreen(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 800),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpVerificationScreen(),
      binding: AuthenticationBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 800),
    ),
    GetPage(
      name: _Paths.ONBOARDINGCHAUFFEUR,
      page: () => PublierTrajetOnboarding(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 800),
    ),
  ];
}
