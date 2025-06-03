import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:async'; // Add this import for better timer management

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';
import 'package:passenger_tyvaa/app/services/driver_verification_pdf_service.dart';

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

  // Driver personal information
  final driverNameController = TextEditingController();
  final driverPhoneController = TextEditingController();
  final driverEmailController = TextEditingController();

  // PDF Service
  final _pdfService = DriverVerificationPdfService();
  final isGeneratingPdf = false.obs;

  // Camera loading state
  final isCameraLoading = false.obs;

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
    driverNameController.dispose();
    driverPhoneController.dispose();
    driverEmailController.dispose();
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

    // Debug print to help troubleshoot
    print("Carte Grise validation result: $isValid");
    print("Front image: ${carteGriseFrontImage.value != null}");
    print("Back image: ${carteGriseBackImage.value != null}");

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

    if (isValid) {
      nextStep();
    }
  }

  // Optimized image picking method with loading state and timeout
  Future<void> _optimizedImagePick({
    required Function(File) onImageSelected,
    required String errorMessage,
    bool preferGalleryInEmulator = true,
  }) async {
    isCameraLoading.value = true;

    try {
      final ImagePicker picker = ImagePicker();

      // For emulator, default to gallery if specified
      // On real devices, use camera by default
      ImageSource source = ImageSource.camera;
      if (preferGalleryInEmulator && kDebugMode) {
        source = ImageSource.gallery;
      }

      // Set a timeout for camera operations
      final XFile? image = await picker
          .pickImage(
            source: source,
            imageQuality: 40, // Further reduced for emulator
            maxWidth: 800,
            maxHeight: 800,
            preferredCameraDevice: CameraDevice.rear,
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              Get.snackbar(
                'Délai dépassé',
                'L\'opération a pris trop de temps. Veuillez réessayer.',
                backgroundColor: Colors.orange.shade100,
                colorText: Colors.orange.shade900,
                snackPosition: SnackPosition.BOTTOM,
              );
              return null;
            },
          );

      if (image != null) {
        onImageSelected(File(image.path));
      }
    } catch (e) {
      print("Error picking image: $e");
      Get.snackbar(
        'Erreur',
        errorMessage,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isCameraLoading.value = false;
    }
  }

  Future<void> pickDriverLicenseFront() async {
    await _optimizedImagePick(
      onImageSelected: (file) => driverLicenseFrontImage.value = file,
      errorMessage:
          'Impossible de prendre la photo du permis (recto). Veuillez réessayer.',
      preferGalleryInEmulator: true,
    );
  }

  Future<void> pickDriverLicenseBack() async {
    await _optimizedImagePick(
      onImageSelected: (file) => driverLicenseBackImage.value = file,
      errorMessage:
          'Impossible de prendre la photo du permis (verso). Veuillez réessayer.',
      preferGalleryInEmulator: true,
    );
  }

  Future<void> pickCarteGriseFront() async {
    await _optimizedImagePick(
      onImageSelected: (file) => carteGriseFrontImage.value = file,
      errorMessage:
          'Impossible de prendre la photo de la carte grise (recto). Veuillez réessayer.',
      preferGalleryInEmulator: true,
    );
  }

  Future<void> pickCarteGriseBack() async {
    await _optimizedImagePick(
      onImageSelected: (file) => carteGriseBackImage.value = file,
      errorMessage:
          'Impossible de prendre la photo de la carte grise (verso). Veuillez réessayer.',
      preferGalleryInEmulator: true,
    );
  }

  Future<void> pickIdCardFront() async {
    await _optimizedImagePick(
      onImageSelected: (file) => idCardFrontImage.value = file,
      errorMessage:
          'Impossible de prendre la photo de la pièce d\'identité (recto). Veuillez réessayer.',
      preferGalleryInEmulator: true,
    );
  }

  Future<void> pickIdCardBack() async {
    await _optimizedImagePick(
      onImageSelected: (file) => idCardBackImage.value = file,
      errorMessage:
          'Impossible de prendre la photo de la pièce d\'identité (verso). Veuillez réessayer.',
      preferGalleryInEmulator: true,
    );
  }

  void removeDriverLicenseFrontImage() {
    driverLicenseFrontImage.value = null;
  }

  void removeDriverLicenseBackImage() {
    driverLicenseBackImage.value = null;
  }

  void removeCarteGriseFrontImage() {
    carteGriseFrontImage.value = null;
  }

  void removeCarteGriseBackImage() {
    carteGriseBackImage.value = null;
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

  // Generate and preview verification PDF
  Future<void> generateAndPreviewPdf(BuildContext context) async {
    if (!_validateAllRequiredDocuments()) {
      Get.snackbar(
        'Informations manquantes',
        'Veuillez compléter toutes les informations et télécharger tous les documents nécessaires.',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isGeneratingPdf.value = true;

    try {
      print("Starting PDF generation...");
      final pdfBytes = await _pdfService.generateDriverVerificationPdf(
        driverName:
            driverNameController.text.isEmpty
                ? 'Non spécifié'
                : driverNameController.text,
        driverPhone:
            driverPhoneController.text.isEmpty
                ? 'Non spécifié'
                : driverPhoneController.text,
        driverEmail:
            driverEmailController.text.isEmpty
                ? null
                : driverEmailController.text,
        dateNaissance: null, // Add this parameter
        driverLicenseFrontImage: driverLicenseFrontImage.value!,
        driverLicenseBackImage: driverLicenseBackImage.value!,
        carteGriseFrontImage: carteGriseFrontImage.value!,
        carteGriseBackImage: carteGriseBackImage.value!,
        idCardFrontImage: idCardFrontImage.value!,
        idCardBackImage: idCardBackImage.value!,
      );
      print("PDF generation completed successfully");

      await _pdfService.previewPdf(pdfBytes);
    } catch (e) {
      print("Error generating PDF: $e");
      Get.snackbar(
        'Erreur',
        'Impossible de générer le PDF. Veuillez réessayer. Erreur: ${e.toString()}',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isGeneratingPdf.value = false;
    }
  }

  // Generate and share verification PDF
  Future<void> generateAndSharePdf() async {
    if (!_validateAllRequiredDocuments()) {
      Get.snackbar(
        'Informations manquantes',
        'Veuillez compléter toutes les informations et télécharger tous les documents nécessaires.',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isGeneratingPdf.value = true;

    try {
      final pdfBytes = await _pdfService.generateDriverVerificationPdf(
        driverName:
            driverNameController.text.isEmpty
                ? 'Non spécifié'
                : driverNameController.text,
        driverPhone:
            driverPhoneController.text.isEmpty
                ? 'Non spécifié'
                : driverPhoneController.text,
        driverEmail:
            driverEmailController.text.isEmpty
                ? 'Non spécifié'
                : driverEmailController.text,
        driverLicenseFrontImage: driverLicenseFrontImage.value!,
        driverLicenseBackImage: driverLicenseBackImage.value!,
        carteGriseFrontImage: carteGriseFrontImage.value!,
        carteGriseBackImage: carteGriseBackImage.value!,
        idCardFrontImage: idCardFrontImage.value!,
        idCardBackImage: idCardBackImage.value!,
      );

      final driverName =
          driverNameController.text.isEmpty
              ? 'Chauffeur'
              : driverNameController.text;
      await _pdfService.saveAndSharePdf(pdfBytes, driverName);
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de générer le PDF. Veuillez réessayer.',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isGeneratingPdf.value = false;
    }
  }

  // Validate all required documents are provided
  bool _validateAllRequiredDocuments() {
    // Print debug information to help diagnose issues
    print("Validating documents:");
    print("Driver License Front: ${driverLicenseFrontImage.value != null}");
    print("Driver License Back: ${driverLicenseBackImage.value != null}");
    print("Carte Grise Front: ${carteGriseFrontImage.value != null}");
    print("Carte Grise Back: ${carteGriseBackImage.value != null}");
    print("ID Card Front: ${idCardFrontImage.value != null}");
    print("ID Card Back: ${idCardBackImage.value != null}");

    return driverLicenseFrontImage.value != null &&
        driverLicenseBackImage.value != null &&
        carteGriseFrontImage.value != null &&
        carteGriseBackImage.value != null &&
        idCardFrontImage.value != null &&
        idCardBackImage.value != null;
  }
}
