import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/services/permission_service.dart';

class LocationPermissionController extends GetxController {
  final isLoading = false.obs;
  final permissionService = Get.find<PermissionService>();

  @override
  void onInit() {
    super.onInit();
    // Only check permission status without requesting on screen load
    _checkPermissionStatus();
  }

  // Only check status, don't request permission
  Future<void> _checkPermissionStatus() async {
    final status = await Geolocator.checkPermission();
    permissionService.isLocationPermissionGranted.value =
        status == LocationPermission.whileInUse ||
        status == LocationPermission.always;
  }

  // This function is called when the user taps "Allow" on our custom UI
  Future<void> requestLocationPermission() async {
    isLoading.value = true;

    try {
      // First, just check if permission is already granted (without requesting)
      final initialStatus = await Geolocator.checkPermission();

      // If already granted, just check if location service is enabled
      if (initialStatus == LocationPermission.whileInUse ||
          initialStatus == LocationPermission.always) {
        _checkLocationService();
        return;
      }

      // Now we explicitly request the permission - this will show the system dialog
      LocationPermission permission =
          await permissionService.requestLocationPermission();

      // Handle the permission result
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        // Location permission granted, check if service is enabled
        _checkLocationService();
      } else if (permission == LocationPermission.denied) {
        // User denied the permission request but can be asked again
        Get.snackbar(
          'Permission refusée',
          'L\'accès à la localisation est nécessaire pour utiliser pleinement l\'application',
          backgroundColor: Colors.amber,
          colorText: Colors.black87,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoading.value = false;
      } else if (permission == LocationPermission.deniedForever) {
        // User denied the permission forever
        Get.dialog(
          AlertDialog(
            title: Text('Permission requise'),
            content: Text(
              'Vous avez refusé définitivement l\'accès à votre localisation. '
              'Pour utiliser toutes les fonctionnalités de l\'application, veuillez '
              'activer la permission dans les paramètres de votre appareil.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  permissionService.openAppSettings();
                },
                child: Text('Ouvrir les paramètres'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  // We'll stay on this screen to encourage the user to grant permissions
                },
                child: Text('Plus tard'),
              ),
            ],
          ),
        );
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur s\'est produite lors de la demande d\'autorisation',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        snackPosition: SnackPosition.BOTTOM,
      );

      isLoading.value = false;
    }
  }

  void skipPermission() {
    // Show a dialog explaining that location permissions are required
    Get.dialog(
      AlertDialog(
        title: Text('Permission recommandée'),
        content: Text(
          'Sans l\'accès à votre localisation, certaines fonctionnalités clés comme '
          'la recherche de trajets à proximité ne fonctionneront pas correctement.\n\n'
          'Souhaitez-vous vraiment continuer sans activer la localisation?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Non, autoriser'),
          ),
          TextButton(
            onPressed: () {
              Get.back();

              // Store the user's decision but we'll remind them again later
              // Navigate to main screen while flagging the app to show reminders
              Get.offAllNamed('/main', arguments: {'permission_skipped': true});

              // Show a message that functionality will be limited
              Get.snackbar(
                'Fonctionnalités limitées',
                'Vous pourrez activer la localisation plus tard dans les paramètres',
                backgroundColor: Colors.amber,
                colorText: Colors.black87,
                duration: const Duration(seconds: 5),
                margin: const EdgeInsets.all(16),
                borderRadius: 12,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Text('Oui, continuer'),
          ),
        ],
      ),
    );
  }

  Future<void> _checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are disabled, prompt the user to enable them
      Get.dialog(
        AlertDialog(
          title: Text('Services de localisation désactivés'),
          content: Text(
            'Les services de localisation sont désactivés sur votre appareil. '
            'Veuillez les activer pour utiliser toutes les fonctionnalités de l\'application.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                permissionService.openLocationSettings();
              },
              child: Text('Activer'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                // We'll stay on this screen to encourage the user to enable location
              },
              child: Text('Plus tard'),
            ),
          ],
        ),
      );
      isLoading.value = false;
    } else {
      // Everything is good, navigate to main screen
      isLoading.value = false;
      Get.offAllNamed('/main');
    }
  }
}
