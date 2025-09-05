import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/dexchange_models.dart';
import '../../../themes/design_system.dart';
import '../controllers/payment_controller.dart';
import '../widgets/dexchange_payment_selector.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      appBar: AppBar(
        backgroundColor: TColors.surface(context),
        elevation: 0,
        title: Text(
          'Réserver trajet',
          style: TTypography.headlineSmall(context),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: TColors.textPrimary(context)),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(TSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Amount card with clean design
            Container(
              padding: EdgeInsets.all(TSpacing.lg),
              decoration: BoxDecoration(
                color: TColors.surface(context),
                borderRadius: TRadius.cardRadius,
                border: Border.all(color: TColors.neutral300, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Montant à payer',
                    style: TTypography.bodyLarge(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                  SizedBox(height: TSpacing.sm),
                  Obx(
                    () => Text(
                      '${controller.amount.value.toStringAsFixed(0)} XOF',
                      style: TTypography.displayMedium(context).copyWith(
                        color: TColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: TSpacing.xl),

            // DEXCHANGE Payment Method Selector
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(TSpacing.lg),
                  decoration: BoxDecoration(
                    color: TColors.surface(context),
                    borderRadius: TRadius.cardRadius,
                    border: Border.all(color: TColors.neutral300, width: 1),
                  ),
                  child: const DexchangePaymentSelector(),
                ),
              ),
            ),

            SizedBox(height: TSpacing.xl),

            // Payment confirmation button
            Container(
              width: double.infinity,
              height: 56,
              child: Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.booking != null &&
                              controller.selectedPaymentMethod.value != null &&
                              !controller.isLoading.value
                          ? () =>
                              controller.handleBookAndPay(controller.booking!)
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        controller.booking != null &&
                                controller.selectedPaymentMethod.value != null
                            ? TColors.primary
                            : TColors.neutral400,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: TRadius.buttonRadius,
                    ),
                  ),
                  child:
                      controller.isLoading.value
                          ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                          : Text(
                            controller.selectedPaymentMethod.value != null
                                ? 'Payer via ${controller.selectedPaymentMethod.value != null ? _getPaymentMethodDisplayName(controller.selectedPaymentMethod.value!) : "Mobile Money"}'
                                : controller.availablePaymentMethods.isEmpty &&
                                    controller.isLoading.value
                                ? 'Chargement des méthodes...'
                                : 'Sélectionnez une méthode de paiement',
                            style: TTypography.labelLarge(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                ),
              ),
            ),

            SizedBox(height: TSpacing.md),

            // Error message with clean design
            Obx(
              () =>
                  controller.errorMessage.value.isNotEmpty
                      ? Container(
                        padding: EdgeInsets.all(TSpacing.md),
                        decoration: BoxDecoration(
                          color: TColors.error.withOpacity(0.1),
                          borderRadius: TRadius.inputRadius,
                          border: Border.all(
                            color: TColors.error.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: TColors.error,
                              size: 20,
                            ),
                            SizedBox(width: TSpacing.sm),
                            Expanded(
                              child: Text(
                                controller.errorMessage.value,
                                style: TTypography.bodyMedium(
                                  context,
                                ).copyWith(color: TColors.error),
                              ),
                            ),
                          ],
                        ),
                      )
                      : const SizedBox.shrink(),
            ),

            // Success message
            Obx(
              () =>
                  controller.successMessage.value.isNotEmpty
                      ? Container(
                        padding: EdgeInsets.all(TSpacing.md),
                        decoration: BoxDecoration(
                          color: TColors.success.withOpacity(0.1),
                          borderRadius: TRadius.inputRadius,
                          border: Border.all(
                            color: TColors.success.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: TColors.success,
                              size: 20,
                            ),
                            SizedBox(width: TSpacing.sm),
                            Expanded(
                              child: Text(
                                controller.successMessage.value,
                                style: TTypography.bodyMedium(
                                  context,
                                ).copyWith(color: TColors.success),
                              ),
                            ),
                          ],
                        ),
                      )
                      : const SizedBox.shrink(),
            ),

            SizedBox(height: TSpacing.md),

            // Secure payment note - Updated for DEXCHANGE
            Container(
              padding: EdgeInsets.all(TSpacing.md),
              decoration: BoxDecoration(
                color: TColors.neutral200.withOpacity(0.5),
                borderRadius: TRadius.inputRadius,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: TColors.textSecondary(context),
                    size: 16,
                  ),
                  SizedBox(width: TSpacing.sm),
                  Expanded(
                    child: Text(
                      'Paiement sécurisé via DEXCHANGE Mobile Money',
                      style: TTypography.bodySmall(
                        context,
                      ).copyWith(color: TColors.textSecondary(context)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPaymentMethodDisplayName(DexchangePaymentMethod method) {
    switch (method) {
      case DexchangePaymentMethod.orange:
        return 'Orange Money';
      case DexchangePaymentMethod.wave:
        return 'Wave';
      case DexchangePaymentMethod.mtn:
        return 'MTN Money';
      case DexchangePaymentMethod.moov:
        return 'Moov Money';
      case DexchangePaymentMethod.free:
        return 'Free Money';
      case DexchangePaymentMethod.wizall:
        return 'Wizall Money';
    }
  }
}
