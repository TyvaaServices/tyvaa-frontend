import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/controllers/publish_ride_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

class TimeStep extends StatelessWidget {
  final PublishRideController controller;

  const TimeStep({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Heure de départ', style: TTypography.headingMedium(context)),

          const SizedBox(height: TSpacing.sm),

          Text(
            'À quelle heure prévoyez-vous de partir?',
            style: TTypography.bodyMedium(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
          ),

          const SizedBox(height: TSpacing.lg),

          // Route info card
          Container(
            padding: const EdgeInsets.all(TSpacing.md),
            decoration: BoxDecoration(
              color: TColors.surface(context),
              borderRadius: TRadius.cardRadius,
              boxShadow: TShadows.subtle,
            ),
            child: Column(
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
                        size: 20,
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
                              style: TTypography.bodyMedium(
                                context,
                              ).copyWith(fontWeight: FontWeight.w500),
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
                        height: 30,
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
                        size: 20,
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
                              style: TTypography.bodyMedium(
                                context,
                              ).copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: TSpacing.xl),

          // Time selection
          Center(
            child: Obx(
              () =>
                  controller.departureTime.value == null
                      ? _buildTimePickerButton(context)
                      : _buildSelectedTime(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePickerButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTimePicker(context),
      child: Container(
        padding: const EdgeInsets.all(TSpacing.lg),
        decoration: BoxDecoration(
          color: TColors.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.access_time, color: TColors.primary, size: 48),
      ),
    );
  }

  Widget _buildSelectedTime(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTimePicker(context),
      child: Column(
        children: [
          Text(
            'Heure de départ',
            style: TTypography.bodyMedium(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
          ),
          const SizedBox(height: TSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: TSpacing.xl,
              vertical: TSpacing.lg,
            ),
            decoration: BoxDecoration(
              color: TColors.surface(context),
              borderRadius: TRadius.cardRadius,
              boxShadow: TShadows.medium,
              border: Border.all(
                color: TColors.primary.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Text(
              controller.formatTime(controller.departureTime.value!),
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: TColors.primary,
              ),
            ),
          ),
          const SizedBox(height: TSpacing.md),
          TextButton.icon(
            onPressed: () => _showTimePicker(context),
            icon: const Icon(Icons.edit),
            label: const Text('Modifier'),
            style: TextButton.styleFrom(foregroundColor: TColors.primary),
          ),
        ],
      ),
    );
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final initialTime = controller.departureTime.value ?? TimeOfDay.now();

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: TColors.primary,
              onPrimary: Colors.white,
              onSurface: TColors.neutral900,
            ),
            timePickerTheme: TimePickerThemeData(
              dayPeriodBorderSide: const BorderSide(color: TColors.primary),
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TRadius.md),
              ),
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TRadius.sm),
              ),
              hourMinuteTextStyle: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: TColors.textPrimary(context),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      controller.departureTime.value = selectedTime;
    }
  }
}
