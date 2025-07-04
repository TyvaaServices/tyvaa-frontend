import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideSearchModel {
  final String id;
  final String departurePoint;
  final String arrivalPoint;
  final DateTime departureDate;
  final TimeOfDay departureTime;
  final String chauffeurName;
  final String chauffeurImageUrl;
  final double chauffeurRating;
  final String chauffeurPhone; // Added phone number field
  final int availableSeats;
  final double price;
  final bool isRecurring;
  final List<String>? recurringDays;

  RideSearchModel({
    required this.id,
    required this.departurePoint,
    required this.arrivalPoint,
    required this.departureDate,
    required this.departureTime,
    required this.chauffeurName,
    required this.chauffeurImageUrl,
    required this.chauffeurRating,
    required this.chauffeurPhone, // Added phone number parameter
    required this.availableSeats,
    required this.price,
    this.isRecurring = false,
    this.recurringDays,
  });
}

class RideSearchController extends GetxController {
  // Search form values
  final Rx<String?> departurePoint = Rx<String?>(null);
  final Rx<String?> arrivalPoint = Rx<String?>(null);
  final Rx<DateTime?> searchDate = Rx<DateTime?>(
    DateTime.now(),
  ); // Default to today

  // Search state
  final RxBool isSearching = false.obs;
  final RxBool hasSearched = false.obs;

  // Filter state
  final RxString selectedDateFilter = ''.obs;
  final RxString selectedSortFilter = ''.obs;

  // Search results
  final RxList<RideSearchModel> searchResults = <RideSearchModel>[].obs;
  final RxList<RideSearchModel> filteredResults = <RideSearchModel>[].obs;

  // Selected ride for booking
  final Rx<RideSearchModel?> selectedRide = Rx<RideSearchModel?>(null);

  // Booking state
  final RxBool isRequestingBooking = false.obs;
  final RxBool hasRequestedBooking = false.obs;
  final Rx<String?> bookingRequestStatus = Rx<String?>(
    null,
  ); // pending, approved, rejected

  // Mock data for Dakar landmarks
  final List<String> dakarLandmarks = [
    'HLM',
    'UCAD',
    'Sandaga',
    'Keur Massar',
    'Pikine',
    'Guédiawaye',
    'Parcelles Assainies',
    'Médina',
    'Yoff',
    'Ouest Foire',
    'Grand Dakar',
    'Liberté 6',
    'Almadies',
    'Point E',
    'Plateau',
    'Fann',
    'Mermoz',
    'Sacré-Cœur',
  ];

  // Perform search
  void searchRides() {
    if (departurePoint.value == null || arrivalPoint.value == null) {
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

    // Simulate network delay
    Future.delayed(Duration(seconds: 1), () {
      // Generate mock search results
      searchResults.value = _generateMockSearchResults();
      filteredResults.value = List.from(searchResults);

      isSearching.value = false;
      hasSearched.value = true;
    });
  }

  // Select a ride for viewing details
  void selectRide(RideSearchModel ride) {
    selectedRide.value = ride;
  }

  // Request a booking
  void requestBooking(
    RideSearchModel ride,
    int numberOfSeats,
    String? message,
  ) {
    isRequestingBooking.value = true;

    // Simulate network delay for booking request
    Future.delayed(Duration(seconds: 2), () {
      isRequestingBooking.value = false;
      hasRequestedBooking.value = true;
      bookingRequestStatus.value = 'pending';

      // Simulate chauffeur response after some time
      Future.delayed(Duration(seconds: 5), () {
        // Randomly approve or reject
        final isApproved = DateTime.now().millisecond % 2 == 0;
        bookingRequestStatus.value = isApproved ? 'approved' : 'rejected';
      });
    });
  }

  // Reset the search
  void resetSearch() {
    departurePoint.value = null;
    arrivalPoint.value = null;
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

  // Filter methods
  void setDateFilter(String filter) {
    selectedDateFilter.value = selectedDateFilter.value == filter ? '' : filter;
    _applyFilters();
  }

  void setSortFilter(String filter) {
    selectedSortFilter.value = selectedSortFilter.value == filter ? '' : filter;
    _applyFilters();
  }

  void _applyFilters() {
    List<RideSearchModel> results = List.from(searchResults);

    // Apply date filters
    if (selectedDateFilter.value == 'today') {
      final today = DateTime.now();
      results =
          results
              .where(
                (ride) =>
                    ride.departureDate.year == today.year &&
                    ride.departureDate.month == today.month &&
                    ride.departureDate.day == today.day,
              )
              .toList();
    } else if (selectedDateFilter.value == 'week') {
      final now = DateTime.now();
      final weekFromNow = now.add(Duration(days: 7));
      results =
          results
              .where(
                (ride) =>
                    ride.departureDate.isAfter(now) &&
                    ride.departureDate.isBefore(weekFromNow),
              )
              .toList();
    }

    // Apply sort filters
    if (selectedSortFilter.value == 'price_asc') {
      results.sort((a, b) => a.price.compareTo(b.price));
    } else if (selectedSortFilter.value == 'time_asc') {
      results.sort((a, b) {
        final aMinutes = a.departureTime.hour * 60 + a.departureTime.minute;
        final bMinutes = b.departureTime.hour * 60 + b.departureTime.minute;
        return aMinutes.compareTo(bMinutes);
      });
    }

    filteredResults.value = results;
  }

  // Generate mock search results
  List<RideSearchModel> _generateMockSearchResults() {
    final now = DateTime.now();

    // Create several mock rides
    return List.generate(
      5,
      (index) => RideSearchModel(
        id: 'ride_${now.millisecondsSinceEpoch}_$index',
        departurePoint: departurePoint.value!,
        arrivalPoint: arrivalPoint.value!,
        departureDate:
            searchDate.value ?? DateTime.now().add(Duration(days: index)),
        departureTime: TimeOfDay(
          hour: 8 + (index * 2) % 12,
          minute: (index * 15) % 60,
        ),
        chauffeurName: _getRandomChauffeurName(),
        chauffeurImageUrl: 'assets/images/default_profile.png',
        chauffeurRating: 3.5 + (index % 3) * 0.5,
        availableSeats: 1 + (index % 4),
        price: 1000 + (index * 500),
        isRecurring: index % 3 == 0,
        recurringDays: index % 3 == 0 ? _getRandomRecurringDays() : null,
        chauffeurPhone: '+221776543210', // Mock phone number
      ),
    );
  }

  // Helper to get random chauffeur names
  String _getRandomChauffeurName() {
    final names = [
      'Abdoulaye D.',
      'Fatou S.',
      'Moussa T.',
      'Aissatou N.',
      'Ibrahima K.',
      'Sophie D.',
      'Omar B.',
      'Mariama C.',
    ];

    return names[DateTime.now().millisecond % names.length];
  }

  // Helper to get random recurring days
  List<String> _getRandomRecurringDays() {
    final allDays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    final numberOfDays = 1 + (DateTime.now().millisecond % 5);

    // Shuffle and take the first few
    allDays.shuffle();
    return allDays.take(numberOfDays).toList();
  }
}
