import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';

class DriverVerificationController extends GetxController {
  // Step management
  final currentStep = 0.obs;

  // Driver's license data
  final driverLicenseFrontImage = Rx<File?>(null);
  final driverLicenseBackImage = Rx<File?>(null);
  final driverLicenseNumberController = TextEditingController();
  final driverLicenseExpiryController = TextEditingController();

  // License form validation flags
  final hasAttemptedNextWithoutLicenseFront = false.obs;
  final hasAttemptedNextWithoutLicenseBack = false.obs;
  final hasAttemptedNextWithInvalidLicenseNumber = false.obs;
  final hasAttemptedNextWithInvalidExpiryDate = false.obs;

  // Vehicle data (Carte Grise)
  final carteGriseFrontImage = Rx<File?>(null);
  final carteGriseBackImage = Rx<File?>(null);
  final carBrandController = TextEditingController();
  final carModelController = TextEditingController();
  final licensePlateController = TextEditingController();

  // Car form validation flags
  final hasAttemptedNextWithoutCarteGriseFront = false.obs;
  final hasAttemptedNextWithoutCarteGriseBack = false.obs;
  final hasAttemptedNextWithInvalidCarBrand = false.obs;
  final hasAttemptedNextWithInvalidCarModel = false.obs;
  final hasAttemptedNextWithInvalidLicensePlate = false.obs;

  // ID card data
  final idCardFrontImage = Rx<File?>(null);
  final idCardBackImage = Rx<File?>(null);
  final idNumberController = TextEditingController();

  // ID form validation flags
  final hasAttemptedNextWithoutIdCardFront = false.obs;
  final hasAttemptedNextWithoutIdCardBack = false.obs;
  final hasAttemptedNextWithInvalidIdNumber = false.obs;

  // Review and submission
  final termsAccepted = false.obs;
  final isSubmitting = false.obs;
  final submissionError = ''.obs;

  // Legacy fields - kept for backward compatibility but not used in new UI
  final driverLicenseImage = Rx<File?>(null);
  final carImage = Rx<File?>(null);
  final idCardImage = Rx<File?>(null);
  final hasAttemptedNextWithoutLicense = false.obs;
  final hasAttemptedNextWithoutIdCard = false.obs;

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  @override
  void onClose() {
    // Dispose controllers
    driverLicenseNumberController.dispose();
    driverLicenseExpiryController.dispose();
    carBrandController.dispose();
    carModelController.dispose();
    licensePlateController.dispose();
    idNumberController.dispose();
    super.onClose();
  }

  void _setupListeners() {
    // Reset validation errors when fields change
    driverLicenseNumberController.addListener(() {
      if (driverLicenseNumberController.text.isNotEmpty) {
        hasAttemptedNextWithInvalidLicenseNumber.value = false;
      }
    });

    driverLicenseExpiryController.addListener(() {
      if (driverLicenseExpiryController.text.isNotEmpty) {
        hasAttemptedNextWithInvalidExpiryDate.value = false;
      }
    });

    ever(driverLicenseFrontImage, (value) {
      if (value != null) {
        hasAttemptedNextWithoutLicenseFront.value = false;
      }
    });

    ever(driverLicenseBackImage, (value) {
      if (value != null) {
        hasAttemptedNextWithoutLicenseBack.value = false;
      }
    });

    carBrandController.addListener(() {
      if (carBrandController.text.isNotEmpty) {
        hasAttemptedNextWithInvalidCarBrand.value = false;
      }
    });

    carModelController.addListener(() {
      if (carModelController.text.isNotEmpty) {
        hasAttemptedNextWithInvalidCarModel.value = false;
      }
    });

    licensePlateController.addListener(() {
      if (licensePlateController.text.isNotEmpty) {
        hasAttemptedNextWithInvalidLicensePlate.value = false;
      }
    });

    ever(carteGriseFrontImage, (value) {
      if (value != null) {
        hasAttemptedNextWithoutCarteGriseFront.value = false;
      }
    });

    ever(carteGriseBackImage, (value) {
      if (value != null) {
        hasAttemptedNextWithoutCarteGriseBack.value = false;
      }
    });

    ever(idCardFrontImage, (value) {
      if (value != null) {
        hasAttemptedNextWithoutIdCardFront.value = false;
      }
    });

    ever(idCardBackImage, (value) {
      if (value != null) {
        hasAttemptedNextWithoutIdCardBack.value = false;
      }
    });

    idNumberController.addListener(() {
      if (idNumberController.text.isNotEmpty) {
        hasAttemptedNextWithInvalidIdNumber.value = false;
      }
    });

    ever(termsAccepted, (_) {
      if (submissionError.value.isNotEmpty) {
        submissionError.value = '';
      }
    });
  }

