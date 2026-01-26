import 'package:get/get.dart';

import '../modules/active_ride/bindings/active_ride_binding.dart';
import '../modules/active_ride/views/active_ride_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/booking_requests/bindings/booking_requests_binding.dart';
import '../modules/booking_requests/views/booking_requests_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/messages/bindings/messages_binding.dart';
import '../modules/messages/views/messages_view.dart';
import '../modules/my_bookings/bindings/my_bookings_binding.dart';
import '../modules/my_bookings/views/my_bookings_view.dart';
import '../modules/my_rides/bindings/my_rides_binding.dart';
import '../modules/my_rides/views/my_rides_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/ride/bindings/ride_binding.dart';
import '../modules/ride/views/ride_view.dart';
import '../modules/ride_detail/bindings/ride_detail_binding.dart';
import '../modules/ride_detail/views/ride_detail_view.dart';
import '../modules/search_ride/bindings/search_ride_binding.dart';
import '../modules/search_ride/views/search_ride_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

// ignore_for_file: constant_identifier_names

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    // DASHBOARD (Main Entry)
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGES,
      page: () => const MessagesView(),
      binding: MessagesBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.RIDE,
      page: () => const RideView(),
      binding: RideBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.RIDE_DETAIL,
      page: () => const RideDetailView(),
      binding: RideDetailBinding(),
    ),
    GetPage(
      name: _Paths.MY_BOOKINGS,
      page: () => const MyBookingsView(),
      binding: MyBookingsBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES,
      page: () => const MyRidesView(),
      binding: MyRidesBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_REQUESTS,
      page: () => const BookingRequestsView(),
      binding: BookingRequestsBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVE_RIDE,
      page: () => const ActiveRideView(),
      binding: ActiveRideBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_RIDE,
      page: () => const SearchRideView(),
      binding: SearchRideBinding(),
    ),
  ];
}
