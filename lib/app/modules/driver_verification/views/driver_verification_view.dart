import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/driver_verification/controllers/driver_verification_controller.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';
import 'package:passenger_tyvaa/app/widgets/primary_button.dart';

class DriverVerificationView extends GetView<DriverVerificationController> {
  const DriverVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      body: SafeArea(child: Obx(() => _buildCurrentStep(context))),
    );
  }

  Widget _buildCurrentStep(BuildContext context) {
    switch (controller.currentStep.value) {
      case 0:
        return _buildWelcomeStep(context);
      case 1:
        return _buildDriverLicenseStep(context);
      case 2:
        return _buildCarInfoStep(context);
      case 3:
        return _buildIdentityStep(context);
      case 4:
        return _buildReviewStep(context);
      case 5:
        return _buildSuccessStep(context);
      default:
        return _buildWelcomeStep(context);
    }
  }

  Widget _buildWelcomeStep(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/drivers/confirmed-driver.png',
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: TSpacing.lg),
                  Text(
                    'Vérification du chauffeur',
                    style: TTypography.headingLarge(context),
                  ),
                  const SizedBox(height: TSpacing.md),
                  Text(
                    'Avant de pouvoir proposer des trajets, nous devons vérifier votre identité et vos informations de conduite.',
                    style: TTypography.bodyMedium(context),
                  ),
                  const SizedBox(height: TSpacing.xl),
                  Container(
                    decoration: BoxDecoration(
                      color: TColors.surface(context),
                      borderRadius: TRadius.cardRadius,
                      boxShadow: TShadows.medium,
                    ),
                    padding: const EdgeInsets.all(TSpacing.md),
                    child: Column(
                      children: [
                        _buildStepItem(
                          context,
                          'Permis de conduire',
                          'Une photo de votre permis en cours de validité',
                          Icons.drive_eta_rounded,
                        ),
                        Divider(color: TColors.neutral300, height: TSpacing.lg),
                        _buildStepItem(
                          context,
                          'Informations du véhicule',
                          'Marque, modèle et immatriculation',
                          Icons.directions_car_filled_rounded,
                        ),
                        Divider(color: TColors.neutral300, height: TSpacing.lg),
                        _buildStepItem(
                          context,
                          'Pièce d\'identité',
                          'Carte d\'identité ou passeport valide',
                          Icons.person_rounded,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSpacing.md),
                  Container(
                    padding: const EdgeInsets.all(TSpacing.md),
                    decoration: BoxDecoration(
                      color: TColors.info.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(TRadius.md),
                      border: Border.all(color: TColors.info.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: TColors.info),
                        const SizedBox(width: TSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ce processus prend généralement 24-48h',
                                style: TTypography.labelMedium(
                                  context,
                                ).copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Vous recevrez une notification une fois votre compte vérifié',
                                style: TTypography.bodySmall(context),
                              ),
                            ],
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
        Padding(
          padding: const EdgeInsets.all(TSpacing.md),
          child: Column(
            children: [
              PrimaryButton(
                text: 'Commencer la vérification',
                onPressed: () => controller.nextStep(),
              ),
              const SizedBox(height: TSpacing.md),
              TextButton.icon(
                onPressed: () => Get.offAllNamed(Routes.MAIN),
                icon: Icon(Icons.arrow_back, size: 16, color: TColors.primary),
                label: Text(
                  'Je ferai ça plus tard',
                  style: TTypography.labelMedium(
                    context,
                  ).copyWith(color: TColors.primary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepItem(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSpacing.sm),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TTypography.headingSmall(context)),
                const SizedBox(height: 4),
                Text(description, style: TTypography.bodySmall(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverLicenseStep(BuildContext context) {
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
                    'Prenez une photo claire de votre permis de conduire',
                    style: TTypography.bodyMedium(context),
                  ),
                  // Add extra space to push content down, making the upload container more accessible
                  const SizedBox(height: 60),
                  // Camera upload container
                  GestureDetector(
                    onTap: () => controller.pickDriverLicense(),
                    child: Obx(
                      () =>
                          controller.driverLicenseImage.value == null
                              ? _buildUploadContainer(
                                context,
                                'Touchez pour prendre une photo',
                                Icons.add_a_photo_outlined,
                                isError:
                                    controller
                                        .hasAttemptedNextWithoutLicense
                                        .value,
                                errorText: 'Photo obligatoire',
                              )
                              : _buildImagePreview(
                                context,
                                controller.driverLicenseImage.value!,
                                onRemove:
                                    () => controller.removeDriverLicenseImage(),
                              ),
                    ),
                  ),
                  if (controller.hasAttemptedNextWithoutLicense.value)
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

  Widget _buildCarInfoStep(BuildContext context) {
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
                  _buildStepProgress(2, 3, context),
                  const SizedBox(height: TSpacing.md),
                  Text(
                    'Informations du véhicule',
                    style: TTypography.headingLarge(context),
                  ),
                  const SizedBox(height: TSpacing.sm),
                  Text(
                    'Prenez une photo de votre véhicule',
                    style: TTypography.bodyMedium(context),
                  ),
                  // Add extra space to push content down, making the upload container more accessible
                  const SizedBox(height: 60),
                  // Camera upload container
                  GestureDetector(
                    onTap: () => controller.pickCarImage(),
                    child: Obx(
                      () =>
                          controller.carImage.value == null
                              ? _buildUploadContainer(
                                context,
                                'Touchez pour prendre une photo',
                                Icons.add_a_photo_outlined,
                                isError:
                                    controller.carImage.value == null &&
                                    (controller
                                            .hasAttemptedNextWithInvalidCarBrand
                                            .value ||
                                        controller
                                            .hasAttemptedNextWithInvalidCarModel
                                            .value ||
                                        controller
                                            .hasAttemptedNextWithInvalidLicensePlate
                                            .value),
                                errorText: 'Photo obligatoire',
                              )
                              : _buildImagePreview(
                                context,
                                controller.carImage.value!,
                                onRemove: () => controller.removeCarImage(),
                              ),
                    ),
                  ),
                  if (controller.carImage.value == null)
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
                                'Assurez-vous que votre véhicule est clairement visible sur la photo',
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
                  onPressed: () => controller.validateAndProceedFromCarStep(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIdentityStep(BuildContext context) {
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
                  _buildStepProgress(3, 3, context),
                  const SizedBox(height: TSpacing.md),
                  Text(
                    'Pièce d\'identité',
                    style: TTypography.headingLarge(context),
                  ),
                  const SizedBox(height: TSpacing.sm),
                  Text(
                    'Prenez une photo de votre carte d\'identité ou passeport',
                    style: TTypography.bodyMedium(context),
                  ),
                  // Add extra space to push content down, making the upload container more accessible
                  const SizedBox(height: 60),
                  // Camera upload container
                  GestureDetector(
                    onTap: () => controller.pickIdCard(),
                    child: Obx(
                      () =>
                          controller.idCardImage.value == null
                              ? _buildUploadContainer(
                                context,
                                'Touchez pour prendre une photo',
                                Icons.add_a_photo_outlined,
                                isError:
                                    controller
                                        .hasAttemptedNextWithoutIdCard
                                        .value,
                                errorText: 'Photo obligatoire',
                              )
                              : _buildImagePreview(
                                context,
                                controller.idCardImage.value!,
                                onRemove: () => controller.removeIdCardImage(),
                              ),
                    ),
                  ),
                  if (controller.hasAttemptedNextWithoutIdCard.value)
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
                                'Assurez-vous que toutes les informations sont clairement visibles',
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
                  onPressed: () => controller.validateAndProceedFromIdStep(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewStep(BuildContext context) {
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
                  _buildInfoCard(
                    context,
                    'Permis de conduire',
                    [],
                    controller.driverLicenseImage.value,
                    Icons.drive_eta_rounded,
                    () => controller.goToStep(1),
                  ),
                  const SizedBox(height: TSpacing.md),
                  _buildInfoCard(
                    context,
                    'Véhicule',
                    [],
                    controller.carImage.value,
                    Icons.directions_car_filled_rounded,
                    () => controller.goToStep(2),
                  ),
                  const SizedBox(height: TSpacing.md),
                  _buildInfoCard(
                    context,
                    'Pièce d\'identité',
                    [],
                    controller.idCardImage.value,
                    Icons.person_rounded,
                    () => controller.goToStep(3),
                  ),
                  const SizedBox(height: TSpacing.xl),
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.all(TSpacing.md),
                      decoration: BoxDecoration(
                        color: TColors.surface(context),
                        borderRadius: TRadius.cardRadius,
                        boxShadow: TShadows.subtle,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: controller.termsAccepted.value,
                              onChanged:
                                  (value) =>
                                      controller.termsAccepted.value =
                                          value ?? false,
                              activeColor: TColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: TSpacing.sm),
                          Expanded(
                            child: Text(
                              'J\'accepte que ces informations soient vérifiées et utilisées pour la validation de mon compte chauffeur',
                              style: TTypography.bodySmall(
                                context,
                              ).copyWith(color: TColors.textPrimary(context)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () =>
                        controller.submissionError.value.isNotEmpty
                            ? Container(
                              padding: const EdgeInsets.all(TSpacing.sm),
                              margin: const EdgeInsets.only(top: TSpacing.md),
                              decoration: BoxDecoration(
                                color: TColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(TRadius.sm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: TColors.error,
                                    size: 20,
                                  ),
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
                            )
                            : const SizedBox.shrink(),
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
                            ? 'Envoi en cours...'
                            : 'Soumettre ma demande',
                    onPressed:
                        controller.isSubmitting.value
                            ? null
                            : () => controller.submitVerification(),
                    icon:
                        controller.isSubmitting.value
                            ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
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

  Widget _buildSuccessStep(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: TColors.success.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline_rounded,
              color: TColors.success,
              size: 80,
            ),
          ),
          const SizedBox(height: TSpacing.xl),
          Text(
            'Demande envoyée !',
            style: TTypography.headingLarge(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSpacing.md),
          Text(
            'Nous examinons votre dossier. Vous recevrez une notification lorsque votre vérification sera terminée.',
            style: TTypography.bodyMedium(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSpacing.md),
          Container(
            padding: const EdgeInsets.all(TSpacing.md),
            margin: const EdgeInsets.symmetric(vertical: TSpacing.lg),
            decoration: BoxDecoration(
              color: TColors.neutral100,
              borderRadius: TRadius.cardRadius,
              border: Border.all(color: TColors.neutral300),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(TSpacing.sm),
                  decoration: BoxDecoration(
                    color: TColors.info.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.access_time, color: TColors.info, size: 24),
                ),
                const SizedBox(width: TSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Délai estimé',
                        style: TTypography.labelLarge(context),
                      ),
                      Text(
                        '24-48 heures ouvrables',
                        style: TTypography.bodySmall(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          PrimaryButton(
            text: 'Retour à l\'accueil',
            onPressed: () => controller.goToHome(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    List<String> details,
    dynamic image,
    IconData icon,
    VoidCallback onEdit, {
    bool showImageIfNull = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: TRadius.cardRadius,
        boxShadow: TShadows.subtle,
      ),
      padding: const EdgeInsets.all(TSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                icon: const Icon(Icons.edit_outlined, color: TColors.primary),
                onPressed: onEdit,
                tooltip: 'Modifier',
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(8),
                iconSize: 20,
              ),
            ],
          ),
          const SizedBox(height: TSpacing.sm),
          ...details
              .map(
                (detail) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(detail, style: TTypography.bodyMedium(context)),
                ),
              )
              .toList(),
          if (image != null || showImageIfNull) ...[
            const SizedBox(height: TSpacing.sm),
            if (image != null)
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(TRadius.sm),
                  image: DecorationImage(
                    image: FileImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: TColors.neutral200,
                  borderRadius: BorderRadius.circular(TRadius.sm),
                ),
                child: Center(
                  child: Text(
                    'Aucune image',
                    style: TTypography.bodySmall(context),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepProgress(
    int currentStep,
    int totalSteps,
    BuildContext context,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: TSpacing.md,
            vertical: TSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: TColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(TRadius.pill),
          ),
          child: Text(
            'Étape $currentStep/$totalSteps',
            style: TTypography.labelMedium(
              context,
            ).copyWith(color: TColors.primary, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: TSpacing.sm),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(TRadius.xs),
            child: LinearProgressIndicator(
              value: currentStep / totalSteps,
              backgroundColor: TColors.neutral300,
              color: TColors.primary,
              minHeight: 4,
            ),
          ),
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
    bool isOptional = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color:
                isError
                    ? TColors.error.withOpacity(0.05)
                    : TColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(TRadius.md),
            border: Border.all(
              color: isError ? TColors.error : TColors.primary,
              width: 1.5,
              style: BorderStyle.solid,
            ),
            boxShadow: isError ? null : TShadows.subtle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(TSpacing.md),
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 42,
                  color: isError ? TColors.error : TColors.primary,
                ),
              ),
              const SizedBox(height: TSpacing.sm),
              Text(
                text,
                style: TTypography.bodyMedium(context).copyWith(
                  color: isError ? TColors.error : TColors.primary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSpacing.xs),
              Text(
                isOptional
                    ? 'Photo optionnelle'
                    : 'Appuyez pour prendre une photo',
                style: TTypography.labelSmall(context).copyWith(
                  color:
                      isError
                          ? TColors.error.withOpacity(0.7)
                          : TColors.neutral700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        if (isError && errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              errorText,
              style: TTypography.bodySmall(
                context,
              ).copyWith(color: TColors.error),
            ),
          ),
      ],
    );
  }

  Widget _buildImagePreview(
    BuildContext context,
    dynamic image, {
    required Function onRemove,
  }) {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TRadius.md),
            image: DecorationImage(image: FileImage(image), fit: BoxFit.cover),
            boxShadow: TShadows.subtle,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => onRemove(),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: TSpacing.sm,
              horizontal: TSpacing.sm,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(TRadius.md),
                bottomRight: Radius.circular(TRadius.md),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Photo ajoutée',
                  style: TTypography.labelMedium(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabeledTextField(
    BuildContext context,
    TextEditingController controller,
    String label,
    String hint, {
    IconData? suffixIcon,
    bool hasError = false,
    String errorText = '',
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTypography.labelLarge(context)),
        const SizedBox(height: TSpacing.sm),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon:
                suffixIcon != null
                    ? Icon(suffixIcon, color: TColors.neutral600)
                    : null,
            errorText: hasError ? errorText : null,
          ),
          textCapitalization: textCapitalization,
        ),
      ],
    );
  }
}
