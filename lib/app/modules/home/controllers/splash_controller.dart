import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/repositories/user_repository.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final RxDouble visibility = 0.0.obs;
  final RxDouble letterSpacing = 8.0.obs;

  @override
  void onInit() {
    super.onInit();
    _animate();
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    final secureStorage = const FlutterSecureStorage();
    final token = await secureStorage.read(key: 'auth_token');

    print('SplashController: Checking auth state...');
    print('SplashController: Token exists: ${token != null}');

    if (token != null) {
      print('SplashController: Token found, checking user data in Hive...');
      // Check if user data exists in Hive
      final userRepository = UserRepository();
      final currentUser = userRepository.getCurrentUser();

      print('SplashController: Current user in Hive: ${currentUser != null}');

      if (currentUser != null) {
        print('SplashController: User data exists, proceeding to main');
        // User data exists, proceed to main
        Get.offAllNamed(Routes.MAIN);
      } else {
        print(
          'SplashController: Token exists but no user data - attempting recovery',
        );
        // Token exists but no user data - this can happen after 500 error recovery
        // Try to fetch user data from API using the token
        try {
          final userId = await secureStorage.read(key: 'user_id');
          print('SplashController: User ID from storage: $userId');

          if (userId != null) {
            print(
              'SplashController: Attempting to refresh user data from API...',
            );
            final refreshedUser = await userRepository.refreshUserData(
              int.parse(userId),
            );

            if (refreshedUser != null) {
              print(
                'SplashController: User data refreshed successfully, proceeding to main',
              );
              Get.offAllNamed(Routes.MAIN);
            } else {
              print(
                'SplashController: Failed to refresh user data, clearing tokens',
              );
              // Can't fetch user data, clear token and go to login
              await secureStorage.delete(key: 'auth_token');
              await secureStorage.delete(key: 'user_id');
              Get.offAllNamed(Routes.LOGIN);
            }
          } else {
            print('SplashController: No user ID found, clearing token');
            // No user ID, clear token and go to login
            await secureStorage.delete(key: 'auth_token');
            Get.offAllNamed(Routes.LOGIN);
          }
        } catch (e) {
          print('SplashController: Error during recovery: $e');
          // Error fetching user data, clear token and go to login
          await secureStorage.delete(key: 'auth_token');
          await secureStorage.delete(key: 'user_id');
          Get.offAllNamed(Routes.LOGIN);
        }
      }
    } else {
      print('SplashController: No token found, proceeding to login');
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  void _animate() async {
    await Future.delayed(Duration(milliseconds: 300));
    // Get.offAllNamed('/onboarding');
  }
}
