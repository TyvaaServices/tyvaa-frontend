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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: TColors.surface(context),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: TColors.textPrimary(context),
              ),
              onPressed: () => Get.back(),
            ),
            title: Text(
              'Paiement',
              style: TTypography.headingMedium(context).copyWith(
                fontWeight: FontWeight.w700,
                color: TColors.textPrimary(context),
              ),
            ),
            centerTitle: true,
            actions: [
              Container(
                margin: EdgeInsets.only(right: TSpacing.md),
                padding: EdgeInsets.all(TSpacing.xs),
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shield_rounded,
                  color: TColors.primary,
                  size: 20,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(TSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Hero Amount Card with Gradient
                  _buildAmountCard(context),

                  SizedBox(height: TSpacing.xl),

                  // Payment Methods Section
                  _buildPaymentMethodsSection(context),

                  SizedBox(height: TSpacing.xl),

                  // Transaction Summary Card
                  _buildTransactionSummary(context),

                  SizedBox(height: 100), // Space for bottom sheet
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomSheet(context),
    );
  }

  Widget _buildAmountCard(BuildContext context) {
    return Hero(
      tag: 'payment_amount',
      child: Material(
        color: Colors.transparent,
        borderRadius: TRadius.cardRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: TRadius.cardRadius,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [TColors.primary, TColors.primaryLight],
            ),
            boxShadow: TShadows.medium,
          ),
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                right: -30,
                top: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                bottom: -30,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(TSpacing.xl),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(TSpacing.sm),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(TRadius.md),
                          ),
                          child: Icon(
                            Icons.payment_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: TSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Montant à payer',
                                style: TTypography.bodyMedium(context).copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              SizedBox(height: TSpacing.xs),
                              Obx(
                                () => Text(
                                  '${controller.amount.value.toStringAsFixed(0)} XOF',
                                  style: TTypography.headingLarge(
                                    context,
                                  ).copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 32,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: TSpacing.lg),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: TSpacing.md,
                        vertical: TSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(TRadius.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.flash_on_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: TSpacing.xs),
                          Text(
                            'Paiement instantané',
                            style: TTypography.labelMedium(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
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
    );
  }

  Widget _buildPaymentMethodsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(TSpacing.xs),
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(TRadius.sm),
              ),
              child: Icon(
                Icons.credit_card_rounded,
                color: TColors.primary,
                size: 20,
              ),
            ),
            SizedBox(width: TSpacing.sm),
            Text(
              'Choisir une méthode de paiement',
              style: TTypography.headingSmall(
                context,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: TSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: TColors.surface(context),
            borderRadius: TRadius.cardRadius,
            border: Border.all(color: TColors.neutral300.withOpacity(0.3)),
            boxShadow: TShadows.subtle,
          ),
          child: Padding(
            padding: EdgeInsets.all(TSpacing.lg),
            child: const DexchangePaymentSelector(),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionSummary(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: TRadius.cardRadius,
        border: Border.all(color: TColors.neutral300.withOpacity(0.3)),
        boxShadow: TShadows.subtle,
      ),
      child: Padding(
        padding: EdgeInsets.all(TSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.receipt_long_rounded,
                  color: TColors.primary,
                  size: 20,
                ),
                SizedBox(width: TSpacing.sm),
                Text(
                  'Résumé de la transaction',
                  style: TTypography.headingSmall(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: TSpacing.md),
            _buildSummaryRow(context, 'Type', 'Voyage partagé'),
            _buildSummaryRow(context, 'Commission', 'Incluse'),
            Divider(height: TSpacing.lg),
            Obx(
              () => _buildSummaryRow(
                context,
                'Total',
                '${controller.amount.value.toStringAsFixed(0)} XOF',
                isTotal: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: TSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style:
                isTotal
                    ? TTypography.bodyLarge(
                      context,
                    ).copyWith(fontWeight: FontWeight.w600)
                    : TTypography.bodyMedium(context),
          ),
          Text(
            value,
            style:
                isTotal
                    ? TTypography.bodyLarge(context).copyWith(
                      fontWeight: FontWeight.w700,
                      color: TColors.primary,
                    )
                    : TTypography.bodyMedium(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(TRadius.xl)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(TSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Security Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: TSpacing.lg,
                  vertical: TSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: TColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(TRadius.pill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.security_rounded,
                      color: TColors.success,
                      size: 16,
                    ),
                    SizedBox(width: TSpacing.xs),
                    Text(
                      'Paiement 100% sécurisé avec cryptage SSL',
                      style: TTypography.bodySmall(context).copyWith(
                        color: TColors.success,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: TSpacing.lg),

              // Payment Button
              Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: ElevatedButton(
                    onPressed:
                        controller.booking != null &&
                                controller.selectedPaymentMethod.value !=
                                    null &&
                                !controller.isLoading.value
                            ? () =>
                                controller.handleBookAndPay(controller.booking!)
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      padding: EdgeInsets.symmetric(vertical: TSpacing.lg),
                      shape: RoundedRectangleBorder(
                        borderRadius: TRadius.buttonRadius,
                      ),
                      elevation: 0,
                      shadowColor: TColors.primary.withOpacity(0.3),
                    ),
                    child:
                        controller.isLoading.value
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: TSpacing.sm),
                                Text(
                                  'Traitement en cours...',
                                  style: TTypography.bodyLarge(
                                    context,
                                  ).copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.payment_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: TSpacing.sm),
                                Text(
                                  controller.selectedPaymentMethod.value != null
                                      ? 'Payer avec ${_getPaymentMethodDisplayName(controller.selectedPaymentMethod.value!)}'
                                      : controller
                                              .availablePaymentMethods
                                              .isEmpty &&
                                          controller.isLoading.value
                                      ? 'Chargement des méthodes...'
                                      : 'Sélectionnez une méthode de paiement',
                                  style: TTypography.bodyLarge(
                                    context,
                                  ).copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _getPaymentMethodDisplayName(DexchangePaymentMethod method) {
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
