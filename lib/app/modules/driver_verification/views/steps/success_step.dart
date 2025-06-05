import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/driver_verification/controllers/driver_verification_controller.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';
import 'package:passenger_tyvaa/app/widgets/primary_button.dart';

class SuccessStep extends StatelessWidget {
  final DriverVerificationController controller;

  const SuccessStep({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(TSpacing.md),
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
                size: 80,
                color: TColors.success,
              ),
            ),
            const SizedBox(height: TSpacing.xl),
            Text(
              'Demande soumise avec succès',
              style: TTypography.headingLarge(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSpacing.md),
            Text(
              'Votre demande de vérification a été envoyée avec succès. Nous l\'examinerons dans les 24 à 48 heures.',
              style: TTypography.bodyMedium(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSpacing.xl),
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
                          'Vous recevrez une notification',
                          style: TTypography.labelMedium(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Une fois votre compte vérifié, vous pourrez proposer des trajets',
                          style: TTypography.bodySmall(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSpacing.xxl),
            PrimaryButton(
              text: 'Retour à l\'accueil',
              onPressed: () => Get.offAllNamed(Routes.MAIN),
            ),

            // // TEMPORARY TEST BUTTON - TO BE REMOVED AFTER TESTING
            // const SizedBox(height: TSpacing.md),
            // Container(
            //   padding: const EdgeInsets.all(8),
            //   decoration: BoxDecoration(
            //     color: Colors.amber.withOpacity(0.2),
            //     borderRadius: BorderRadius.circular(8),
            //     border: Border.all(color: Colors.amber),
            //   ),
            //   child: Column(
            //     children: [
            //       const Text(
            //         'BOUTON DE TEST - À SUPPRIMER',
            //         style: TextStyle(
            //           color: Colors.deepOrange,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       const SizedBox(height: 8),
            //       Obx(
            //         () => ElevatedButton.icon(
            //           onPressed:
            //               controller.isGeneratingPdf.value
            //                   ? null
            //                   : () => _generatePdfInBackground(context),
            //           icon:
            //               controller.isGeneratingPdf.value
            //                   ? Container(
            //                     width: 20,
            //                     height: 20,
            //                     padding: const EdgeInsets.all(2),
            //                     child: const CircularProgressIndicator(
            //                       strokeWidth: 2,
            //                     ),
            //                   )
            //                   : const Icon(Icons.picture_as_pdf),
            //           label: Text(
            //             controller.isGeneratingPdf.value
            //                 ? 'Génération en cours...'
            //                 : 'Générer le PDF de vérification',
            //           ),
            //           style: ElevatedButton.styleFrom(
            //             backgroundColor: Colors.deepPurple,
            //             foregroundColor: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
