import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/modules/profile/controllers/profile_controller.dart';
import 'package:passenger_tyvaa/app/services/connectivity_service.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

/// API client with enhanced retry logic and circuit breaker pattern
///
/// Features:
/// - Exponential backoff retry strategy (1s, 2s delays)
/// - Circuit breaker pattern to prevent API spam when service is down
/// - Reduced retry attempts to minimize log spam
/// - Automatic circuit breaker reset after timeout period

class ApiClient {
  var logger = Logger();
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3000/api/v1',
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

  // Circuit breaker state
  DateTime? _lastFailureTime;
  int _consecutiveFailures = 0;
  bool _circuitOpen = false;
  static const int _maxConsecutiveFailures =
      5; // Only open after 5 complete request failures
  static const Duration _circuitBreakerTimeout = Duration(
    minutes: 2,
  ); // 2 minute timeout

  ApiClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Check circuit breaker state
          if (_circuitOpen) {
            final now = DateTime.now();
            if (_lastFailureTime != null &&
                now.difference(_lastFailureTime!) > _circuitBreakerTimeout) {
              // Reset circuit breaker after timeout
              _circuitOpen = false;
              _consecutiveFailures = 0;
              logger.i('Circuit breaker reset - retrying requests');
            } else {
              // Circuit is still open
              logger.w(
                'Circuit breaker open - blocking request to ${options.path}',
              );
              return handler.reject(
                DioException(
                  requestOptions: options,
                  error:
                      'Service temporarily unavailable (Circuit breaker open)',
                  type: DioExceptionType.connectionError,
                ),
              );
            }
          }

          if (!_connectivityController.hasInternet.value) {
            logger.w(
              'No internet connection. Request blocked: ${options.path}',
            );
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

          options.extra['retries'] = 0;
          options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;
          return handler.next(options);
        },
        onError: (error, handler) async {
          // If circuit is already open, check if we should reset it
          if (_circuitOpen) {
            final now = DateTime.now();
            if (_lastFailureTime != null &&
                now.difference(_lastFailureTime!) > _circuitBreakerTimeout) {
              // Reset circuit breaker after timeout
              _circuitOpen = false;
              _consecutiveFailures = 0;
              logger.i(
                '� Circuit breaker timeout expired - allowing requests again',
              );
            } else {
              // Circuit is still open, fail fast
              return handler.next(error);
            }
          }

          const maxRetries = 2; // Allow 2 retries
          final retries = error.requestOptions.extra['retries'] ?? 0;

          final shouldRetry = [
            DioExceptionType.connectionTimeout,
            DioExceptionType.receiveTimeout,
            DioExceptionType.sendTimeout,
            DioExceptionType.connectionError,
          ].contains(error.type);

          // Only retry if we haven't exceeded max retries and error is retryable
          if (shouldRetry && retries < maxRetries && !_circuitOpen) {
            final delaySeconds = 1; // Fixed 1 second delay
            final retryDelay = Duration(seconds: delaySeconds);

            // Silent retry - no logging to prevent spam
            await Future.delayed(retryDelay);

            final options = error.requestOptions;
            options.extra['retries'] = retries + 1;

            try {
              final response = await dio.fetch(options);
              // Success - reset consecutive failures
              _consecutiveFailures = 0;
              if (_circuitOpen) {
                _circuitOpen = false;
                logger.i('🟢 Circuit breaker CLOSED - API is back online');
              }
              return handler.resolve(response);
            } catch (e) {
              // Let the retry logic handle this in the next iteration
              return handler.next(e as DioException);
            }
          }

          // If we reach here, no more retries - this counts as a consecutive failure
          _consecutiveFailures++;
          _lastFailureTime = DateTime.now();

          // Check if we should open the circuit breaker
          if (_consecutiveFailures >= _maxConsecutiveFailures &&
              !_circuitOpen) {
            _circuitOpen = true;
            logger.e(
              '🔴 Circuit breaker OPENED - API appears down. Blocking requests for ${_circuitBreakerTimeout.inMinutes} minutes.',
            );
          }

          // Silent failure - only log circuit breaker events to prevent spam

          return handler.next(error);
        },
        onResponse: (response, handler) {
          // Success - reset circuit breaker state
          if (_consecutiveFailures > 0) {
            _consecutiveFailures = 0;
            if (_circuitOpen) {
              _circuitOpen = false;
              logger.i('🟢 Circuit breaker CLOSED - API is back online');
            }
          }
          return handler.next(response);
        },
      ),
    );
  }

  /// Check if the circuit breaker is currently open
  bool get isCircuitBreakerOpen => _circuitOpen;

  /// Get the number of consecutive failures
  int get consecutiveFailures => _consecutiveFailures;

  /// Manually reset the circuit breaker (useful for testing or manual recovery)
  void resetCircuitBreaker() {
    _circuitOpen = false;
    _consecutiveFailures = 0;
    _lastFailureTime = null;
    logger.i('🔄 Circuit breaker manually reset');
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

  Future<Response> requestLoginOtp(String phoneNumber) async {
    return await dio.post(
      '/users/request-login-otp',
      data: {'phoneNumber': phoneNumber},
    );
  }

  Future<Response> requestRegisterOtp({required String phoneNumber}) async {
    return await dio.post(
      '/users/request-register-otp',
      data: {'phoneNumber': phoneNumber},
    );
  }

  Future<Response> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    return await dio.post(
      '/users/verify',
      data: {'phoneNumber': phoneNumber, 'otp': otp},
    );
  }

  Future<Response> createUser({
    required Map<String, dynamic> user,
    required String otp,
  }) async {
    return await dio.post('/users/register', data: {'user': user, 'otp': otp});
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
