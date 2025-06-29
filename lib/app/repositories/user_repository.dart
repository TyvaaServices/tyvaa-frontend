import 'package:dio/src/response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/api/api_client.dart';
import 'package:passenger_tyvaa/app/services/connectivity_service.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

import '../modules/profile/controllers/profile_controller.dart';
import '../services/synchronization_service.dart';

class UserRepository {
  final _logger = Logger();
  final _userBox = Hive.box<User>('users');
  final ApiClient _apiClient = Get.find<ApiClient>();

  final synchronize = Get.find<SynchronizationService>();
  final ConnectivityController _connectivity =
      Get.find<ConnectivityController>();

  // Singleton instance
  static final UserRepository _instance = UserRepository._();

  factory UserRepository() => _instance;

  UserRepository._();

  /// Gets the current user from local storage
  User? getCurrentUser() {
    try {
      return _userBox.get('currentUser');
    } catch (e) {
      _logger.e('Error retrieving current user from Hive: $e');
      return null;
    }
  }

  /// Saves user to local storage after receiving from remote
  Future<bool> saveUser(User user) async {
    try {
      final FlutterSecureStorage storage = const FlutterSecureStorage();
      final String? fcmToken = await storage.read(key: 'fcm_token');
      user.fcmToken = fcmToken;
      await _userBox.put('currentUser', user);
      synchronize.markUserChanged();
      _logger.d('User saved to local storage: ${user.fullName}');
      return true;
    } catch (e) {
      _logger.e('Error saving user to local storage: $e');
      return false;
    }
  }

  /// Tries to fetch fresh user data from API and update local storage
  Future<User?> refreshUserData(int userId) async {
    if (!_connectivity.hasInternet.value) {
      _logger.d('No internet connection, returning cached user data');
      return getCurrentUser();
    }

    try {
      final remoteUser = await _apiClient.getUserProfile(userId);

      if (remoteUser != null) {
        await _userBox.put('currentUser', remoteUser);
        return remoteUser;
      }
      return getCurrentUser();
    } catch (e) {
      _logger.e('Error refreshing user data: $e');
      return getCurrentUser();
    }
  }

  /// Synchronizes local user data with the remote API
  Future<bool> synchronizeUserData(User user) async {
    if (!_connectivity.hasInternet.value) {
      return false;
    }

    try {
      final ProfileController profileController = Get.find<ProfileController>();
      final result = await _apiClient.updateUserProfile(
        user,
        profileController,
      );
      return result;
    } catch (e) {
      _logger.e('Error synchronizing user data: $e');
      return false;
    }
  }

  /// Request login OTP
  Future<bool> requestLoginOtp(String phone) async {
    try {
      final response = await _apiClient.requestLoginOtp(phone);

      return response.statusCode == 200;
    } catch (e) {
      _logger.e('Error requesting login OTP: $e');
      return false;
    }
  }

  /// Request registration OTP
  Future<bool> requestRegisterOtp({required String phoneNumber}) async {
    try {
      final response = await _apiClient.requestRegisterOtp(
        phoneNumber: phoneNumber,
      );
      return response.statusCode == 200;
    } catch (e) {
      _logger.e('Error requesting register OTP: $e');
      return false;
    }
  }

  /// Verify OTP
  Future<bool> verifyOtp({required String phone, required String otp}) async {
    Response? response = null;
    try {
      response = await _apiClient.verifyOtp(phone: phone, otp: otp);
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        final FlutterSecureStorage storage = const FlutterSecureStorage();
        if (data['token'] != null && data['user'] != null) {
          await storage.write(key: 'auth_token', value: data['token']);
          await storage.write(
            key: 'user_id',
            value: data['user']['id']?.toString() ?? '',
          );
          saveUser(User.fromJson(data['user']));
        }
        return true;
      }
      return false;
    } catch (e) {
      _logger.e('Error verifying OTP: $e and ${response?.data['error']}');
      return false;
    }
  }

  /// Register user with OTP
  Future<bool> createUser({
    required Map<String, dynamic> user,
    required String otp,
  }) async {
    try {
      final response = await _apiClient.createUser(user: user, otp: otp);
      if (response.statusCode == 201 && response.data != null) {
        final data = response.data;
        final FlutterSecureStorage storage = const FlutterSecureStorage();
        if (data['user'] != null) {
          await storage.write(
            key: 'user_id',
            value: data['user']['id']?.toString() ?? '',
          );
          await storage.write(
            key: 'user_name',
            value: data['user']['name'] ?? '',
          );
          await storage.write(
            key: 'user_email',
            value: data['user']['email'] ?? '',
          );
          await storage.write(
            key: 'user_phone',
            value: data['user']['phone'] ?? '',
          );
        }
        if (data['token'] != null) {
          await storage.write(key: 'auth_token', value: data['token']);
        }
        // Optionally save to Hive/local storage if needed
        return true;
      }
      return false;
    } catch (e) {
      _logger.e('Error creating user: $e');
      return false;
    }
  }

  /// Resend OTP (handles both registration and login)
  Future<bool> resendOtp({
    required String phoneNumber,
    required bool isRegistration,
  }) async {
    if (isRegistration) {
      return await requestRegisterOtp(phoneNumber: phoneNumber);
    } else {
      return await requestLoginOtp(phoneNumber);
    }
  }

  /// Logout and clear user data
  Future<void> logout() async {
    await _userBox.delete('currentUser');
  }
}
