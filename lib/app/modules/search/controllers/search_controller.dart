// search_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  late AnimationController animationController;
  final TextEditingController searchController = TextEditingController();

  // Tabs state
  final selectedTab = 0.obs;
  final showRecent = true.obs;

  // Location lists
  final List<String> allRegions = [
    'Dakar',
    'Saint-Louis',
    'Thiès',
    'Kaolack',
    'Ziguinchor',
    'Tambacounda',
    'Louga',
    'Fatick',
    'Kolda',
    'Matam',
    'Kaffrine',
    'Sédhiou',
    'Kédougou',
    'Diourbel',
  ];

  final List<String> allDistricts = [
    'Médina',
    'Pikine',
    'Guédiawaye',
    'Parcelles Assainies',
    'Yoff',
    'Almadies',
    'Plateau',
    'Fann',
    'Grand Dakar',
    'Ouakam',
    'Ngor',
    'Liberté',
    'Sicap',
  ];

  // Filtered results
  final filteredLong = <String>[].obs;
  final filteredLocal = <String>[].obs;

  // Recent searches
  final recentSearches =
      <String>['Dakar → Thiès', 'Pikine → Médina', 'Saint-Louis → Dakar'].obs;

  // Popular items
  List<String> get popularRegions => allRegions.take(5).toList();

  List<String> get popularDistricts => allDistricts.take(5).toList();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabSelection);

    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    searchController.addListener(_handleSearchChanged);

    // Initialize filtered lists
    filteredLong.value = allRegions;
    filteredLocal.value = allDistricts;

    animationController.forward();
  }

  @override
  void onClose() {
    tabController.removeListener(_handleTabSelection);
    tabController.dispose();
    animationController.dispose();
    searchController.removeListener(_handleSearchChanged);
    searchController.dispose();
    super.onClose();
  }

  void _handleTabSelection() {
    selectedTab.value = tabController.index;
    if (searchController.text.isNotEmpty) {
      searchController.clear();
      showRecent.value = true;
    }
  }

  void _handleSearchChanged() {
    filterLocations(searchController.text);
  }

  void filterLocations(String query) {
    showRecent.value = query.isEmpty;

    if (selectedTab.value == 0) {
      filteredLong.value =
          allRegions
              .where((r) => r.toLowerCase().contains(query.toLowerCase()))
              .toList();
    } else {
      filteredLocal.value =
          allDistricts
              .where((d) => d.toLowerCase().contains(query.toLowerCase()))
              .toList();
    }

    if (query.isNotEmpty) {
      animationController.reset();
      animationController.forward();
    }
  }

  void clearRecentSearches() {
    recentSearches.clear();
  }

  void selectRecentSearch(String search) {
    final parts = search.split(' → ');
    if (parts.length == 2) {
      Get.toNamed(
        '/search-results',
        arguments: {'from': parts[0], 'to': parts[1]},
      );
    }
  }

  void selectPopularItem(String item) {
    if (selectedTab.value == 0) {
      Get.toNamed('/search-results', arguments: item);
    } else {
      Get.toNamed(
        '/search-results',
        arguments: {'district': item, 'city': 'Dakar'},
      );
    }
    final searchText = 'Dakar → $item';
    if (!recentSearches.contains(searchText)) {
      recentSearches.insert(0, searchText);
      if (recentSearches.length > 5) recentSearches.removeLast();
    }
  }
}
