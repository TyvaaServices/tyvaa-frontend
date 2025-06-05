import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/driver_verification/controllers/driver_verification_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';
import 'package:passenger_tyvaa/app/widgets/primary_button.dart';

class ReviewStep extends StatelessWidget {
  final DriverVerificationController controller;

  const ReviewStep({Key? key, required this.controller}) : super(key: key);

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
                  Text(
                    'Récapitulatif',
                    style: TTypography.headingLarge(context),
                  ),
                  const SizedBox(height: TSpacing.sm),
                  Text(
                    'Vérifiez vos informations avant de soumettre',
                    style: TTypography.bodyMedium(context),
                  ),
                  const SizedBox(height: TSpacing.xl),

                  // Driver's License Section
                  _buildDocumentSection(
                    context,
                    'Permis de conduire',
                    [
                      controller.driverLicenseFrontImage.value,
                      controller.driverLicenseBackImage.value,
                    ],
                    Icons.drive_eta_rounded,
                    () => controller.goToStep(1),
                  ),
                  const SizedBox(height: TSpacing.md),

                  // Carte Grise Section
                  _buildDocumentSection(
                    context,
                    'Carte Grise',
                    [
                      controller.carteGriseFrontImage.value,
                      controller.carteGriseBackImage.value,
                    ],
                    Icons.directions_car_filled_rounded,
                    () => controller.goToStep(2),
                  ),
                  const SizedBox(height: TSpacing.md),

                  // ID Card Section
                  _buildDocumentSection(
                    context,
                    'Pièce d\'identité',
                    [
                      controller.idCardFrontImage.value,
                      controller.idCardBackImage.value,
                    ],
                    Icons.person_rounded,
                    () => controller.goToStep(3),
                  ),

                  const SizedBox(height: TSpacing.xl),

                  // Terms acceptance
                  Obx(
                    () => CheckboxListTile(
                      value: controller.termsAccepted.value,
                      onChanged:
                          (value) =>
                              controller.termsAccepted.value = value ?? false,
                      title: Text(
                        'Je certifie que toutes les informations fournies sont exactes et à jour',
                        style: TTypography.bodySmall(context),
                      ),
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: TColors.primary,
                    ),
                  ),

                  if (controller.submissionError.value.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: TSpacing.md),
                      padding: const EdgeInsets.all(TSpacing.md),
                      decoration: BoxDecoration(
                        color: TColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(TRadius.md),
                        border: Border.all(
                          color: TColors.error.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: TColors.error),
                          const SizedBox(width: TSpacing.sm),
                          Expanded(
                            child: Text(
                              controller.submissionError.value,
                              style: TTypography.bodySmall(
                                context,
                              ).copyWith(color: TColors.error),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                child: Obx(
                  () => PrimaryButton(
                    text:
                        controller.isSubmitting.value
                            ? 'Soumission en cours...'
                            : 'Soumettre',
                    onPressed:
                        (controller.termsAccepted.value &&
                                !controller.isSubmitting.value)
                            ? () => controller.submitDriverApplication()
                            : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentSection(
    BuildContext context,
    String title,
    List<File?> images,
    IconData icon,
    VoidCallback onEdit,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(TRadius.md),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(TSpacing.md),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(TSpacing.sm),
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(TRadius.md),
                  ),
                  child: Icon(icon, color: TColors.primary),
                ),
                const SizedBox(width: TSpacing.md),
                Expanded(
                  child: Text(title, style: TTypography.headingSmall(context)),
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit_outlined, color: TColors.primary),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(TSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (images.every((image) => image != null))
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recto',
                              style: TTypography.labelSmall(context),
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(TRadius.sm),
                              child: Image.file(
                                images[0]!,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: TSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verso',
                              style: TTypography.labelSmall(context),
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(TRadius.sm),
                              child: Image.file(
                                images[1]!,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    'Informations incomplètes',
                    style: TTypography.bodyMedium(
                      context,
                    ).copyWith(color: TColors.error),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
