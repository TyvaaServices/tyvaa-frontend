import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/search/controllers/search_controller.dart';
import 'package:passenger_tyvaa/app/socket/SocketService.dart';
import 'package:passenger_tyvaa/app/services/permission_service.dart';

class HomeController extends GetxController {
  final bannerController = PageController(viewportFraction: 0.9);
  final currentBanner = 0.obs;
  final selectedIndex = 0.obs;
  late Timer _bannerTimer;
  RxString currentAddress = ''.obs;
  late StreamSubscription<Position> _positionStream;
  RxBool isDriver = true.obs;
  final permissionChecked = false.obs;

  late ConfettiController confettiController;
  final banners = [
    {
      'image': 'assets/promo1.png',
      'title': 'Voyagez en toute sérénité',
      'subtitle': 'Des trajets vérifiés et sécurisés',
    },
    {
      'image': 'assets/promo2.png',
      'title': 'Éco-mobilité intelligente',
      'subtitle': 'Réduisez votre empreinte carbone',
    },
    {
      'image': 'assets/promo3.png',
      'title': 'Communauté bienveillante',
      'subtitle': 'Rejoignez des milliers de membres',
    },
  ];

  @override
  Future<void> onInit() async {
    // Check permission status without requesting permission
    await _checkPermissionStatus();

    super.onInit();
    confettiController = ConfettiController(
      duration: const Duration(seconds: 5),
    );

    Future.delayed(Duration(milliseconds: 500), () {
      confettiController.play();
    });
    bannerController.addListener(() {
      final page = bannerController.page?.round() ?? 0;
      currentBanner.value = page;
    });
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (currentBanner.value + 1) % banners.length;
      if (bannerController.hasClients) {
        bannerController.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // New method to check permission without requesting it
  Future<void> _checkPermissionStatus() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // If permission not granted or location service disabled, show our custom screen
      if ((permission == LocationPermission.denied ||
           permission == LocationPermission.deniedForever ||
           !serviceEnabled) &&
           !permissionChecked.value) {

        permissionChecked.value = true;

        // Small delay to ensure UI is ready
        await Future.delayed(Duration(milliseconds: 300));

        // Navigate to our custom permission screen
        Get.toNamed('/location-permission');
      } else if (permission == LocationPermission.whileInUse ||
                permission == LocationPermission.always) {
        // If permission already granted, initialize location tracking
        _startLocationTracking();
      }
    } catch (e) {
      print('Error checking location permission: $e');
    }
  }

  // Modified to separate checking and requesting permissions
  Future<void> _startLocationTracking() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        currentAddress.value = 'Services de localisation désactivés';
        return;
      }

      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen((Position position) async {
        final searchViewController = Get.find<SearchViewController>();

        final oldLat = searchViewController.user.value?.latitude;
        final oldLon = searchViewController.user.value?.longitude;

        final newLat = position.latitude;
        final newLon = position.longitude;

        if ((oldLat == null || oldLon == null) ||
            (Geolocator.distanceBetween(oldLat, oldLon, newLat, newLon) > 10)) {
          searchViewController.user.value!.latitude = newLat;
          searchViewController.user.value!.longitude = newLon;

          SocketService().initSocket(
            "1",
            newLat,
            newLon,
          ); // avoid reconnecting unnecessarily
          final placemarks = await placemarkFromCoordinates(newLat, newLon);
          final place = placemarks.first;

          currentAddress.value =
              '${place.thoroughfare ?? ''} ${place.locality ?? ''}, ${place.country ?? ''}';
        }
      });
    } catch (e) {
      print('Error starting location tracking: $e');
      currentAddress.value = 'Erreur de localisation';
    }
  }

  @override
  void onClose() {
    _bannerTimer.cancel();
    bannerController.dispose();
    confettiController.dispose();
    super.onClose();
  }

  final isPassengerMode = true.obs;
  final isDriverOnline = false.obs;

  void setPassengerMode() {
    isPassengerMode.value = true;
  }

  void setDriverMode() {
    isPassengerMode.value = false;
  }

  void toggleDriverOnline() {
    isDriverOnline.value = !isDriverOnline.value;
    if (isDriverOnline.value) {
      Get.snackbar(
        'En ligne',
        'Vous êtes maintenant disponible pour recevoir des demandes de trajet',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );
    } else {
      Get.snackbar(
        'Hors ligne',
        'Vous n\'êtes plus disponible pour recevoir des demandes',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
        icon: const Icon(Icons.offline_bolt, color: Colors.white),
      );
    }
  }

  void changeTab(int index) => selectedIndex.value = index;
}
