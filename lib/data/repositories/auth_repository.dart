import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:isar_plus/isar_plus.dart';
import '../providers/api_provider.dart';
import '../providers/isar_provider.dart';
import '../entities/user.dart';

abstract class IAuthRepository {
  Future<void> sendOtp(String phone);
  Future<User?> verifyOtp(String phone, String code);
  Future<User?> getCurrentUser();
  Future<void> updateProfile(User user);
  Future<void> logout();
}

class AuthRepository extends GetxService implements IAuthRepository {
  final ApiProvider _apiProvider;
  final IsarProvider _isarProvider;
  final _storage = const FlutterSecureStorage();

  AuthRepository(this._apiProvider, this._isarProvider);

  @override
  Future<void> sendOtp(String phone) async {
    try {
      // For now, trigger login flow to send OTP
      // In real backend, might be separate endpoint
      await _apiProvider.dio.post('/auth/login', data: {'phoneNumber': phone});
    } catch (e) {
      // Ignore error for mock/dev if backend not ready
      // log("Send OTP error (ignored for dev): $e");
    }
  }

  @override
  Future<User?> verifyOtp(String phone, String code) async {
    try {
      final response = await _apiProvider.dio.post(
        '/auth/verify-otp',
        data: {'phoneNumber': phone, 'code': code},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final token = response.data['token'];
        if (token != null) {
          await _storage.write(key: 'jwt_token', value: token);
          // After verifying, fetch user
          return await getCurrentUser();
        }
      }
      return null;
    } catch (e) {
      // Mock User for Dev if API fails
      if (code == '123456') {
        return User()
          ..remoteId = 'user_mock_1'
          ..phoneNumber = phone
          ..fullName =
              '' // Empty to trigger registration flow
          ..role = 'passenger';
      }
      return null;
    }
  }

  @override
  Future<void> updateProfile(User user) async {
    try {
      // Mock update to API
      // await _apiProvider.dio.put('/users/me', data: user.toJson());

      // Update Local
      final isar = await _isarProvider.db;
      await isar.writeAsync((isar) {
        isar.users.put(user);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final isar = await _isarProvider.db;
    try {
      final response = await _apiProvider.dio.get('/users/me');
      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);

        await isar.writeAsync((isar) async {
          final existing = isar.users
              .where()
              .remoteIdEqualTo(user.remoteId)
              .findFirst();
          if (existing != null) {
            user.id = existing.id;
          } else {
            user.id = isar.users.autoIncrement();
          }
          isar.users.put(user);
        });

        await _storage.write(key: 'current_user_id', value: user.remoteId);
        return user;
      }
      return null;
    } catch (e) {
      final currentUserId = await _storage.read(key: 'current_user_id');
      if (currentUserId != null) {
        final user = isar.users
            .where()
            .remoteIdEqualTo(currentUserId)
            .findFirst();
        if (user != null) return user;
      }
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
    await _storage.delete(key: 'current_user_id');
  }
}
