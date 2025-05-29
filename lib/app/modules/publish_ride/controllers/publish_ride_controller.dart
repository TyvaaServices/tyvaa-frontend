import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PublishStepType { departure, arrival, time, date, summary }

class PublishRideController extends GetxController {
  // Current step in the publishing process
  final Rx<PublishStepType> currentStep = PublishStepType.departure.obs;

  // PageController for step transitions
  late PageController pageController;

  // Animation controller for page transitions
  late AnimationController animationController;

  // Values for the form
  final Rx<String?> departurePoint = Rx<String?>(null);
  final Rx<String?> arrivalPoint = Rx<String?>(null);
  final Rx<TimeOfDay?> departureTime = Rx<TimeOfDay?>(null);

  // For date selection
  final Rx<DateTime?> specificDate = Rx<DateTime?>(null);

  // For recurring schedule
  final RxBool isRecurring = false.obs;
  final RxList<bool> selectedDays = List.generate(7, (_) => false).obs;
  final RxList<String> weekdayLabels =
      ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'].obs;

  // Predefined Dakar landmarks
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

  // Register the animation controller from the view
  void setAnimationController(AnimationController controller) {
    animationController = controller;
  }

  // Move to the next step
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

    // Move to the next step
    final nextIndex = PublishStepType.values.indexOf(currentStep.value) + 1;
    if (nextIndex < PublishStepType.values.length) {
      currentStep.value = PublishStepType.values[nextIndex];
      pageController.animateToPage(
        nextIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      // Reset and forward animation for the new page
      animationController.reset();
      animationController.forward();
    }
  }

  // Move to the previous step
  void previousStep() {
    final prevIndex = PublishStepType.values.indexOf(currentStep.value) - 1;
    if (prevIndex >= 0) {
      currentStep.value = PublishStepType.values[prevIndex];
      pageController.animateToPage(
        prevIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      // Reset and forward animation for the new page
      animationController.reset();
      animationController.forward();
    } else {
      // If we're at the first step, go back to the previous screen
      Get.back();
    }
  }

  // Submit the ride
  void publishRide() {
    // Here we would connect to a service to publish the ride
    // For now, we'll just show a success message and navigate back
    Get.snackbar(
      'Trajet Publié',
      'Votre trajet a été publié avec succès!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green[100],
      colorText: Colors.green[800],
      margin: EdgeInsets.all(16),
      duration: Duration(seconds: 3),
    );

    // Wait for the snackbar to be visible before navigating
    Future.delayed(Duration(seconds: 3), () {
      Get.back();
    });
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
