import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/modules/auth/controllers/login_controller.dart';
import 'package:passenger_tyvaa/app/modules/auth/controllers/register_controller.dart';
import 'package:passenger_tyvaa/app/modules/profile/controllers/profile_controller.dart';
import 'package:passenger_tyvaa/app/services/connectivity_service.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

class ApiClient{
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

          options.extra['retries'] = 0; // Initialize retry count
          return handler.next(options);
        },
        onError: (error, handler) async {
          const maxRetries = 3;
          const retryDelay = Duration(seconds: 2);

          final shouldRetry = [
            DioExceptionType.connectionTimeout,
            DioExceptionType.receiveTimeout,
            DioExceptionType.sendTimeout,
            DioExceptionType.connectionError,
          ].contains(error.type);

          if (shouldRetry) {
            final retries = error.requestOptions.extra['retries'] ?? 0;
            if (retries < maxRetries) {
              logger.w('Retrying request... Attempt ${retries + 1}');

              await Future.delayed(retryDelay);

              final options = error.requestOptions;
              options.extra['retries'] = retries + 1;

              try {
                final response = await dio.fetch(options);
                return handler.resolve(response);
              } catch (e) {
                return handler.next(e as DioException);
              }
            }
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

  Future<bool> updateUserProfile(
    User user,
    ProfileController controller,
  ) async {
    if (!_connectivityController.hasInternet.value) {
      logger.w('No internet connection. User update queued for later sync.');
      return false;
    }

    try {
      FormData formData = FormData.fromMap({
        ...user.toJson(),
        if (controller.profileImage.value != null)
          'profile_image': await MultipartFile.fromFile(
            controller.profileImage.value!.path,
            filename: controller.profileImage.value!.path.split('/').last,
          ),
      });

      final response = await dio.put(
        '/users/${user.id}',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      logger.d('User profile updated successfully on server');
      return response.statusCode == 200;
    } on DioException catch (e) {
      logger.e('Error updating user profile on server: ${e.message}');
      return false;
    }
  }

  Future<bool> loginUser(String phoneNumber, LoginController controller) async {
    if (!_connectivityController.hasInternet.value) {
      logger.w('No internet connection. Unable to login.');
      return false;
    }

    try {
      final response = await dio.post(
        '/users/login',
        data: {'phoneNumber': phoneNumber},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        controller.otp = data['otp'];
        controller.token = data['token'];
        controller.user = User.fromJson(response.data['user']);
        logger.d('User login successful');
        return true;
      } else {
        logger.e('Failed to login user: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      logger.e('Error logging in user: ${e.message}');
      return false;
    }
  }

  Future<bool> registerUser(User user, RegisterController controller) async {
    try {
      final response = await dio.post('/users/register', data: user.toJson());
      if (response.statusCode == 201) {
        controller.otp = response.data['otp'];
        controller.token = response.data['token'];
        controller.user = User.fromJson(response.data['user']);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      return false;
    }
  }

  Future<Response> submitDriverApplication(Uint8List pdfBytes) async {
    try {
      final formData = FormData.fromMap({
        'pdf': MultipartFile.fromBytes(
          pdfBytes,
          filename: 'driver_application.pdf',
        ),
      });

      return await dio.post('/users/driver-application', data: formData);
    } catch (e) {
      logger.e('Error submitting driver application: ${e.toString()}');
      rethrow;
    }
  }
}
