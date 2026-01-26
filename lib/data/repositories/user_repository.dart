import 'package:get/get.dart';
import 'package:isar_plus/isar_plus.dart';
import '../providers/api_provider.dart';
import '../providers/isar_provider.dart';
import '../entities/user.dart';

abstract class IUserRepository {
  Future<User?> getProfile();
  Future<User> updateProfile(User user);
  Future<void> becomeDriver();
  Future<List<User>> getDriverById(String driverId);
}

class UserRepository extends GetxService implements IUserRepository {
  final ApiProvider _apiProvider;
  final IsarProvider _isarProvider;

  UserRepository(this._apiProvider, this._isarProvider);

  @override
  Future<User?> getProfile() async {
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

        return user;
      }
      return null;
    } catch (e) {
      // Offline: return cached user
      return isar.users.where().findFirst();
    }
  }

  @override
  Future<User> updateProfile(User user) async {
    final response = await _apiProvider.dio.put(
      '/users/me',
      data: user.toJson(),
    );
    if (response.statusCode == 200) {
      final updatedUser = User.fromJson(response.data);

      final isar = await _isarProvider.db;
      await isar.writeAsync((isar) async {
        final existing = isar.users
            .where()
            .remoteIdEqualTo(updatedUser.remoteId)
            .findFirst();
        if (existing != null) {
          updatedUser.id = existing.id;
        }
        isar.users.put(updatedUser);
      });

      return updatedUser;
    }
    throw Exception('Failed to update profile');
  }

  @override
  Future<void> becomeDriver() async {
    await _apiProvider.dio.post('/users/me/become-driver');

    final isar = await _isarProvider.db;
    await isar.writeAsync((isar) async {
      final user = isar.users.where().findFirst();
      if (user != null) {
        user.role = 'conducteur';
        isar.users.put(user);
      }
    });
  }

  @override
  Future<List<User>> getDriverById(String driverId) async {
    // For displaying driver info on ride cards
    final isar = await _isarProvider.db;
    try {
      final response = await _apiProvider.dio.get('/users/$driverId');
      if (response.statusCode == 200) {
        final driver = User.fromJson(response.data);
        return [driver];
      }
      return [];
    } catch (e) {
      final cached = isar.users.where().remoteIdEqualTo(driverId).findFirst();
      return cached != null ? [cached] : [];
    }
  }
}
