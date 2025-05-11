import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewController extends GetxController {
  final TextEditingController currentLocationController = TextEditingController(
    text: "Votre position actuelle",
  );
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
  void onInit() {
    super.onInit();
    setupListeners();
    forceFocus();
  }

  void setupListeners() {
    // Monitor text changes to show clear button when appropriate
    destinationController.addListener(() {
      showClearButton.value = destinationController.text.isNotEmpty;

      // Simple search simulation
      if (destinationController.text.isNotEmpty) {
        isSearching.value = true;
        // Simulated search results - in a real app would call an API
        searchResults.value =
            recentLocations
                .where(
                  (location) => location.title.toLowerCase().contains(
                    destinationController.text.toLowerCase(),
                  ),
                )
                .map((e) => e.title)
                .toList();
      } else {
        isSearching.value = false;
        searchResults.clear();
      }
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
