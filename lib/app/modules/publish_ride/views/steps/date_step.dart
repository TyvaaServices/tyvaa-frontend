import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/controllers/publish_ride_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

class DateStep extends StatelessWidget {
  final PublishRideController controller;

  const DateStep({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date du trajet', style: TTypography.headingMedium(context)),

          const SizedBox(height: TSpacing.sm),

          Text(
            'Quand souhaitez-vous effectuer ce trajet?',
            style: TTypography.bodyMedium(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
          ),

          const SizedBox(height: TSpacing.xl),

          // Route summary
          _buildRouteSummary(context),

          const SizedBox(height: TSpacing.xl),

          // Toggle between one-time and recurring
          Container(
            decoration: BoxDecoration(
              color: TColors.surface(context),
              borderRadius: TRadius.cardRadius,
              boxShadow: TShadows.subtle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(TSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type de trajet',
                    style: TTypography.labelLarge(context),
                  ),

                  const SizedBox(height: TSpacing.md),

                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => _buildSelectionTile(
                            context,
                            title: 'Date spécifique',
                            icon: Icons.event,
                            isSelected: !controller.isRecurring.value,
                            onTap: () => controller.isRecurring.value = false,
                          ),
                        ),
                      ),
                      const SizedBox(width: TSpacing.md),
                      Expanded(
                        child: Obx(
                          () => _buildSelectionTile(
                            context,
                            title: 'Récurrent',
                            icon: Icons.repeat,
                            isSelected: controller.isRecurring.value,
                            onTap: () => controller.isRecurring.value = true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: TSpacing.xl),

          // Date selection based on selection type
          Obx(
            () =>
                controller.isRecurring.value
                    ? _buildRecurringSelection(context)
                    : _buildDateSelection(context),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TSpacing.md),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: TRadius.cardRadius,
        boxShadow: TShadows.subtle,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Departure and destination
                Row(
                  children: [
                    Obx(
                      () => Text(
                        '${controller.departurePoint.value} → ${controller.arrivalPoint.value}',
                        style: TTypography.bodyMedium(
                          context,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: TSpacing.xs),

                // Time
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: TColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Obx(
                      () => Text(
                        'Départ à ${controller.formatTime(controller.departureTime.value ?? TimeOfDay.now())}',
                        style: TTypography.bodyMedium(
                          context,
                        ).copyWith(color: TColors.textSecondary(context)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: TSpacing.md,
          vertical: TSpacing.md,
        ),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? TColors.primary.withOpacity(0.1)
                  : Theme.of(context).brightness == Brightness.dark
                  ? TColors.neutral800
                  : TColors.neutral200,
          borderRadius: TRadius.cardRadius,
          border:
              isSelected ? Border.all(color: TColors.primary, width: 2) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  isSelected ? TColors.primary : TColors.textSecondary(context),
              size: 24,
            ),
            const SizedBox(height: TSpacing.sm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TTypography.labelMedium(context).copyWith(
                color:
                    isSelected
                        ? TColors.primary
                        : TColors.textSecondary(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelection(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDatePicker(context),
      child: Container(
        padding: const EdgeInsets.all(TSpacing.md),
        decoration: BoxDecoration(
          color: TColors.surface(context),
          borderRadius: TRadius.cardRadius,
          boxShadow: TShadows.subtle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sélectionnez une date',
              style: TTypography.labelLarge(context),
            ),

            const SizedBox(height: TSpacing.md),

            Center(
              child: Obx(
                () =>
                    controller.specificDate.value != null
                        ? _buildSelectedDate(context)
                        : _buildDatePickerButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerButton(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(TSpacing.md),
          decoration: BoxDecoration(
            color: TColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.calendar_today,
            color: TColors.primary,
            size: 40,
          ),
        ),
        const SizedBox(height: TSpacing.sm),
        Text(
          'Touchez pour sélectionner',
          style: TTypography.bodyMedium(
            context,
          ).copyWith(color: TColors.textSecondary(context)),
        ),
      ],
    );
  }

  Widget _buildSelectedDate(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: TSpacing.xl,
            vertical: TSpacing.lg,
          ),
          decoration: BoxDecoration(
            color: TColors.primary.withOpacity(0.1),
            borderRadius: TRadius.cardRadius,
          ),
          child: Column(
            children: [
              Text(
                DateFormat(
                  'EEEE',
                  'fr_FR',
                ).format(controller.specificDate.value!),
                style: TTypography.bodyMedium(
                  context,
                ).copyWith(color: TColors.textSecondary(context)),
              ),
              const SizedBox(height: TSpacing.xs),
              Text(
                DateFormat('d', 'fr_FR').format(controller.specificDate.value!),
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: TColors.primary,
                ),
              ),
              const SizedBox(height: TSpacing.xs),
              Text(
                DateFormat(
                  'MMMM yyyy',
                  'fr_FR',
                ).format(controller.specificDate.value!),
                style: TTypography.bodyMedium(context),
              ),
            ],
          ),
        ),
        const SizedBox(height: TSpacing.md),
        TextButton.icon(
          onPressed: () => _showDatePicker(context),
          icon: const Icon(Icons.edit),
          label: const Text('Modifier'),
          style: TextButton.styleFrom(foregroundColor: TColors.primary),
        ),
      ],
    );
  }

  Widget _buildRecurringSelection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TSpacing.md),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: TRadius.cardRadius,
        boxShadow: TShadows.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jours de la semaine', style: TTypography.labelLarge(context)),

          const SizedBox(height: TSpacing.md),

          Text(
            'Sélectionnez les jours où vous effectuerez ce trajet régulièrement',
            style: TTypography.bodySmall(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
          ),

          const SizedBox(height: TSpacing.lg),

          // Weekday selection
          Obx(
            () => Wrap(
              spacing: TSpacing.sm,
              runSpacing: TSpacing.sm,
              alignment: WrapAlignment.center,
              children: List.generate(7, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.selectedDays[index] =
                        !controller.selectedDays[index];
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color:
                          controller.selectedDays[index]
                              ? TColors.primary
                              : Theme.of(context).brightness == Brightness.dark
                              ? TColors.neutral800
                              : TColors.neutral200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        controller.weekdayLabels[index],
                        style: TTypography.labelMedium(context).copyWith(
                          color:
                              controller.selectedDays[index]
                                  ? Colors.white
                                  : TColors.textSecondary(context),
                          fontWeight:
                              controller.selectedDays[index]
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: TSpacing.lg),

          // Selected days summary
          Obx(
            () => Text(
              'Jours sélectionnés: ${controller.getSelectedWeekdays()}',
              textAlign: TextAlign.center,
              style: TTypography.bodyMedium(
                context,
              ).copyWith(color: TColors.textSecondary(context)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final initialDate = controller.specificDate.value ?? now;
    final firstDate = now;
    final lastDate = now.add(const Duration(days: 365));

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: TColors.primary,
              brightness: Theme.of(context).brightness,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: TColors.surface(context),
              headerBackgroundColor: TColors.primary,
              headerForegroundColor: Colors.white,
              dayForegroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return TColors.textPrimary(context);
              }),
              dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return TColors.primary;
                }
                return Colors.transparent;
              }),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      controller.specificDate.value = selectedDate;
    }
  }
}
