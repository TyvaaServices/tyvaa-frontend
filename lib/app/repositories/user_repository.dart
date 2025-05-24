import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/api/api_client.dart';
import 'package:passenger_tyvaa/app/services/connectivity_service.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';

class UserRepository {
  final _logger = Logger();
  final _userBox = Hive.box<User>('users');
  final ApiClient _apiClient = Get.find<ApiClient>();
  final ConnectivityController _connectivity =
      Get.find<ConnectivityController>();

  // Singleton instance
  static final UserRepository _instance = UserRepository._();

  factory UserRepository() => _instance;

  UserRepository._();

  /// Gets the current user from local storage
  User? getCurrentUser() {
    try {
      return _userBox.get('currentUser');
    } catch (e) {
      _logger.e('Error retrieving current user from Hive: $e');
      return null;
    }
  }

  /// Saves user to local storage after receiving from remote
  Future<bool> saveUser(User user) async {
    try {
      await _userBox.put('currentUser', user);
      _logger.d('User saved to local storage: ${user.fullName}');
      return true;
    } catch (e) {
      _logger.e('Error saving user to local storage: $e');
      return false;
    }
  }

  /// Tries to fetch fresh user data from API and update local storage
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

  /// Synchronizes local user data with the remote API
  Future<bool> synchronizeUserData(User user) async {
    if (!_connectivity.hasInternet.value) {
      return false;
    }

    try {
      final result = await _apiClient.updateUserProfile(user);
      return result;
    } catch (e) {
      _logger.e('Error synchronizing user data: $e');
      return false;
    }
  }

  /// Logout and clear user data
  Future<void> logout() async {
    await _userBox.delete('currentUser');
  }
}
