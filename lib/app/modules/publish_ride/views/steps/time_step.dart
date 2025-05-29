import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/controllers/publish_ride_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

class TimeStep extends StatelessWidget {
  final PublishRideController controller;

  const TimeStep({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
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

            // Modern route summary card
            Container(
              padding: const EdgeInsets.all(TSpacing.lg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    TColors.surface(context),
                    TColors.surface(context).withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(TRadius.lg),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: TColors.neutral300.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  // Departure
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: TColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.trip_origin_rounded,
                          color: TColors.primary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: TSpacing.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Départ',
                              style: TTypography.labelSmall(context).copyWith(
                                color: TColors.textSecondary(context),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Obx(
                              () => Text(
                                controller.departurePoint.value ??
                                    'Non sélectionné',
                                style: TTypography.bodyMedium(context).copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Elegant connection line with dots
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: TSpacing.md),
                    child: Row(
                      children: [
                        const SizedBox(width: 22),
                        Column(
                          children: List.generate(
                            3,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: TColors.primary.withOpacity(0.4),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Arrival
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: TColors.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.location_on_rounded,
                          color: TColors.accent,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: TSpacing.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Arrivée',
                              style: TTypography.labelSmall(context).copyWith(
                                color: TColors.textSecondary(context),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Obx(
                              () => Text(
                                controller.arrivalPoint.value ??
                                    'Non sélectionné',
                                style: TTypography.bodyMedium(context).copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
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

            // Time selection section
            Text(
              'Choisissez votre heure de départ',
              style: TTypography.bodyLarge(
                context,
              ).copyWith(fontWeight: FontWeight.w600, fontSize: 18),
            ),

            const SizedBox(height: TSpacing.sm),

            Text(
              'Sélectionnez un créneau ou définissez une heure précise',
              style: TTypography.bodyMedium(
                context,
              ).copyWith(color: TColors.textSecondary(context), fontSize: 14),
            ),

            const SizedBox(height: TSpacing.lg),

            Obx(() => _buildModernTimeSelection(context)),

            // Bottom safe area
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + TSpacing.lg,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTimeSelection(BuildContext context) {
    // Better time slots with more options
    final List<Map<String, dynamic>> timeSlots = [
      {'time': const TimeOfDay(hour: 6, minute: 0), 'label': 'Tôt le matin'},
      {'time': const TimeOfDay(hour: 8, minute: 0), 'label': 'Matin'},
      {'time': const TimeOfDay(hour: 10, minute: 0), 'label': 'Matinée'},
      {'time': const TimeOfDay(hour: 12, minute: 0), 'label': 'Midi'},
      {
        'time': const TimeOfDay(hour: 14, minute: 0),
        'label': 'Début d\'après-midi',
      },
      {'time': const TimeOfDay(hour: 16, minute: 0), 'label': 'Après-midi'},
      {
        'time': const TimeOfDay(hour: 18, minute: 0),
        'label': 'Fin d\'après-midi',
      },
      {'time': const TimeOfDay(hour: 20, minute: 0), 'label': 'Soirée'},
    ];

    return Column(
      children: [
        // Time slots grid - now uses Wrap for better responsiveness
        Wrap(
          spacing: TSpacing.md,
          runSpacing: TSpacing.md,
          children:
              timeSlots.map((timeSlot) {
                final time = timeSlot['time'] as TimeOfDay;
                final label = timeSlot['label'] as String;

                final isSelected =
                    controller.departureTime.value != null &&
                    controller.departureTime.value!.hour == time.hour &&
                    controller.departureTime.value!.minute == time.minute;

                return SizedBox(
                  width:
                      (MediaQuery.of(context).size.width -
                          (TSpacing.lg * 2) -
                          TSpacing.md) /
                      2,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      gradient:
                          isSelected
                              ? LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  TColors.primary,
                                  TColors.primary.withOpacity(0.8),
                                ],
                              )
                              : null,
                      color: isSelected ? null : TColors.surface(context),
                      borderRadius: BorderRadius.circular(TRadius.lg),
                      border: Border.all(
                        color:
                            isSelected
                                ? TColors.primary
                                : TColors.neutral300.withOpacity(0.4),
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: TColors.primary.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        else
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          controller.departureTime.value = time;
                          HapticFeedback.mediumImpact();
                        },
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: TSpacing.lg,
                            horizontal: TSpacing.md,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.formatTime(time),
                                style: TTypography.headingSmall(
                                  context,
                                ).copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : TColors.textPrimary(context),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                label,
                                textAlign: TextAlign.center,
                                style: TTypography.labelSmall(context).copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isSelected
                                          ? Colors.white.withOpacity(0.9)
                                          : TColors.textSecondary(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),

        const SizedBox(height: TSpacing.xl),

        // Custom time section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(TSpacing.lg),
          decoration: BoxDecoration(
            color: TColors.surface(context),
            borderRadius: BorderRadius.circular(TRadius.lg),
            border: Border.all(color: TColors.neutral300.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: TColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.schedule_rounded,
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
                          'Heure personnalisée',
                          style: TTypography.bodyMedium(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Définissez une heure précise',
                          style: TTypography.labelSmall(
                            context,
                          ).copyWith(color: TColors.textSecondary(context)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: TSpacing.md),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showTimePicker(context),
                  icon: const Icon(Icons.access_time_rounded, size: 18),
                  label: const Text('Choisir une heure'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary.withOpacity(0.1),
                    foregroundColor: TColors.primary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TRadius.md),
                      side: BorderSide(color: TColors.primary.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),

              // Custom time display
              if (controller.departureTime.value != null && _isCustomTime())
                Container(
                  margin: const EdgeInsets.only(top: TSpacing.md),
                  padding: const EdgeInsets.all(TSpacing.md),
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(TRadius.md),
                    border: Border.all(color: TColors.primary.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: TColors.primary,
                        size: 18,
                      ),
                      const SizedBox(width: TSpacing.sm),
                      Text(
                        'Heure sélectionnée: ${controller.formatTime(controller.departureTime.value!)}',
                        style: TTypography.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.w600,
                          color: TColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  bool _isCustomTime() {
    if (controller.departureTime.value == null) return false;

    final standardTimes = [6, 8, 10, 12, 14, 16, 18, 20];
    return !standardTimes.contains(controller.departureTime.value!.hour) ||
        controller.departureTime.value!.minute != 0;
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final initialTime = controller.departureTime.value ?? TimeOfDay.now();

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: TColors.primary,
              onPrimary: Colors.white,
              onSurface: TColors.textPrimary(context),
              surface: TColors.surface(context),
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: TColors.surface(context),
              dayPeriodBorderSide: BorderSide(color: TColors.primary, width: 2),
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TRadius.lg),
                side: BorderSide(color: TColors.primary.withOpacity(0.3)),
              ),
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TRadius.md),
              ),
              hourMinuteTextStyle: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: TColors.textPrimary(context),
              ),
              helpTextStyle: TextStyle(
                color: TColors.textSecondary(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      controller.departureTime.value = selectedTime;
      HapticFeedback.mediumImpact();
    }
  }
}
