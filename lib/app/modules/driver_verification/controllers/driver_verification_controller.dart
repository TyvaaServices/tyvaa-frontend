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
  final driverLicenseImage = Rx<File?>(null);
  final driverLicenseNumberController = TextEditingController();
  final driverLicenseExpiryController = TextEditingController();

  // License form validation flags
  final hasAttemptedNextWithoutLicense = false.obs;
  final hasAttemptedNextWithInvalidLicenseNumber = false.obs;
  final hasAttemptedNextWithInvalidExpiryDate = false.obs;

  // Vehicle data
  final carBrandController = TextEditingController();
  final carModelController = TextEditingController();
  final licensePlateController = TextEditingController();
  final carImage = Rx<File?>(null);

  // Car form validation flags
  final hasAttemptedNextWithInvalidCarBrand = false.obs;
  final hasAttemptedNextWithInvalidCarModel = false.obs;
  final hasAttemptedNextWithInvalidLicensePlate = false.obs;

  // ID card data
  final idCardImage = Rx<File?>(null);
  final idNumberController = TextEditingController();

  // ID form validation flags
  final hasAttemptedNextWithoutIdCard = false.obs;
  final hasAttemptedNextWithInvalidIdNumber = false.obs;

  // Review and submission
  final termsAccepted = false.obs;
  final isSubmitting = false.obs;
  final submissionError = ''.obs;

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

    ever(driverLicenseImage, (value) {
      if (value != null) {
        hasAttemptedNextWithoutLicense.value = false;
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

    ever(idCardImage, (value) {
      if (value != null) {
        hasAttemptedNextWithoutIdCard.value = false;
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

    if (driverLicenseImage.value == null) {
      hasAttemptedNextWithoutLicense.value = true;
      isValid = false;
    }

    if (isValid) {
      nextStep();
    }
  }

  void validateAndProceedFromCarStep() {
    bool isValid = true;

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

    if (idCardImage.value == null) {
      hasAttemptedNextWithoutIdCard.value = true;
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

  Future<void> pickDriverLicense() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      driverLicenseImage.value = File(image.path);
    }
  }

  void removeDriverLicenseImage() {
    driverLicenseImage.value = null;
  }

  Future<void> pickCarImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      carImage.value = File(image.path);
    }
  }

  void removeCarImage() {
    carImage.value = null;
  }

  Future<void> pickIdCard() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      idCardImage.value = File(image.path);
    }
  }

  void removeIdCardImage() {
    idCardImage.value = null;
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
