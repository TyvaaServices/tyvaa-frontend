import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/config/env_config.dart';

class ApiProvider {
  late Dio _dio;
  final _storage = const FlutterSecureStorage();

  ApiProvider() {
    BaseOptions options = BaseOptions(
      baseUrl: EnvConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    );

    _dio = Dio(options);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add Auth Token
          final token = await _storage.read(key: 'jwt_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Handle Global Errors (401, etc.)
          if (EnvConfig.enableLogs) {
            log('Api Error: ${e.message}', name: 'ApiProvider', error: e);
          }
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
