import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewController extends GetxController {
  // Text controllers
  final TextEditingController currentLocationController = TextEditingController(
    text: "Votre position actuelle",
  );
  final TextEditingController destinationController = TextEditingController();

  // Focus nodes
  final FocusNode currentLocationFocusNode = FocusNode();
  final FocusNode destinationFocusNode = FocusNode();

  // Observable values
  final RxBool isSearching = false.obs;
  final RxList<String> searchResults = <String>[].obs;
  final RxBool showClearButton = false.obs;

  // Mock recent locations (would come from storage in real app)
  final List<RecentLocation> recentLocations = [
    RecentLocation(
      "Centre Commercial Cap 3000",
      "Avenue Eugène Donadeï, Saint-Laurent-du-Var",
      Icons.shopping_bag_outlined,
    ),
    RecentLocation(
      "Aéroport Nice Côte d'Azur",
      "Rue Costes et Bellonte, Nice",
      Icons.flight_outlined,
    ),
    RecentLocation(
      "Gare SNCF de Nice Ville",
      "Avenue Thiers, Nice",
      Icons.train_outlined,
    ),
    RecentLocation(
      "Promenade des Anglais",
      "Nice",
      Icons.beach_access_outlined,
    ),
    RecentLocation(
      "Place Masséna",
      "Centre-ville, Nice",
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
