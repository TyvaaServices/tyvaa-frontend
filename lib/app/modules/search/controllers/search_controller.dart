import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/modules/search/views/search_page.dart';

import '../../../../domain/entities/user.dart';

class SearchViewController extends GetxController {
  Rxn<User> user = Rxn<User>();
  final TextEditingController currentLocationController = TextEditingController(
    text: "Votre position actuelle",
  );
  final RxDouble currentLat = 0.0.obs;
  final RxDouble currentLon = 0.0.obs;
  final RxString countryCode = 'sn'.obs;
  void setLocationContext(double lat, double lon, String country) {
    currentLat.value = lat;
    currentLon.value = lon;
    countryCode.value = country.toLowerCase();
  }

  final TextEditingController destinationController = TextEditingController();

  final FocusNode currentLocationFocusNode = FocusNode();
  final FocusNode destinationFocusNode = FocusNode();

  final RxBool isSearching = false.obs;
  final RxList<String> searchResults = <String>[].obs;
  final RxBool showClearButton = false.obs;

  final List<RecentLocation> recentLocations = [
    RecentLocation(
      "Sandaga",
      "Avenue Lamine Gueye, Dakar",
      Icons.shopping_bag_outlined,
    ),
    RecentLocation(
      "Aéroport International Blaise Diagne",
      "Diass, Dakar",
      Icons.flight_outlined,
    ),
    RecentLocation("Gare de Dakar", "Plateau, Dakar", Icons.train_outlined),
    RecentLocation("Plage de Ngor", "Ngor, Dakar", Icons.beach_access_outlined),
    RecentLocation(
      "Place de l'Indépendance",
      "Centre-ville, Dakar",
      Icons.location_city_outlined,
    ),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    final box = Hive.box<User>('users');
    user.value = box.get('currentUser');
    currentLat.value = user.value?.latitude ?? 0;
    currentLon.value = user.value?.longitude ?? 0;
    setupListeners();
    forceFocus();
  }

  Timer? _debounce;

  void setupListeners() {
    destinationController.addListener(() {
      final query = destinationController.text;

      showClearButton.value = query.isNotEmpty;

      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(milliseconds: 400), () async {
        if (query.isNotEmpty) {
          isSearching.value = true;

          try {
            final results = await searchLocations(
              query,
              lat: currentLat.value,
              lon: currentLon.value,
              countryCode: countryCode.value,
            );

            searchResults.value =
                results.map((item) => item['display_name'] as String).toList();
          } catch (e) {
            debugPrint('Search error: $e');
          }
        } else {
          isSearching.value = false;
          searchResults.clear();
        }
      });
    });
  }

  void forceFocus() {
    Future.delayed(const Duration(milliseconds: 800), () {
      destinationFocusNode.requestFocus();
    });
  }

  void clearDestination() {
    destinationController.clear();
    destinationFocusNode.requestFocus();
  }

  void swapLocations() {
    if (destinationController.text.isNotEmpty) {
      final temp = currentLocationController.text;
      currentLocationController.text = destinationController.text;
      destinationController.text = temp;
    }
  }

  void selectDestination(String destination) {
    destinationController.text = destination;
    destinationFocusNode.unfocus();
  }

  Future<void> checkTripLength(double destLat, double destLon) async {
    final distanceInMeters = Geolocator.distanceBetween(
      currentLat.value,
      currentLon.value,
      destLat,
      destLon,
    );
    var logger = Logger();
    logger.d(" cheikht ${user.value!.latitude} ${user.value!.longitude}");
    logger.d(" cheikhtt ${destLat} ${destLon}");

    final distanceInKm = distanceInMeters / 1000;

    final isLong = distanceInKm > 60;

    Get.snackbar(
      isLong ? "Long voyage" : "Court voyage",
      'Distance: ${distanceInKm.toStringAsFixed(2)} km',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isLong ? Colors.deepOrange : Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
    );
  }

  @override
  void onClose() {
    currentLocationController.dispose();
    destinationController.dispose();
    currentLocationFocusNode.dispose();
    destinationFocusNode.dispose();
    super.onClose();
  }
}

class RecentLocation {
  final String title;
  final String subtitle;
  final IconData icon;

  RecentLocation(this.title, this.subtitle, this.icon);
}
