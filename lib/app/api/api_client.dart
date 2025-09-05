import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/modules/profile/controllers/profile_controller.dart';
import 'package:passenger_tyvaa/app/services/connectivity_service.dart';
import 'package:passenger_tyvaa/domain/entities/ride_model.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

class ApiClient {
  var logger = Logger();
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3000/api/v1',
      //dev
      // baseUrl: 'https://backend-tyvaa-traorecheikh-24a52997.koyeb.app/api/v1',
      //prod
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

  DateTime? _lastFailureTime;
  int _consecutiveFailures = 0;
  bool _circuitOpen = false;
  static const int _maxConsecutiveFailures = 5;
  static const Duration _circuitBreakerTimeout = Duration(minutes: 2);

  ApiClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_circuitOpen) {
            final now = DateTime.now();
            if (_lastFailureTime != null &&
                now.difference(_lastFailureTime!) > _circuitBreakerTimeout) {
              _circuitOpen = false;
              _consecutiveFailures = 0;
              logger.i('Circuit breaker reset - retrying requests');
            } else {
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
          Logger logger = Logger();
          logger.e('Request error: ${error.message}');
          if (_circuitOpen) {
            final now = DateTime.now();
            if (_lastFailureTime != null &&
                now.difference(_lastFailureTime!) > _circuitBreakerTimeout) {
              _circuitOpen = false;
              _consecutiveFailures = 0;
              logger.i(
                '� Circuit breaker timeout expired - allowing requests again',
              );
            } else {
              return handler.next(error);
            }
          }

          const maxRetries = 2;
          final retries = error.requestOptions.extra['retries'] ?? 0;

          final shouldRetry = [
            DioExceptionType.connectionTimeout,
            DioExceptionType.receiveTimeout,
            DioExceptionType.sendTimeout,
            DioExceptionType.connectionError,
          ].contains(error.type);

          if (shouldRetry && retries < maxRetries && !_circuitOpen) {
            final delaySeconds = 1; // Fixed 1 second delay
            final retryDelay = Duration(seconds: delaySeconds);

            await Future.delayed(retryDelay);

            final options = error.requestOptions;
            options.extra['retries'] = retries + 1;

            try {
              final response = await dio.fetch(options);
              _consecutiveFailures = 0;
              if (_circuitOpen) {
                _circuitOpen = false;
                logger.i('🟢 Circuit breaker CLOSED - API is back online');
              }
              return handler.resolve(response);
            } catch (e) {
              return handler.next(e as DioException);
            }
          }

          _consecutiveFailures++;
          _lastFailureTime = DateTime.now();

          if (_consecutiveFailures >= _maxConsecutiveFailures &&
              !_circuitOpen) {
            _circuitOpen = true;
            logger.e(
              '🔴 Circuit breaker OPENED - API appears down. Blocking requests for ${_circuitBreakerTimeout.inMinutes} minutes.',
            );
          }

          return handler.next(error);
        },
        onResponse: (response, handler) {
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

  bool get isCircuitBreakerOpen => _circuitOpen;

  int get consecutiveFailures => _consecutiveFailures;

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

  /// Requests a login OTP, sending the phone number and optional FCM token.
  Future<Response> requestLoginOtp(
    String phoneNumber, {
    String? fcmToken,
  }) async {
    final data = {'phoneNumber': phoneNumber};
    if (fcmToken != null) {
      data['fcmToken'] = fcmToken;
    }
    return await dio.post('/users/request-login-otp', data: data);
  }

  /// Requests a register OTP, sending the phone number and optional FCM token.
  Future<Response> requestRegisterOtp({
    required String phoneNumber,
    String? fcmToken,
  }) async {
    final data = {'phoneNumber': phoneNumber};
    if (fcmToken != null) {
      data['fcmToken'] = fcmToken;
    }
    Logger logger = Logger();
    logger.d(
      'Requesting register OTP for $phoneNumber with FCM token: $fcmToken',
    );
    return await dio.post('/users/request-register-otp', data: data);
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
    // Send user data at root level with OTP, not nested under 'user' key
    final requestData = Map<String, dynamic>.from(user);
    requestData['otp'] = otp;

    return await dio.post('/users/register', data: requestData);
  }

  Future<Response> getAllBookings() async {
    return await dio.get('/bookings');
  }

  Future<Response> getUserBookings(int userId) async {
    return await dio.get('/bookings/user/$userId');
  }

  Future<Response> getBookingById(int bookingId) async {
    return await dio.get('/bookings/$bookingId');
  }

  Future<Response> cancelBooking(int bookingId) async {
    return await dio.delete('/bookings/$bookingId');
  }

  Future<Response> bookRide({required Map<String, dynamic> booking}) async {
    logger.d('Booking ride with data: $booking');

    // Ensure all required fields are present and properly typed
    // Don't remove null values for required fields, instead validate them
    if (booking['rideInstanceId'] == null) {
      throw ArgumentError('rideInstanceId is required');
    }
    if (booking['userId'] == null) {
      throw ArgumentError('userId is required');
    }

    final sanitizedBooking = {
      'rideInstanceId': booking['rideInstanceId'] as int,
      'seatsBooked': (booking['seatsBooked'] as int?) ?? 1,
      // Default to 1 if null
      'userId': booking['userId'] as int,
      'status': (booking['status'] as String?) ?? 'pending',
      // Default to pending
    };

    logger.d('Sanitized booking data: $sanitizedBooking');
    logger.d(
      'Booking data types: ${sanitizedBooking.map((k, v) => MapEntry(k, v.runtimeType))}',
    );

    try {
      final response = await dio.post('/bookings/book', data: sanitizedBooking);
      logger.d('Booking response: ${response.statusCode} - ${response.data}');
      return response;
    } catch (e) {
      logger.e('Booking request failed: $e');
      if (e is DioException && e.response != null) {
        logger.e('Server response: ${e.response?.data}');
        logger.e('Request data sent: ${e.requestOptions.data}');
      }
      rethrow;
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

  /// Publish a ride (create ride template)
  Future<Response> publishRide({required RideModel ride}) async {
    return await dio.post('/rides', data: ride.toJson());
  }

  Future searchRides({
    required String departure,
    String?
    destination, // Make destination optional to support "departure only" searches
    DateTime? date,
  }) async {
    if (!_connectivityController.hasInternet.value) {
      logger.w('No internet connection. Cannot search rides.');
      return {'statusCode': 400, 'error': 'No internet connection', 'data': []};
    }

    try {
      // Build query parameters dynamically
      final Map<String, dynamic> queryParams = {'departure': departure.trim()};

      // Only add destination if provided (supports departure-only searches)
      if (destination != null && destination.trim().isNotEmpty) {
        queryParams['destination'] = destination.trim();
      }

      // Format date as YYYY-MM-DD for better API compatibility
      if (date != null) {
        queryParams['date'] =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      }

      logger.d('Searching rides with params: $queryParams');

      final response = await dio.get(
        '/rides/search',
        queryParameters: queryParams,
      );

      logger.d('Search response: ${response.statusCode} - ${response.data}');

      // Handle successful response
      if (response.statusCode == 200) {
        // Check if backend returns error in body
        if (response.data is Map && response.data.containsKey('error')) {
          return {
            'statusCode': response.data['statusCode'] ?? response.statusCode,
            'error': response.data['error'],
            'data': response.data['data'] ?? [],
          };
        }

        // Return successful response
        return {
          'statusCode': response.statusCode,
          'data': response.data ?? [],
          'error': null,
        };
      } else {
        return {
          'statusCode': response.statusCode,
          'error': 'Unexpected response status: ${response.statusCode}',
          'data': [],
        };
      }
    } on DioException catch (e) {
      logger.e('Error searching rides: ${e.message}');

      // Provide more specific error messages
      String errorMessage;
      int statusCode = e.response?.statusCode ?? 500;

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = 'Connection timeout. Please try again.';
          break;
        case DioExceptionType.connectionError:
          errorMessage = 'Network error. Please check your connection.';
          break;
        case DioExceptionType.badResponse:
          errorMessage =
              e.response?.data?['message'] ?? 'Server error occurred.';
          break;
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';
      }

      return {'statusCode': statusCode, 'error': errorMessage, 'data': []};
    } catch (e) {
      logger.e('Unexpected error searching rides: $e');
      return {
        'statusCode': 500,
        'error': 'An unexpected error occurred. Please try again.',
        'data': [],
      };
    }
  }

  Future<Response> getAllLandmarks() async {
    try {
      return await dio.get('/rides/landmarks');
    } catch (e) {
      logger.e('Error fetching landmarks: ${e.toString()}');
      return Response(
        requestOptions: RequestOptions(path: '/rides/landmarks'),
        statusCode: 500,
        data: [],
      );
    }
  }
}
