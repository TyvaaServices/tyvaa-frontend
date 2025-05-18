import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PermissionService extends GetxService {
  static PermissionService get to => Get.find();
  final _logger = Logger();
  final _secureStorage = FlutterSecureStorage();

  // Observable status variables
  final isLocationPermissionGranted = false.obs;
  final isLocationServiceEnabled = false.obs;
  final locationDeniedForever = false.obs;

  // Constants for storage keys
  static const String _locationPermissionDeniedPermanently = 'location_denied_permanently';

  Future<PermissionService> init() async {
    _logger.d('Initializing PermissionService');
    await _checkLocationPermission();
    return this;
  }

  /// Checks the current location permission status WITHOUT requesting permission
  Future<LocationPermission> _checkLocationPermission() async {
    try {
      // Check if location services are enabled
      isLocationServiceEnabled.value = await Geolocator.isLocationServiceEnabled();

      // Only check permission status, don't request it
      final permission = await Geolocator.checkPermission();

      // Update our observables based on the permission status
      isLocationPermissionGranted.value =
          permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;

      locationDeniedForever.value = permission == LocationPermission.deniedForever;

      // Save denial status for future app launches
      if (permission == LocationPermission.deniedForever) {
        await _secureStorage.write(
          key: _locationPermissionDeniedPermanently,
          value: 'true'
        );
      }

      _logger.d('Location permission status: $permission');
      _logger.d('Location services enabled: ${isLocationServiceEnabled.value}');

      return permission;
    } catch (e) {
      _logger.e('Error checking location permission: $e');
      return LocationPermission.denied;
    }
  }

  /// Check permission status without requesting it
  Future<LocationPermission> checkLocationPermission() async {
    return await Geolocator.checkPermission();
  }

  /// Explicitly requests location permission from the user
  /// THIS WILL TRIGGER THE SYSTEM DIALOG
  Future<LocationPermission> requestLocationPermission() async {
    try {
      // This is where the Android system dialog appears
      final permission = await Geolocator.requestPermission();

      // Update observables based on the user's response
      isLocationPermissionGranted.value =
          permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;

      locationDeniedForever.value = permission == LocationPermission.deniedForever;

      // Save denial status for future app launches
      if (permission == LocationPermission.deniedForever) {
        await _secureStorage.write(
          key: _locationPermissionDeniedPermanently,
          value: 'true'
        );
      }

      return permission;
    } catch (e) {
      _logger.e('Error requesting location permission: $e');
      return LocationPermission.denied;
    }
  }

  /// Opens location settings on the device
  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  /// Opens the app settings page on the device
  Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }

  /// Shows a custom dialog explaining why the app needs location permission
  void showPermissionRationale(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF2D3142);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardColor,
        title: Text(
          'Localisation requise',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pour offrir une expérience optimale, Tyvaa a besoin de votre position pour:',
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 16),
            _buildFeatureItem(
              icon: Icons.location_on_rounded,
              text: 'Trouver des trajets à proximité',
              textColor: textColor,
            ),
            const SizedBox(height: 8),
            _buildFeatureItem(
              icon: Icons.people_rounded,
              text: 'Connecter avec des conducteurs proches',
              textColor: textColor,
            ),
            const SizedBox(height: 8),
            _buildFeatureItem(
              icon: Icons.map_rounded,
              text: 'Calculer des itinéraires précis',
              textColor: textColor,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Plus tard'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.toNamed('/location-permission');
            },
            child: Text('Activer'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String text,
    required Color textColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: Get.theme.colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }

  /// Checks if location permission is required for navigation
  /// Returns true if the user should be directed to permission screen
  Future<bool> shouldShowPermissionScreen() async {
    final permissionStatus = await checkLocationPermission();
    final isEnabled = await Geolocator.isLocationServiceEnabled();

    return permissionStatus == LocationPermission.denied ||
           permissionStatus == LocationPermission.deniedForever ||
           !isEnabled;
  }
}
