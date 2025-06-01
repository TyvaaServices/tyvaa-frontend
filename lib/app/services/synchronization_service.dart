import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/modules/profile/controllers/profile_controller.dart';

import '../../domain/entities/user.dart';
import '../api/api_client.dart';
import 'connectivity_service.dart';

class SynchronizationService extends GetxService {
  final logger = Logger();
  final ApiClient apiClient = Get.find<ApiClient>();
  final ConnectivityController connectivityController =
      Get.find<ConnectivityController>();

  Timer? _periodicSyncTimer;
  Worker? _connectivityWorker;

  final _syncInterval = const Duration(seconds: 5);
  final RxBool _isSyncing = false.obs;
  final RxBool _hasPendingChanges = false.obs;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const String _pendingChangesKey = 'has_pending_changes';

  Future<SynchronizationService> init() async {
    //essaye de verifier si il y a des changements locaux
    final storedFlag = await _secureStorage.read(key: _pendingChangesKey);
    _hasPendingChanges.value = storedFlag == 'true';

    // et la si ya internet on sync
    _connectivityWorker = ever(connectivityController.hasInternet, (
      bool hasInternet,
    ) {
      if (hasInternet && _hasPendingChanges.value && !_isSyncing.value) {
        logger.d(
          'Internet connection available, pushing local changes to API...',
        );
        syncUserToApi();
      }
    });

    _setupPeriodicSync();

    return this;
  }

  void _setupPeriodicSync() {
    _periodicSyncTimer?.cancel();
    _periodicSyncTimer = Timer.periodic(_syncInterval, (timer) {
      if (connectivityController.hasInternet.value &&
          _hasPendingChanges.value &&
          !_isSyncing.value) {
        logger.d('Periodic sync attempt triggered');
        syncUserToApi();
      }
    });
  }

  void markUserChanged() async {
    _hasPendingChanges.value = true;
    await _secureStorage.write(key: _pendingChangesKey, value: 'true');

    if (connectivityController.hasInternet.value && !_isSyncing.value) {
      syncUserToApi();
    } else {
      logger.d('Changes marked for sync when internet becomes available');
    }
  }

  Future<void> syncUserToApi() async {
    if (_isSyncing.value || !_hasPendingChanges.value) return;

    _isSyncing.value = true;

    try {
      final token = await _secureStorage.read(key: 'auth_token');

      if (token == null) {
        logger.d('No auth token, cannot sync to API');
        return;
      }

      var box = Hive.box<User>('users');
      final currentUser = box.get('currentUser');

      if (currentUser == null) {
        logger.d('No current user in Hive, nothing to sync');
        return;
      }
      final ProfileController profileController = Get.find<ProfileController>();
      final success = await apiClient.updateUserProfile(
        currentUser,
        profileController,
      );

      if (success) {
        _hasPendingChanges.value = false;
        await _secureStorage.write(key: _pendingChangesKey, value: 'false');

        logger.d(
          '✅ User data successfully pushed to API: ${currentUser.phoneNumber}',
        );

        // Get.snackbar(
        //   'Synchronisation réussie',
        //   'Vos informations ont été synchronisées avec le serveur',
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        //   duration: Duration(seconds: 2),
        // );
      } else {
        logger.e('⚠️ Failed to push user data to API');
      }
    } catch (e) {
      logger.e('❌ Error during API sync: $e');
    } finally {
      _isSyncing.value = false;
    }
  }

  @override
  void onClose() {
    _periodicSyncTimer?.cancel();
    _connectivityWorker?.dispose();
    super.onClose();
  }
}
