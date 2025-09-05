import 'package:dio/src/response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/api/api_client.dart';
import 'package:passenger_tyvaa/app/services/connectivity_service.dart';
import 'package:passenger_tyvaa/domain/entities/booking.dart';
import 'package:passenger_tyvaa/domain/entities/ride_instance.dart';
import 'package:passenger_tyvaa/domain/entities/ride_model.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

import '../modules/profile/controllers/profile_controller.dart';
import '../services/synchronization_service.dart';

class UserRepository {
  final _logger = Logger();
  final ApiClient _apiClient = Get.find<ApiClient>();

  final synchronize = Get.find<SynchronizationService>();
  final ConnectivityController _connectivity =
      Get.find<ConnectivityController>();

  static final UserRepository _instance = UserRepository._();

  factory UserRepository() => _instance;

  UserRepository._();

  // Get Hive box dynamically to ensure it's properly opened
  Box<User> get _userBox => Hive.box<User>('users');

  User? getCurrentUser() {
    try {
      final box = _userBox;
      _logger.d('getCurrentUser - Hive box keys: ${box.keys.toList()}');
      _logger.d('getCurrentUser - Hive box length: ${box.length}');
      return box.get('currentUser');
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

      final box = _userBox;
      _logger.d('saveUser - Before save - Hive box keys: ${box.keys.toList()}');
      await box.put('currentUser', user);
      _logger.d('saveUser - After save - Hive box keys: ${box.keys.toList()}');
      _logger.d(
        'saveUser - Verification - User exists: ${box.containsKey('currentUser')}',
      );

      synchronize.markUserChanged();
      _logger.d('User saved to local storage: ${user.fullName}');
      return true;
    } catch (e) {
      _logger.e('Error saving user to local storage: $e');
      return false;
    }
  }

  Future<User?> refreshUserData(int? userId) async {
    if (!_connectivity.hasInternet.value) {
      _logger.d('No internet connection, returning cached user data');
      return getCurrentUser();
    }
    if (userId == null) {
      _logger.w('User ID is null, cannot refresh user data');
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
      await refreshUserData(getCurrentUser()?.id);
      return result;
    } catch (e) {
      _logger.e('Error synchronizing user data: $e');
      return false;
    }
  }

