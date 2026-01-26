import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_feedback.dart';
import '../../../../data/entities/ride.dart';
import '../../../../data/repositories/ride_repository.dart';
import '../../../routes/app_pages.dart';

class MyRidesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final IRideRepository _rideRepository;

  MyRidesController(this._rideRepository);

  late TabController tabController;

  final bookedRides = <Ride>[].obs;
  final publishedRides = <Ride>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    loadMyRides();
  }

  Future<void> loadMyRides() async {
    isLoading.value = true;
    try {
      // Mock logic: Fetch all and split randomly or by ID logic
      // In real app, you would have separate API calls or a filter
      final allRides = await _rideRepository.searchRides(
        '',
        '',
        DateTime.now(),
      );

      // Mock Separation
      publishedRides.value = allRides
          .take(2)
          .toList(); // Assume I created these
      bookedRides.value = allRides.skip(2).toList(); // Assume I booked these
    } catch (e) {
      AppFeedback.showError(
        'Erreur',
        'Impossible de charger vos trajets. Vérifiez votre connexion.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToRideDetail(Ride ride) {
    Get.toNamed(Routes.RIDE_DETAIL, arguments: ride);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
