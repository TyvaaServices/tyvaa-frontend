import 'dart:io';
import 'dart:async'; // Add this import for better timer management

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/modules/profile/controllers/profile_controller.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';
import 'package:passenger_tyvaa/app/services/driver_verification_pdf_service.dart';

import '../../../api/api_client.dart';

class DriverVerificationController extends GetxController {
  final currentStep = 0.obs;

  final driverLicenseFrontImage = Rx<File?>(null);
  final driverLicenseBackImage = Rx<File?>(null);
  final driverLicenseNumberController = TextEditingController();
  final driverLicenseExpiryController = TextEditingController();

  final hasAttemptedNextWithoutLicenseFront = false.obs;
  final hasAttemptedNextWithoutLicenseBack = false.obs;
  final hasAttemptedNextWithInvalidLicenseNumber = false.obs;
  final hasAttemptedNextWithInvalidExpiryDate = false.obs;

  final carteGriseFrontImage = Rx<File?>(null);
  final carteGriseBackImage = Rx<File?>(null);
  final carBrandController = TextEditingController();
  final carModelController = TextEditingController();
  final licensePlateController = TextEditingController();
  late ProfileController profileController;

  final hasAttemptedNextWithoutCarteGriseFront = false.obs;
  final hasAttemptedNextWithoutCarteGriseBack = false.obs;
  final hasAttemptedNextWithInvalidCarBrand = false.obs;
  final hasAttemptedNextWithInvalidCarModel = false.obs;
  final hasAttemptedNextWithInvalidLicensePlate = false.obs;

  final idCardFrontImage = Rx<File?>(null);
  final idCardBackImage = Rx<File?>(null);
  final idNumberController = TextEditingController();

  final hasAttemptedNextWithoutIdCardFront = false.obs;
  final hasAttemptedNextWithoutIdCardBack = false.obs;
  final hasAttemptedNextWithInvalidIdNumber = false.obs;

  final termsAccepted = false.obs;
  final isSubmitting = false.obs;
  final submissionError = ''.obs;

  final driverLicenseImage = Rx<File?>(null);
  final carImage = Rx<File?>(null);
  final idCardImage = Rx<File?>(null);
  final hasAttemptedNextWithoutLicense = false.obs;
  final hasAttemptedNextWithoutIdCard = false.obs;

  final _pdfService = DriverVerificationPdfService();
  final isGeneratingPdf = false.obs;

  final isCameraLoading = false.obs;
  late Logger logger;
  late ApiClient apiClient;

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
    profileController = Get.find<ProfileController>();
    apiClient = Get.find<ApiClient>();
    logger = Logger();
  }

  @override
  void onClose() {
    driverLicenseNumberController.dispose();
    driverLicenseExpiryController.dispose();
    carBrandController.dispose();
    carModelController.dispose();
    licensePlateController.dispose();
    idNumberController.dispose();
    super.onClose();
  }

  void _setupListeners() {
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

    logger.d("Carte Grise validation result: $isValid");
    logger.d("Front image: ${carteGriseFrontImage.value != null}");
    logger.d("Back image: ${carteGriseBackImage.value != null}");

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

  Future<void> _optimizedImagePick({
    required Function(File) onImageSelected,
    required String errorMessage,
    bool preferGalleryInEmulator = true,
  }) async {
    isCameraLoading.value = true;

    try {
      final ImagePicker picker = ImagePicker();

      ImageSource source = ImageSource.camera;
      if (preferGalleryInEmulator && kDebugMode) {
        source = ImageSource.gallery;
      }

      final XFile? image = await picker
          .pickImage(
            source: source,
            imageQuality: 40,
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

  Future<void> submitDriverApplication() async {
    if (!termsAccepted.value) {
      submissionError.value = 'Veuillez accepter les conditions pour continuer';
      return;
    }

    isSubmitting.value = true;
    var pdfBytes;
    try {
      pdfBytes = await _pdfService.generateDriverVerificationPdf(
        driverName: profileController.user.value.fullName ?? 'Non spécifié',
        driverPhone: profileController.user.value.phoneNumber ?? 'Non spécifié',
        driverEmail: profileController.user.value.email ?? 'Non spécifié',
        dateNaissance:
            profileController.user.value.dateOfBirth != null
                ? DateFormat(
                  'dd/MM/yyyy',
                ).format(profileController.user.value.dateOfBirth!)
                : 'Non spécifié',
        driverLicenseFrontImage: driverLicenseFrontImage.value!,
        driverLicenseBackImage: driverLicenseBackImage.value!,
        carteGriseFrontImage: carteGriseFrontImage.value!,
        carteGriseBackImage: carteGriseBackImage.value!,
        idCardFrontImage: idCardFrontImage.value!,
        idCardBackImage: idCardBackImage.value!,
      );

      final response = await apiClient.submitDriverApplication(pdfBytes);

      if (response.statusCode == 200) {
        nextStep();
      } else {
        submissionError.value =
            'Une erreur est survenue lors de la soumission. Veuillez réessayer.';
      }
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
        driverName: profileController.user.value.fullName ?? 'Non spécifié',
        driverPhone: profileController.user.value.phoneNumber ?? 'Non spécifié',
        driverEmail: profileController.user.value.email ?? 'Non spécifié',
        dateNaissance:
            profileController.user.value.dateOfBirth != null
                ? DateFormat(
                  'dd/MM/yyyy',
                ).format(profileController.user.value.dateOfBirth!)
                : 'Non spécifié',
        driverLicenseFrontImage: driverLicenseFrontImage.value!,
        driverLicenseBackImage: driverLicenseBackImage.value!,
        carteGriseFrontImage: carteGriseFrontImage.value!,
        carteGriseBackImage: carteGriseBackImage.value!,
        idCardFrontImage: idCardFrontImage.value!,
        idCardBackImage: idCardBackImage.value!,
      );

      final driverName =
          profileController.user.value.fullName ?? 'Non spécifié';
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

  bool _validateAllRequiredDocuments() {
    return driverLicenseFrontImage.value != null &&
        driverLicenseBackImage.value != null &&
        carteGriseFrontImage.value != null &&
        carteGriseBackImage.value != null &&
        idCardFrontImage.value != null &&
        idCardBackImage.value != null;
  }
}
