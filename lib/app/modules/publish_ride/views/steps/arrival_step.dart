import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/controllers/publish_ride_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

class ArrivalStep extends StatelessWidget {
  final PublishRideController controller;

  const ArrivalStep({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sélectionnez votre destination',
            style: TTypography.headingMedium(context),
          ),

          const SizedBox(height: TSpacing.sm),

          Text(
            'Où allez-vous à Dakar?',
            style: TTypography.bodyMedium(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
          ),

          const SizedBox(height: TSpacing.xl),

          // Selected departure point
          Container(
            padding: const EdgeInsets.all(TSpacing.md),
            decoration: BoxDecoration(
              color: TColors.primary.withOpacity(0.1),
              borderRadius: TRadius.cardRadius,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(TSpacing.sm),
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.2),
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
                        'Point de départ',
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
          ),

          const SizedBox(height: TSpacing.md),

          // Landmark search field
          Container(
            decoration: BoxDecoration(
              color: TColors.surface(context),
              borderRadius: TRadius.inputRadius,
              boxShadow: TShadows.subtle,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher une destination',
                prefixIcon: Icon(
                  Icons.search,
                  color: TColors.textSecondary(context),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: TSpacing.md,
                  vertical: TSpacing.md,
                ),
              ),
            ),
          ),

          const SizedBox(height: TSpacing.md),

          // Popular landmarks list
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: TColors.surface(context),
                borderRadius: TRadius.cardRadius,
                boxShadow: TShadows.subtle,
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView.separated(
                padding: const EdgeInsets.all(TSpacing.sm),
                itemCount: controller.dakarLandmarks.length,
                separatorBuilder:
                    (context, index) => Divider(
                      height: 1,
                      thickness: 1,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? TColors.neutral800
                              : TColors.neutral200,
                    ),
                itemBuilder: (context, index) {
                  final landmark = controller.dakarLandmarks[index];

                  // Don't show the departure point in the arrival options
                  if (landmark == controller.departurePoint.value) {
                    return const SizedBox.shrink();
                  }

                  return ListTile(
                    title: Text(
                      landmark,
                      style: TTypography.bodyMedium(context),
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(TSpacing.sm),
                      decoration: BoxDecoration(
                        color: TColors.accent.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on_outlined,
                        color: TColors.accent,
                      ),
                    ),
                    trailing:
                        controller.arrivalPoint.value == landmark
                            ? const Icon(
                              Icons.check_circle,
                              color: TColors.accent,
                            )
                            : null,
                    onTap: () {
                      controller.arrivalPoint.value = landmark;
                    },
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: TSpacing.md,
                      vertical: TSpacing.sm,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TRadius.md),
                    ),
                    tileColor:
                        controller.arrivalPoint.value == landmark
                            ? TColors.accent.withOpacity(0.05)
                            : Colors.transparent,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
