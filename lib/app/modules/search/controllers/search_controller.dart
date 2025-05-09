// search_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final TextEditingController destinationController = TextEditingController();

  // Mock data for Senegal locations
  final List<String> dakarDistricts = [
    'Plateau',
    'Médina',
    'Grand Dakar',
    'Fann',
    'Point E',
    'Ouakam',
    'Yoff',
    'Ngor',
    'Almadies',
    'Mermoz',
    'Sacré-Coeur',
    'Liberté',
    'HLM',
    'Sicap',
    'Parcelles Assainies',
  ];

  final List<String> senegalCities = [
    'Saint-Louis',
    'Thiès',
    'Rufisque',
    'Kaolack',
    'Ziguinchor',
    'Touba',
    'Tambacounda',
    'Kolda',
    'Mbour',
    'Diourbel',
    'Louga',
    'Matam',
    'Kédougou',
    'Fatick',
    'Sédhiou',
  ];

  final List<String> popularRoutes = [
    'Dakar → Saint-Louis',
    'Dakar → Mbour',
    'Plateau → Yoff',
    'Dakar → Saly',
    'Médina → Almadies',
  ];

  bool isLongDistance(String destination) {
    // If destination is a Dakar district, it's not long distance
    if (dakarDistricts.any(
      (district) => destination.toLowerCase().contains(district.toLowerCase()),
    )) {
      return false;
    }

    // If destination is another city, it's long distance
    if (senegalCities.any(
      (city) => destination.toLowerCase().contains(city.toLowerCase()),
    )) {
      return true;
    }

    // Default: if text is long, assume it might be long distance
    return destination.length > 6;
  }

  // Filter locations based on search query
  List<String> getFilteredLocations(String query) {
    query = query.toLowerCase();

    List<String> results = [];

    // Add matching Dakar districts
    results.addAll(
      dakarDistricts
          .where((district) => district.toLowerCase().contains(query))
          .map((district) => district + ', Dakar'),
    );

    // Add matching Senegal cities
    results.addAll(
      senegalCities
          .where((city) => city.toLowerCase().contains(query))
          .map((city) => city + ', Sénégal'),
    );

    return results;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    destinationController.dispose();
    super.onClose();
  }
}
