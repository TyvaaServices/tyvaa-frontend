import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/repositories/user_repository.dart';
import 'package:passenger_tyvaa/domain/entities/ride_instance.dart';

class RideSearchController extends GetxController {
  // Search form values
  final Rx<String?> departurePoint = Rx<String?>(null);
  final Rx<String?> destinationPoint = Rx<String?>(null);
  final Rx<DateTime?> searchDate = Rx<DateTime?>(DateTime.now());

  // Search state
  final RxBool isSearching = false.obs;
  final RxBool hasSearched = false.obs;

  // Filter state
  final RxString selectedDateFilter = ''.obs;
  final RxString selectedSortFilter = ''.obs;

  // Search results
  RxList<Rideinstance> searchResults = <Rideinstance>[].obs;
  RxList<Rideinstance> filteredResults = <Rideinstance>[].obs;

  // Selected ride for booking
  final Rx<Rideinstance?> selectedRide = Rx<Rideinstance?>(null);

  // Booking state
  final RxBool isRequestingBooking = false.obs;
  final RxBool hasRequestedBooking = false.obs;
  final Rx<String?> bookingRequestStatus = Rx<String?>(null);

  final UserRepository _userRepository = UserRepository();

  // Liste des lieux populaires pour la recherche
  final List<String> popularLocations = [
    'Plateau',
    'Almadies',
    'HLM',
    'UCAD',
    'Pikine',
    'Sandaga',
    'Yoff',
    'Keur Massar',
    'Guédiawaye',
    'Parcelles Assainies',
    'Médina',
    'Ouest Foire',
    'Grand Dakar',
    'Liberté 6',
    'Point E',
    'Fann',
    'Mermoz',
    'Sacré-Cœur',
  ];

  // Perform search (real backend)
  Future<void> searchRides() async {
    if (departurePoint.value == null || destinationPoint.value == null) {
      Get.snackbar(
        'Information manquante',
        'Veuillez sélectionner un point de départ et une destination',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
      return;
    }
    isSearching.value = true;
    try {
      final results = await _userRepository.searchRides(
        departure: departurePoint.value!,
        arrival: destinationPoint.value!,
        date: searchDate.value,
      );
      searchResults.value = results;
      hasSearched.value = true;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les trajets'+e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[800]);
    } finally {
      isSearching.value = false;
    }
  }

  // Select a ride for viewing details
  void selectRide(Rideinstance ride) {
    selectedRide.value = ride;
  }

  // Reset the search
  void resetSearch() {
    departurePoint.value = null;
    destinationPoint.value = null;
    searchDate.value = null;
    hasSearched.value = false;
    searchResults.clear();
    filteredResults.clear();
    selectedDateFilter.value = '';
    selectedSortFilter.value = '';
  }

  // Reset booking state
  void resetBooking() {
    selectedRide.value = null;
    hasRequestedBooking.value = false;
    bookingRequestStatus.value = null;
  }

  // Setter explicite pour le point de départ
  void setDeparture(String value) {
    departurePoint.value = value;
  }

  // Setter explicite pour la destination
  void setDestination(String value) {
    destinationPoint.value = value;
  }

  // Filter methods
  void setDateFilter(String filter) {
    selectedDateFilter.value = selectedDateFilter.value == filter ? '' : filter;
    //_applyFilters();
  }

  void setSortFilter(String filter) {
    selectedSortFilter.value = selectedSortFilter.value == filter ? '' : filter;
    // _applyFilters();
  }

  // void _applyFilters() {
  //   List<Rideinstance> results = List.from(searchResults);
  //   // Apply date filters
  //   if (selectedDateFilter.value == 'today') {
  //     final today = DateTime.now();
  //     results = results.where((ride) =>
  //       ride.rideDate.year == today.year &&
  //       ride.rideDate.month == today.month &&
  //       ride.departureDate.day == today.day).toList();
  //   } else if (selectedDateFilter.value == 'week') {
  //     final now = DateTime.now();
  //     final weekFromNow = now.add(Duration(days: 7));
  //     results = results.where((ride) =>
  //       ride.departureDate.isAfter(now) &&
  //       ride.departureDate.isBefore(weekFromNow)).toList();
  //   }
  //   // Apply sort filters
  //   if (selectedSortFilter.value == 'price_asc') {
  //     results.sort((a, b) => a.price.compareTo(b.price));
  //   } else if (selectedSortFilter.value == 'time_asc') {
  //     results.sort((a, b) {
  //       final aMinutes = a.departureTime.hour * 60 + a.departureTime.minute;
  //       final bMinutes = b.departureTime.hour * 60 + b.departureTime.minute;
  //       return aMinutes.compareTo(bMinutes);
  //     });
  //   }
  //   filteredResults.value = results;
  // }
}
