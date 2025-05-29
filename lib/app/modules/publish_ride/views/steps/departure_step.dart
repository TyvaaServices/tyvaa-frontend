import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/controllers/publish_ride_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

class DepartureStep extends StatelessWidget {
  final PublishRideController controller;

  const DepartureStep({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSpacing.lg),
      child: _buildDepartureStep(context),
    );
  }

  Widget _buildDepartureStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sélectionnez votre point de départ',
          style: TTypography.headingMedium(context),
        ),

        const SizedBox(height: TSpacing.sm),

        Text(
          'Choisissez un endroit parmi les points de repères populaires à Dakar',
          style: TTypography.bodyMedium(
            context,
          ).copyWith(color: TColors.textSecondary(context)),
        ),

        const SizedBox(height: TSpacing.md),

        // Selected departure point indicator
        Obx(
          () =>
              controller.departurePoint.value != null
                  ? Container(
                    margin: const EdgeInsets.only(bottom: TSpacing.md),
                    padding: const EdgeInsets.all(TSpacing.md),
                    decoration: BoxDecoration(
                      color: TColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(TRadius.lg),
                      border: Border.all(
                        color: TColors.primary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(TSpacing.sm),
                          decoration: const BoxDecoration(
                            color: TColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: TSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Point de départ sélectionné',
                                style: TTypography.labelSmall(context).copyWith(
                                  color: TColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                controller.departurePoint.value ?? '',
                                style: TTypography.bodyMedium(
                                  context,
                                ).copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              controller.departurePoint.value = null;
                              HapticFeedback.lightImpact();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                color: TColors.primary.withOpacity(0.7),
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  : const SizedBox.shrink(),
        ),

        // Search field with enhanced styling
        Container(
          decoration: BoxDecoration(
            color: TColors.surface(context),
            borderRadius: BorderRadius.circular(TRadius.lg),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: TColors.neutral300.withOpacity(0.5)),
          ),
          child: TextField(
            onChanged: (value) {
              // controller.searchDepartureLandmarks(value);
            },
            decoration: InputDecoration(
              hintText: 'Rechercher un lieu de départ',
              hintStyle: TextStyle(
                color: TColors.textSecondary(context).withOpacity(0.7),
                fontSize: 15,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.search_rounded,
                  color: TColors.textSecondary(context).withOpacity(0.6),
                  size: 20,
                ),
              ),
              suffixIcon: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    HapticFeedback.mediumImpact();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.mic_rounded,
                      color: TColors.primary.withOpacity(0.8),
                      size: 20,
                    ),
                  ),
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: TSpacing.md,
                vertical: TSpacing.md + 2,
              ),
            ),
          ),
        ),

        const SizedBox(height: TSpacing.lg),

        // Modern card-based locations list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: TSpacing.xl),
            itemCount: controller.dakarLandmarks.length,
            separatorBuilder:
                (context, index) => const SizedBox(height: TSpacing.sm),
            itemBuilder: (context, index) {
              final landmark = controller.dakarLandmarks[index];

              return Obx(() {
                final isSelected = controller.departurePoint.value == landmark;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? TColors.primary.withOpacity(0.08)
                            : TColors.surface(context),
                    borderRadius: BorderRadius.circular(TRadius.md),
                    border: Border.all(
                      color:
                          isSelected
                              ? TColors.primary.withOpacity(0.3)
                              : TColors.neutral300.withOpacity(0.3),
                      width: isSelected ? 1.5 : 1,
                    ),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: TColors.primary.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      else
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(TRadius.md),
                      onTap: () {
                        controller.departurePoint.value = landmark;
                        HapticFeedback.mediumImpact();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(TSpacing.md),
                        child: Row(
                          children: [
                            // Icon container with animation
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? TColors.primary
                                        : TColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: Icon(
                                  isSelected
                                      ? Icons.check_rounded
                                      : Icons.location_on_rounded,
                                  key: ValueKey(isSelected),
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : TColors.primary,
                                  size: 18,
                                ),
                              ),
                            ),

                            const SizedBox(width: TSpacing.md),

                            // Location name
                            Expanded(
                              child: Text(
                                landmark,
                                style: TTypography.bodyMedium(context).copyWith(
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                  color:
                                      isSelected
                                          ? TColors.primary.withOpacity(0.9)
                                          : TColors.textPrimary(context),
                                  fontSize: 15,
                                ),
                              ),
                            ),

                            // Subtle arrow or checkmark
                            AnimatedRotation(
                              duration: const Duration(milliseconds: 200),
                              turns: isSelected ? 0.25 : 0,
                              child: Icon(
                                isSelected
                                    ? Icons.arrow_forward_rounded
                                    : Icons.arrow_forward_ios_rounded,
                                color:
                                    isSelected
                                        ? TColors.primary.withOpacity(0.7)
                                        : TColors.neutral400.withOpacity(0.6),
                                size: isSelected ? 20 : 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ],
    );
  }
}
