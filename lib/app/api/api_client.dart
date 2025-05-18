import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/services/connectivity_service.dart';
import 'package:passenger_tyvaa/domain/entities/location_info.dart';
import 'package:passenger_tyvaa/domain/entities/long_ride.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

class ApiClient {
  var logger = Logger();
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:2000',
      connectTimeout: Duration(milliseconds: 8000),
      receiveTimeout: Duration(milliseconds: 8000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  final _secureStorage = const FlutterSecureStorage();
  final _connectivityController = Get.find<ConnectivityController>();
  final _pendingRequests = <Future>[];

  ApiClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Check connectivity before sending requests
          if (!_connectivityController.hasInternet.value) {
            logger.w('No internet connection. Request queued: ${options.path}');
            return handler.reject(
              DioException(
                requestOptions: options,
                error: 'No internet connection',
                type: DioExceptionType.connectionError,
              ),
            );
          }

          final token = await _secureStorage.read(key: 'auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          // Handle different types of errors
          if (error.type == DioExceptionType.connectionError ||
              error.type == DioExceptionType.connectionTimeout) {
            logger.w('Connection error: ${error.message}');
            // Could implement retry logic here
          } else if (error.response?.statusCode == 401) {
            // Unauthorized - could handle token refresh or logout
            // Get.offAllNamed('/login');
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<User?> getUserProfile(int id) async {
    if (!_connectivityController.hasInternet.value) {
      logger.w('No internet connection. Unable to fetch user profile.');
      return null;
    }

    try {
      final response = await dio.get('/users/$id');
      logger.d('User profile fetched successfully');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      logger.d('Error fetching user profile: ${e.message}');
      return null;
    }
  }

  // Updated: Return null if register fails, otherwise the full response
  Future<Map<String, dynamic>?> registerUser(String fullName, String phoneNumber, {bool isDriver = false}) async {
    if (!_connectivityController.hasInternet.value) {
      logger.w('No internet connection. Unable to register user.');
      return null;
    }

    try {
      final response = await dio.post('/users/register', data: {
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'isDriver': isDriver,
      });

      if (response.statusCode == 201) {
        final data = response.data;
        logger.d('User registered successfully');
        return {
          'user': data['user'],
          'otp': data['otp'],
          'token': data['token']
        };
      } else {
        logger.e('Failed to register user: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      logger.e('Error registering user: ${e.message}');
      return null;
    }
  }

  Future<bool> updateUserProfile(User user) async {
    if (!_connectivityController.hasInternet.value) {
      logger.w('No internet connection. User update queued for later sync.');
      return false;
    }

    try {
      final response = await dio.put('/users/${user.id}', data: user.toJson());
      logger.d('User profile updated successfully on server');
      return response.statusCode == 200;
    } on DioException catch (e) {
      logger.e('Error updating user profile on server: ${e.message}');
      return false;
    }
  }

  Future<Map<String, dynamic>?> loginUser(String phoneNumber) async {
    if (!_connectivityController.hasInternet.value) {
      logger.w('No internet connection. Unable to login.');
      return null;
    }

    try {
      final response = await dio.post(
        '/users/login',
        data: {'phoneNumber': phoneNumber},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        logger.d('User login successful');
        return {
          'user': data['user'],
          'otp': data['otp'],
          'token': data['token']
        };
      } else {
        logger.e('Failed to login user: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      logger.e('Error logging in user: ${e.message}');
      return null;
    }
  }

  Future<List<LongRide>> getRidesByDestination(LocationInfo location) async {
    if (!_connectivityController.hasInternet.value) {
      logger.w('No internet connection. Unable to fetch rides.');
      // Return cached rides from Hive if available
      final ridesBox = Hive.box<LongRide>('long_rides');
      return ridesBox.values.toList();
    }

    try {
      final response = await dio.post(
        '/rides/find',
        data: jsonEncode(location),
      );

      final rides = (response.data as List)
          .map((ride) => LongRide.fromJson(ride))
          .toList();

      // Cache the fetched rides
      final ridesBox = Hive.box<LongRide>('long_rides');
      await ridesBox.clear(); // Clear old data
      for (var ride in rides) {
        await ridesBox.add(ride);
      }

      return rides;
    } on DioException catch (e) {
      logger.e('Error fetching rides by destination: ${e.message}');
      // Return cached data as fallback
      final ridesBox = Hive.box<LongRide>('long_rides');
      return ridesBox.values.toList();
    }
  }
}