  void nextStep() {
    if (currentStep.value < 5) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step <= 5) {
      currentStep.value = step;
    }
  }

  void validateAndProceedFromLicenseStep() {
    bool isValid = true;

    if (driverLicenseFrontImage.value == null) {
      hasAttemptedNextWithoutLicenseFront.value = true;
      isValid = false;
    }

    if (driverLicenseBackImage.value == null) {
      hasAttemptedNextWithoutLicenseBack.value = true;
      isValid = false;
    }

    if (isValid) {
      nextStep();
    }
  }

  void validateAndProceedFromCarStep() {
    bool isValid = true;

    if (carteGriseFrontImage.value == null) {
      hasAttemptedNextWithoutCarteGriseFront.value = true;
      isValid = false;
    }

    if (carteGriseBackImage.value == null) {
      hasAttemptedNextWithoutCarteGriseBack.value = true;
      isValid = false;
    }

    if (carBrandController.text.trim().isEmpty) {
      hasAttemptedNextWithInvalidCarBrand.value = true;
      isValid = false;
    }

    if (carModelController.text.trim().isEmpty) {
      hasAttemptedNextWithInvalidCarModel.value = true;
      isValid = false;
    }

    if (licensePlateController.text.trim().isEmpty) {
      hasAttemptedNextWithInvalidLicensePlate.value = true;
      isValid = false;
    }

    if (isValid) {
      nextStep();
    }
  }

  void validateAndProceedFromCarteGriseStep() {
    bool isValid = true;

    if (carteGriseFrontImage.value == null) {
      hasAttemptedNextWithoutCarteGriseFront.value = true;
      isValid = false;
    }

    if (carteGriseBackImage.value == null) {
      hasAttemptedNextWithoutCarteGriseBack.value = true;
      isValid = false;
    }

    if (carBrandController.text.trim().isEmpty) {
      hasAttemptedNextWithInvalidCarBrand.value = true;
      isValid = false;
    }

    if (carModelController.text.trim().isEmpty) {
      hasAttemptedNextWithInvalidCarModel.value = true;
      isValid = false;
    }

    if (licensePlateController.text.trim().isEmpty) {
      hasAttemptedNextWithInvalidLicensePlate.value = true;
      isValid = false;
    }

    if (isValid) {
      nextStep();
    }
  }

  void validateAndProceedFromIdStep() {
    bool isValid = true;

    if (idCardFrontImage.value == null) {
      hasAttemptedNextWithoutIdCardFront.value = true;
      isValid = false;
    }

    if (idCardBackImage.value == null) {
      hasAttemptedNextWithoutIdCardBack.value = true;
      isValid = false;
    }

    if (idNumberController.text.trim().isEmpty) {
      hasAttemptedNextWithInvalidIdNumber.value = true;
      isValid = false;
    }

    if (isValid) {
      nextStep();
    }
  }

  Future<void> pickDriverLicenseFront() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      driverLicenseFrontImage.value = File(image.path);
    }
  }

  Future<void> pickDriverLicenseBack() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      driverLicenseBackImage.value = File(image.path);
    }
  }

  void removeDriverLicenseFrontImage() {
    driverLicenseFrontImage.value = null;
  }

  void removeDriverLicenseBackImage() {
    driverLicenseBackImage.value = null;
  }

  Future<void> pickCarteGriseFront() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      carteGriseFrontImage.value = File(image.path);
    }
  }

  Future<void> pickCarteGriseBack() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      carteGriseBackImage.value = File(image.path);
    }
  }

  void removeCarteGriseFrontImage() {
    carteGriseFrontImage.value = null;
  }

  void removeCarteGriseBackImage() {
    carteGriseBackImage.value = null;
  }

  Future<void> pickIdCardFront() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      idCardFrontImage.value = File(image.path);
    }
  }

  Future<void> pickIdCardBack() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      idCardBackImage.value = File(image.path);
    }
  }

  void removeIdCardFrontImage() {
    idCardFrontImage.value = null;
  }

  void removeIdCardBackImage() {
    idCardBackImage.value = null;
  }

  Future<void> pickExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 20)),
    );

    if (picked != null) {
      driverLicenseExpiryController.text = DateFormat(
        'dd/MM/yyyy',
      ).format(picked);
    }
  }

  Future<void> submitVerification() async {
    if (!termsAccepted.value) {
      submissionError.value = 'Veuillez accepter les conditions pour continuer';
      return;
    }

    isSubmitting.value = true;

    try {
      // Here you would typically upload the data to your backend
      // For now, we'll simulate a network request
      await Future.delayed(const Duration(seconds: 2));

      nextStep();
    } catch (e) {
      submissionError.value =
          'Une erreur est survenue lors de la soumission. Veuillez réessayer.';
    } finally {
      isSubmitting.value = false;
    }
  }

  void goToHome() {
    Get.offAllNamed(Routes.MAIN);
  }
}
