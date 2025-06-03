import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/driver_verification/controllers/driver_verification_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';
import 'package:passenger_tyvaa/app/widgets/primary_button.dart';

class DriverLicenseStep extends StatelessWidget {
  final DriverVerificationController controller;

  const DriverLicenseStep({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(TSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStepProgress(1, 3, context),
                  const SizedBox(height: TSpacing.md),
                  Text(
                    'Permis de conduire',
                    style: TTypography.headingLarge(context),
                  ),
                  const SizedBox(height: TSpacing.sm),
                  Text(
                    'Prenez des photos claires de votre permis de conduire',
                    style: TTypography.bodyMedium(context),
                  ),
                  const SizedBox(height: TSpacing.lg),

                  // Front side (Recto)
                  Text(
                    'Recto du permis',
                    style: TTypography.labelLarge(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: TSpacing.sm),
                  // Camera upload container for front side
                  GestureDetector(
                    onTap: () => controller.pickDriverLicenseFront(),
                    child: Obx(
                      () =>
                          controller.driverLicenseFrontImage.value == null
                              ? _buildUploadContainer(
                                context,
                                'Touchez pour prendre une photo',
                                Icons.add_a_photo_outlined,
                                isError:
                                    controller
                                        .hasAttemptedNextWithoutLicenseFront
                                        .value,
                                errorText: 'Photo obligatoire',
                              )
                              : _buildImagePreview(
                                context,
                                controller.driverLicenseFrontImage.value!,
                                onRemove:
                                    () =>
                                        controller
                                            .removeDriverLicenseFrontImage(),
                              ),
                    ),
                  ),

                  const SizedBox(height: TSpacing.lg),

                  // Back side (Verso)
                  Text(
                    'Verso du permis',
                    style: TTypography.labelLarge(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: TSpacing.sm),
                  // Camera upload container for back side
                  GestureDetector(
                    onTap: () => controller.pickDriverLicenseBack(),
                    child: Obx(
                      () =>
                          controller.driverLicenseBackImage.value == null
                              ? _buildUploadContainer(
                                context,
                                'Touchez pour prendre une photo',
                                Icons.add_a_photo_outlined,
                                isError:
                                    controller
                                        .hasAttemptedNextWithoutLicenseBack
                                        .value,
                                errorText: 'Photo obligatoire',
                              )
                              : _buildImagePreview(
                                context,
                                controller.driverLicenseBackImage.value!,
                                onRemove:
                                    () =>
                                        controller
                                            .removeDriverLicenseBackImage(),
                              ),
                    ),
                  ),

                  if (controller.hasAttemptedNextWithoutLicenseFront.value ||
                      controller.hasAttemptedNextWithoutLicenseBack.value)
                    Padding(
                      padding: const EdgeInsets.only(top: TSpacing.md),
                      child: Container(
                        padding: const EdgeInsets.all(TSpacing.sm),
                        decoration: BoxDecoration(
                          color: TColors.info.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(TRadius.sm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: TColors.info,
                              size: 20,
                            ),
                            const SizedBox(width: TSpacing.sm),
                            Expanded(
                              child: Text(
                                'Assurez-vous que toutes les informations du permis sont clairement visibles',
                                style: TTypography.bodySmall(
                                  context,
                                ).copyWith(color: TColors.info),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Add extra space at the bottom to push content up
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
        // Fixed buttons at the bottom
        Padding(
          padding: const EdgeInsets.all(TSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => controller.previousStep(),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 56),
                    side: BorderSide(color: TColors.neutral400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TRadius.lg),
                    ),
                  ),
                  child: Text(
                    'Retour',
                    style: TTypography.labelLarge(
                      context,
                    ).copyWith(color: TColors.textPrimary(context)),
                  ),
                ),
              ),
              const SizedBox(width: TSpacing.md),
              Expanded(
                flex: 2,
                child: PrimaryButton(
                  text: 'Continuer',
                  onPressed:
                      () => controller.validateAndProceedFromLicenseStep(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepProgress(
    int currentStep,
    int totalSteps,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(
            totalSteps,
            (index) => Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: index < totalSteps - 1 ? 8 : 0),
                decoration: BoxDecoration(
                  color:
                      index < currentStep
                          ? TColors.primary
                          : TColors.neutral200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Étape $currentStep sur $totalSteps',
          style: TTypography.labelSmall(context),
        ),
      ],
    );
  }

  Widget _buildUploadContainer(
    BuildContext context,
    String text,
    IconData icon, {
    bool isError = false,
    String errorText = '',
  }) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(TRadius.md),
        border: Border.all(
          color: isError ? TColors.error : TColors.neutral300,
          width: isError ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
            color: isError ? TColors.error : TColors.neutral500,
          ),
          const SizedBox(height: TSpacing.sm),
          Text(
            isError ? errorText : text,
            style: TTypography.labelMedium(context).copyWith(
              color: isError ? TColors.error : TColors.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview(
    BuildContext context,
    File image, {
    required VoidCallback onRemove,
  }) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(TRadius.md),
          child: Image.file(
            image,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: TColors.error,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
