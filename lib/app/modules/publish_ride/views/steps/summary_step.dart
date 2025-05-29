import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/controllers/publish_ride_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

class SummaryStep extends StatelessWidget {
  final PublishRideController controller;

  const SummaryStep({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Récapitulatif', style: TTypography.headingMedium(context)),

          const SizedBox(height: TSpacing.sm),

          Text(
            'Vérifiez les détails de votre trajet avant de publier',
            style: TTypography.bodyMedium(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
          ),

          const SizedBox(height: TSpacing.xl),

          // Summary card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(TSpacing.lg),
              decoration: BoxDecoration(
                color: TColors.surface(context),
                borderRadius: TRadius.cardRadius,
                boxShadow: TShadows.medium,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Route visualization
                    _buildRouteVisualization(context),

                    const SizedBox(height: TSpacing.xl),

                    // Divider
                    Divider(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? TColors.neutral700
                              : TColors.neutral300,
                    ),

                    const SizedBox(height: TSpacing.lg),

                    // Time details
                    _buildDetailItem(
                      context,
                      title: 'Heure de départ',
                      content: Obx(
                        () => Text(
                          controller.formatTime(
                            controller.departureTime.value ?? TimeOfDay.now(),
                          ),
                          style: TTypography.bodyLarge(context).copyWith(
                            fontWeight: FontWeight.w500,
                            color: TColors.primary,
                          ),
                        ),
                      ),
                      icon: Icons.access_time,
                      iconColor: TColors.primary,
                    ),

                    const SizedBox(height: TSpacing.lg),

                    // Date details
                    Obx(
                      () => _buildDetailItem(
                        context,
                        title:
                            controller.isRecurring.value
                                ? 'Jours récurrents'
                                : 'Date du trajet',
                        content:
                            controller.isRecurring.value
                                ? Text(
                                  controller.getSelectedWeekdays(),
                                  style: TTypography.bodyMedium(context),
                                )
                                : Text(
                                  controller.specificDate.value != null
                                      ? DateFormat(
                                        'EEEE d MMMM yyyy',
                                        'fr_FR',
                                      ).format(controller.specificDate.value!)
                                      : 'Date non sélectionnée',
                                  style: TTypography.bodyMedium(context),
                                ),
                        icon:
                            controller.isRecurring.value
                                ? Icons.repeat
                                : Icons.event,
                        iconColor: TColors.accent,
                      ),
                    ),

                    const SizedBox(height: TSpacing.xl),

                    // Divider
                    Divider(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? TColors.neutral700
                              : TColors.neutral300,
                    ),

                    const SizedBox(height: TSpacing.lg),

                    // Information
                    Container(
                      padding: const EdgeInsets.all(TSpacing.md),
                      decoration: BoxDecoration(
                        color: TColors.info.withOpacity(0.1),
                        borderRadius: TRadius.cardRadius,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: TColors.info.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.info_outline,
                              color: TColors.info,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: TSpacing.md),
                          Expanded(
                            child: Text(
                              'En publiant ce trajet, vous vous engagez à être disponible aux dates et heures indiquées.',
                              style: TTypography.bodySmall(context),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: TSpacing.lg),

                    // Publish confirmation
                    Container(
                      padding: const EdgeInsets.all(TSpacing.md),
                      decoration: BoxDecoration(
                        color: TColors.success.withOpacity(0.1),
                        borderRadius: TRadius.cardRadius,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: TColors.success.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check_circle_outline,
                              color: TColors.success,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: TSpacing.md),
                          Expanded(
                            child: Text(
                              'Votre trajet sera visible par tous les passagers cherchant un transport dans votre zone.',
                              style: TTypography.bodySmall(context),
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
        ],
      ),
    );
  }

  Widget _buildRouteVisualization(BuildContext context) {
    return Column(
      children: [
        // Departure
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(TSpacing.sm),
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.trip_origin,
                color: TColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: TSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Départ',
                    style: TTypography.labelSmall(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                  const SizedBox(height: 2),
                  Obx(
                    () => Text(
                      controller.departurePoint.value ?? '',
                      style: TTypography.headingSmall(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Connection line
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Container(
                width: 2,
                height: 40,
                color: TColors.primary.withOpacity(0.3),
              ),
            ],
          ),
        ),

        // Arrival
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(TSpacing.sm),
              decoration: BoxDecoration(
                color: TColors.accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: TColors.accent,
                size: 24,
              ),
            ),
            const SizedBox(width: TSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Arrivée',
                    style: TTypography.labelSmall(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                  const SizedBox(height: 2),
                  Obx(
                    () => Text(
                      controller.arrivalPoint.value ?? '',
                      style: TTypography.headingSmall(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required String title,
    required Widget content,
    required IconData icon,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(TSpacing.sm),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: TSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TTypography.labelSmall(
                  context,
                ).copyWith(color: TColors.textSecondary(context)),
              ),
              const SizedBox(height: TSpacing.xs),
              content,
            ],
          ),
        ),
      ],
    );
  }
}