  Future<bool> requestLoginOtp(String phone) async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      final response = await _apiClient.requestLoginOtp(
        phone,
        fcmToken: fcmToken,
      );
      return response.statusCode == 200;
    } catch (e) {
      _logger.e('Error requesting login OTP: $e');
      return false;
    }
  }

  Future<bool> requestRegisterOtp({required String phoneNumber}) async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      final response = await _apiClient.requestRegisterOtp(
        phoneNumber: phoneNumber,
        fcmToken: fcmToken,
      );
      Logger logger = Logger();
      logger.d('Register OTP response: ${response.data}');
      return response.statusCode == 200;
    } catch (e) {
      _logger.e('Error requesting register OTP: $e');
      return false;
    }
  }

  Future<bool> verifyOtp({required String phone, required String otp}) async {
    Response? response = null;
    try {
      _logger.d('Verifying OTP for phone: $phone');
      response = await _apiClient.verifyOtp(phoneNumber: phone, otp: otp);
      _logger.d('OTP verification response status: ${response.statusCode}');
      _logger.d('OTP verification response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        final FlutterSecureStorage storage = const FlutterSecureStorage();

        _logger.d('Response data keys: ${data.keys}');
        _logger.d('Token exists: ${data['token'] != null}');
        _logger.d('User exists: ${data['user'] != null}');

        if (data['token'] != null && data['user'] != null) {
          _logger.d('Saving auth token and user data...');
          await storage.write(key: 'auth_token', value: data['token']);
          await storage.write(
            key: 'user_id',
            value: data['user']['id']?.toString() ?? '',
          );

          _logger.d('User data to save: ${data['user']}');
          final saveResult = await saveUser(User.fromJson(data['user']));
          _logger.d('User save result: $saveResult');

          // Verify the user was actually saved
          final savedUser = getCurrentUser();
          _logger.d(
            'Verification - Current user after save: ${savedUser?.toJson()}',
          );
        } else {
          _logger.w('Missing token or user data in response');
        }
        return true;
      }
      return false;
    } catch (e) {
      _logger.e('Error verifying OTP: $e and ${response?.data?['error']}');
      return false;
    }
  }

  Future<bool> createUser({
    required Map<String, dynamic> user,
    required String otp,
  }) async {
    try {
      _logger.d('Creating user with data: $user');
      _logger.d('Using OTP: $otp');

      final response = await _apiClient.createUser(user: user, otp: otp);
      _logger.d('API response status: ${response.statusCode}');
      _logger.d('API response data: ${response.data}');

      if (response.statusCode == 201 && response.data != null) {
        final data = response.data;

        // Log the complete response structure
        _logger.d('Response data keys: ${data.keys.toList()}');
        _logger.d('User data exists: ${data['user'] != null}');
        _logger.d('Token exists: ${data['token'] != null}');
        _logger.d('RefreshToken exists: ${data['refreshToken'] != null}');

        if (data['user'] != null) {
          _logger.d('User data from API: ${data['user']}');
        }

        // Store tokens and user data first, ensuring atomic operation
        await _storeUserData(data);

        // Wait a small delay to ensure secure storage is complete
        await Future.delayed(const Duration(milliseconds: 100));

        // Verify token was stored before proceeding
        final storage = const FlutterSecureStorage();
        final storedToken = await storage.read(key: 'auth_token');
        final storedUserId = await storage.read(key: 'user_id');

        _logger.d('Stored token exists: ${storedToken != null}');
        _logger.d('Stored user ID: $storedUserId');

        if (storedToken == null) {
          _logger.e('Failed to store auth token during registration');
          return false;
        }

        _logger.d('Auth token verified after storage: ${storedToken != null}');

        // Save user to Hive after token verification
        if (data['user'] != null) {
          _logger.d('Saving user to Hive: ${data['user']}');
          final saveSuccess = await saveUser(User.fromJson(data['user']));
          _logger.d('User save to Hive result: $saveSuccess');

          if (!saveSuccess) {
            _logger.e('Failed to save user to Hive during registration');
            return false;
          }

          // Verify user was saved correctly
          final savedUser = getCurrentUser();
          _logger.d('Verification - saved user: ${savedUser?.toJson()}');
        }

        _logger.d('Registration completed successfully');
        return true;
      } else {
        _logger.e(
          'Registration failed - Status: ${response.statusCode}, Data: ${response.data}',
        );
        return false;
      }
    } catch (e) {
      _logger.e('Error creating user: $e');
      return false;
    }
  }

  /// Helper method to store user data in secure storage
  Future<void> _storeUserData(Map<String, dynamic> data) async {
    final FlutterSecureStorage storage = const FlutterSecureStorage();

    // Store user data
    if (data['user'] != null) {
      await storage.write(
        key: 'user_id',
        value: data['user']['id']?.toString() ?? '',
      );
      await storage.write(
        key: 'user_name',
        value: data['user']['fullName'] ?? data['user']['name'] ?? '',
      );
      await storage.write(
        key: 'user_email',
        value: data['user']['email'] ?? '',
      );
      await storage.write(
        key: 'user_phone',
        value: data['user']['phoneNumber'] ?? data['user']['phone'] ?? '',
      );
    }

    // Store authentication tokens
    if (data['token'] != null) {
      await storage.write(key: 'auth_token', value: data['token']);
      _logger.d('Auth token stored successfully');
    }

    // Store refresh token if available
    if (data['refreshToken'] != null) {
      await storage.write(key: 'refresh_token', value: data['refreshToken']);
      _logger.d('Refresh token stored successfully');
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
        await refreshUserData(getCurrentUser()?.id);
        return true;
      }
      return false;
    } catch (e) {
      _logger.e('Error cancelling booking: $e');
      return false;
    }
  }

  Future<Booking?> bookRide(Booking bookingData) async {
    if (!_connectivity.hasInternet.value) {
      _logger.d('No internet connection, cannot book ride');
      return null;
    }

    try {
      final response = await _apiClient.bookRide(booking: bookingData.toJson());
      if (response.statusCode == 201 && response.data != null) {
        _logger.d('Ride booked successfully: ${response.data}');
        Booking booking = Booking.fromJson(response.data);
        final bookingBox = Hive.box<Booking>('bookings');
        await bookingBox.put(booking.id, booking);
        return booking;
      }
      return null;
    } catch (e) {
      _logger.e('Error booking ride: $e');
      return null;
    }
  }

  /// Book a ride with raw payload data (for payment flow)
  Future<Booking?> bookRideWithPayload(
    Map<String, dynamic> bookingPayload,
  ) async {
    if (!_connectivity.hasInternet.value) {
      _logger.d('No internet connection, cannot book ride');
      return null;
    }

    try {
      _logger.d('Booking ride with payload: $bookingPayload');
      final response = await _apiClient.bookRide(booking: bookingPayload);

      if (response.statusCode == 201 && response.data != null) {
        _logger.d('Ride booked successfully: ${response.data}');
        Booking booking = Booking.fromJson(response.data);
        final bookingBox = Hive.box<Booking>('bookings');
        await bookingBox.put(booking.id, booking);
        return booking;
      }

      _logger.w('Booking failed with status: ${response.statusCode}');
      return null;
    } catch (e) {
      _logger.e('Error booking ride with payload: $e');
      return null;
    }
  }

  /// Publish a ride using the API
  Future<bool> publishRide(RideModel ride) async {
    try {
      final response = await _apiClient.publishRide(ride: ride);
      if (response.statusCode == 201) {
        await refreshUserData(getCurrentUser()?.id);
        return true;
      }
      return false;
    } catch (e) {
      _logger.e('Error publishing ride: $e');
      return false;
    }
  }

  Future<List<Rideinstance>> searchRides({
    required String departure,
    required String arrival,
    DateTime? date,
  }) async {
    if (!_connectivity.hasInternet.value) {
      _logger.d('No internet connection, cannot search rides');
      return [];
    }

    try {
      final response = await _apiClient.searchRides(
        departure: departure,
        destination: arrival,
        date: date,
      );
      if (response['statusCode'] == 200) {
        final List<dynamic> ridesData = response['data'] ?? [];
        return ridesData
            .map((rideJson) => Rideinstance.fromJson(rideJson))
            .toList();
      } else {
        _logger.e('Error searching rides: [31m${response['error']}[0m');
        return [];
      }
    } catch (e) {
      _logger.e('Error searching rides: $e');
      return [];
    }
  }

  Future<List<String>> getAllLandmarks() async {
    if (!_connectivity.hasInternet.value) {
      _logger.d('No internet connection, cannot fetch landmarks');
      return [];
    }

    try {
      final response = await _apiClient.getAllLandmarks();
      if (response.statusCode == 200 && response.data != null) {
        return List<String>.from(response.data);
      } else {
        _logger.e('Error fetching landmarks: ${response.data}');
        return [];
      }
    } catch (e) {
      _logger.e('Error fetching landmarks: $e');
      return [];
    }
  }
}
