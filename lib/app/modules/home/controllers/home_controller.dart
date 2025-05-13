import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/socket/SocketService.dart';

class HomeController extends GetxController {
  final bannerController = PageController(viewportFraction: 0.9);
  final currentBanner = 0.obs;
  final selectedIndex = 0.obs;
  late Timer _bannerTimer;
  RxString currentAddress = ''.obs;
  late StreamSubscription<Position> _positionStream;
  RxBool isDriver = true.obs;

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

  // @override
  // void onInit() {
  //   _bannerTimer = Timer.periodic(const Duration(seconds: 3), (_) {
  //     final next = (currentBanner.value + 1) % banners.length;
  //     if (bannerController.hasClients) {
  //       bannerController.animateToPage(
  //         next,
  //         duration: const Duration(milliseconds: 500),
  //         curve: Curves.easeInOut,
  //       );
  //     }
  //   });
  //   super.onInit();
  // }
  @override
  void onInit() {
    _determinePosition();
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

  Future<void> _determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        currentAddress.value = 'Services de localisation désactivés';
        return;
      }

      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10, // meters
        ),
      ).listen((Position position) async {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        SocketService().initSocket("1", position.latitude, position.longitude);
        Placemark place = placemarks.first;
        currentAddress.value =
            '${place.thoroughfare} ${place.locality}, ${place.country}';
      });
    } else {
      currentAddress.value = 'Localisation refusée';
    }
  }
}
