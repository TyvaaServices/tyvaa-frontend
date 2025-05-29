import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/driver_verification/views/driver_verification_view.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';
import 'package:passenger_tyvaa/app/widgets/primary_button.dart';

class VerificationRequiredScreen extends StatelessWidget {
  const VerificationRequiredScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: TColors.textPrimary(context)),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSpacing.lg),
          child: Column(
            children: [
              // Top section with illustration
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Illustration
                      Image.asset(
                        'assets/images/publier_trajet_2.png',
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: TSpacing.xl),

                      // Title
                      Text(
                        'Vérification requise',
                        style: TTypography.headingLarge(context),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: TSpacing.md),

                      // Description
                      Text(
                        'Pour assurer la sécurité de notre communauté, nous devons vérifier votre identité avant que vous puissiez publier des trajets.',
                        style: TTypography.bodyLarge(context),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: TSpacing.xxl),

                      // Requirements list
                      _buildRequirementItem(
                        context,
                        Icons.badge_outlined,
                        'Permis de conduire',
                        'Une photo de votre permis de conduire valide',
                      ),

                      _buildRequirementItem(
                        context,
                        Icons.directions_car_outlined,
                        'Photo du véhicule',
                        'Une photo de votre véhicule pour l\'identification',
                      ),

                      _buildRequirementItem(
                        context,
                        Icons.person_outline,
                        'Pièce d\'identité',
                        'Une photo de votre carte d\'identité ou passeport',
                      ),

                      const SizedBox(height: TSpacing.xxl),

                      // Info box
                      Container(
                        padding: const EdgeInsets.all(TSpacing.md),
                        decoration: BoxDecoration(
                          color: TColors.info.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(TRadius.md),
                          border: Border.all(
                            color: TColors.info.withOpacity(0.3),
                          ),
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

              // Bottom buttons
              Column(
                children: [
                  PrimaryButton(
                    text: 'Commencer la vérification',
                    onPressed: () {
                      Get.to(() => const DriverVerificationView());
                    },
                  ),
                  const SizedBox(height: TSpacing.md),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Je ferai ça plus tard',
                      style: TTypography.labelLarge(
                        context,
                      ).copyWith(color: TColors.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: TSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(TSpacing.sm),
            decoration: BoxDecoration(
              color: TColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(TRadius.sm),
            ),
            child: Icon(icon, color: TColors.primary),
          ),
          const SizedBox(width: TSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TTypography.labelLarge(context)),
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
