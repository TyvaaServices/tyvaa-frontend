import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/domain/entities/location_info.dart';
import 'package:passenger_tyvaa/domain/entities/long_ride.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

class ApiClient {
  var logger = Logger();
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:2000',
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 5000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  final _secureStorage = const FlutterSecureStorage();

  ApiClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorage.read(key: 'auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            // Get.offAllNamed('/login');
          }
          return handler.next(error);
        },
      ),
    );
  }
  Future<User?> getUserProfile(id) async {
    try {
      final response = await dio.get('/users/$id');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      logger.d('Error fetching user profile: ${e.message}');
      return null;
    }
  }

  Future<bool> registerUser(String fullName, String phoneNumber) async {
    try {
      final response = await dio.post('/users', data:{
        'fullName': fullName,
        'phoneNumber': phoneNumber,
      });
      if (response.statusCode == 201) {
        logger.d('User registered successfully');
        return true;
      } else {
        logger.e('Failed to register user: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      logger.e('Error registering user: ${e.message}');
      return false;
    }
  }

  Future<bool> updateUserProfile(User user) async {
    try {
      final response = await dio.put('/users/${user.id}', data: user.toJson());
      logger.d('User profile updated successfully on server');
      return response.statusCode == 200;
    } on DioException catch (e) {
      logger.e('Error updating user profile on server: ${e.message}');
      return false;
    }
  }

  Future<List<LongRide>> getRidesByDestination(LocationInfo location) async {
    try {
      final response = await dio.post(
        '/rides/find',
        data: jsonEncode(location),
      );
      return (response.data as List)
          .map((ride) => LongRide.fromJson(ride))
          .toList();
    } on DioException catch (e) {
      logger.e('Error fetching rides by destination: ${e.message}');
      return [];
    }
  }
}
