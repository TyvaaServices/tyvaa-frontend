import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/driver_verification/controllers/driver_verification_controller.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';
import 'package:passenger_tyvaa/app/widgets/primary_button.dart';

class WelcomeStep extends StatelessWidget {
  final DriverVerificationController controller;

  const WelcomeStep({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          'Photo recto et verso de votre permis en cours de validité',
                          Icons.drive_eta_rounded,
                        ),
                        Divider(color: TColors.neutral300, height: TSpacing.lg),
                        _buildStepItem(
                          context,
                          'Carte grise',
                          'Photo recto et verso de votre carte grise',
                          Icons.directions_car_filled_rounded,
                        ),
                        Divider(color: TColors.neutral300, height: TSpacing.lg),
                        _buildStepItem(
                          context,
                          'Pièce d\'identité',
                          'Photo recto et verso de votre carte d\'identité ou passeport valide',
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
}
