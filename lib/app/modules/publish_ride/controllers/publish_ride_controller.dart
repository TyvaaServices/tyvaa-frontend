import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/driver_verification/views/driver_verification_view.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/views/succes_publish_view.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/views/verification_required_screen.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';

enum PublishStepType { departure, arrival, time, date, summary }

class PublishRideController extends GetxController {
  final Rx<PublishStepType> currentStep = PublishStepType.departure.obs;

  late PageController pageController;

  late AnimationController animationController;

  final Rx<String?> departurePoint = Rx<String?>(null);
  final Rx<String?> arrivalPoint = Rx<String?>(null);
  final Rx<TimeOfDay?> departureTime = Rx<TimeOfDay?>(null);

  final Rx<DateTime?> specificDate = Rx<DateTime?>(null);

  final RxBool isRecurring = false.obs;
  final RxList<bool> selectedDays = List.generate(7, (_) => false).obs;
  final RxList<String> weekdayLabels =
      ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'].obs;

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

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void setAnimationController(AnimationController controller) {
    animationController = controller;
  }

  void nextStep() {
    if (currentStep.value == PublishStepType.departure &&
        departurePoint.value == null) {
      Get.snackbar(
        'Attention',
        'Veuillez sélectionner un point de départ',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        margin: EdgeInsets.all(16),
      );
      return;
    }

    if (currentStep.value == PublishStepType.arrival &&
        arrivalPoint.value == null) {
      Get.snackbar(
        'Attention',
        'Veuillez sélectionner un point d\'arrivée',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        margin: EdgeInsets.all(16),
      );
      return;
    }

    if (currentStep.value == PublishStepType.time &&
        departureTime.value == null) {
      Get.snackbar(
        'Attention',
        'Veuillez sélectionner une heure de départ',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        margin: EdgeInsets.all(16),
      );
      return;
    }

    if (currentStep.value == PublishStepType.date) {
      if (!isRecurring.value && specificDate.value == null) {
        Get.snackbar(
          'Attention',
          'Veuillez sélectionner une date',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[800],
          margin: EdgeInsets.all(16),
        );
        return;
      }

      if (isRecurring.value && !selectedDays.contains(true)) {
        Get.snackbar(
          'Attention',
          'Veuillez sélectionner au moins un jour de la semaine',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[800],
          margin: EdgeInsets.all(16),
        );
        return;
      }
    }

    final nextIndex = PublishStepType.values.indexOf(currentStep.value) + 1;
    if (nextIndex < PublishStepType.values.length) {
      currentStep.value = PublishStepType.values[nextIndex];
      pageController.animateToPage(
        nextIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      animationController.reset();
      animationController.forward();
    }
  }

  void previousStep() {
    final prevIndex = PublishStepType.values.indexOf(currentStep.value) - 1;
    if (prevIndex >= 0) {
      currentStep.value = PublishStepType.values[prevIndex];
      pageController.animateToPage(
        prevIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      animationController.reset();
      animationController.forward();
    } else {
      Get.back();
    }
  }

  void publishRide() {
    Future.delayed(Duration(seconds: 3), () {
      // Get.back();
    });
    // Get.to(VerificationRequiredScreen());
    // Get.toNamed(Routes.DRIVER_VERIFICATION);
    Get.to(RidePublishedSuccessScreen());
  }

  String getStepTitle() {
    switch (currentStep.value) {
      case PublishStepType.departure:
        return 'Point de départ';
      case PublishStepType.arrival:
        return 'Destination';
      case PublishStepType.time:
        return 'Heure de départ';
      case PublishStepType.date:
        return 'Date du trajet';
      case PublishStepType.summary:
        return 'Récapitulatif';
    }
  }

  String getButtonText() {
    if (currentStep.value == PublishStepType.summary) {
      return 'Publier le trajet';
    }
    return 'Continuer';
  }

  // Format time for display
  String formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Format date for display
  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  // Get list of selected weekdays as a formatted string
  String getSelectedWeekdays() {
    List<String> result = [];
    for (int i = 0; i < selectedDays.length; i++) {
      if (selectedDays[i]) {
        result.add(weekdayLabels[i]);
      }
    }

    if (result.isEmpty) {
      return 'Aucun jour sélectionné';
    }

    return result.join(', ');
  }
}
