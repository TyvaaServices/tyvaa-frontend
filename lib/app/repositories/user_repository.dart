import 'package:dio/src/response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/api/api_client.dart';
import 'package:passenger_tyvaa/app/services/connectivity_service.dart';
import 'package:passenger_tyvaa/domain/entities/booking.dart';
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

  static final UserRepository _instance = UserRepository._();

  factory UserRepository() => _instance;

  UserRepository._();

  User? getCurrentUser() {
    try {
      return _userBox.get('currentUser');
    } catch (e) {
      _logger.e('Error retrieving current user from Hive: $e');
      return null;
    }
  }

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

  Future<bool> requestLoginOtp(String phone) async {
    try {
      final response = await _apiClient.requestLoginOtp(phone);

      return response.statusCode == 200;
    } catch (e) {
      _logger.e('Error requesting login OTP: $e');
      return false;
    }
  }

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

  Future<bool> verifyOtp({required String phone, required String otp}) async {
    Response? response = null;
    try {
      response = await _apiClient.verifyOtp(phoneNumber: phone, otp: otp);
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

  Future<void> logout() async {
    await _userBox.delete('currentUser');
  }

  Future<List<Map<String, dynamic>>> getUserBookings(int userId) async {
    if (!_connectivity.hasInternet.value) {
      _logger.d('No internet connection, returning empty booking list');
      return [];
    }

    try {
      final response = await _apiClient.getUserBookings(userId);
      if (response.statusCode == 200 && response.data != null) {
        return List<Map<String, dynamic>>.from(response.data);
      }
      return [];
    } catch (e) {
      _logger.e('Error fetching user bookings: $e');
      return [];
    }
  }

  Future<bool> cancelBooking(int bookingId) async {
    if (!_connectivity.hasInternet.value) {
      _logger.d('No internet connection, cannot cancel booking');
      return false;
    }

    try {
      final response = await _apiClient.cancelBooking(bookingId);
      if (response.statusCode == 200 && response.data != null) {
        _logger.d('Booking cancelled successfully: ${response.data}');
        return true;
      }
      return false;
    } catch (e) {
      _logger.e('Error cancelling booking: $e');
      return false;
    }
  }

  Future<bool> bookRide(Map<String, dynamic> bookingData) async {
    if (!_connectivity.hasInternet.value) {
      _logger.d('No internet connection, cannot book ride');
      return false;
    }

    try {
      final response = await _apiClient.bookRide(booking: bookingData);
      if (response.statusCode == 201 && response.data != null) {
        _logger.d('Ride booked successfully: ${response.data}');
        Booking booking = Booking.fromJson(response.data);
        final bookingBox = Hive.box<Booking>('bookings');
        await bookingBox.put(booking.id, booking);
        return true;
      }
      return false;
    } catch (e) {
      _logger.e('Error booking ride: $e');
      return false;
    }
  }
}
