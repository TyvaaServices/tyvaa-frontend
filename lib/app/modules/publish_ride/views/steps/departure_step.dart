import 'package:flutter/material.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/controllers/publish_ride_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

class DepartureStep extends StatelessWidget {
  final PublishRideController controller;

  const DepartureStep({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSpacing.lg),
      child: Column(
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

          const SizedBox(height: TSpacing.xl),

          // Landmark search field
          Container(
            decoration: BoxDecoration(
              color: TColors.surface(context),
              borderRadius: TRadius.inputRadius,
              boxShadow: TShadows.subtle,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un lieu',
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

          const SizedBox(height: TSpacing.lg),

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

                  return ListTile(
                    title: Text(
                      landmark,
                      style: TTypography.bodyMedium(context),
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(TSpacing.sm),
                      decoration: BoxDecoration(
                        color: TColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on_outlined,
                        color: TColors.primary,
                      ),
                    ),
                    trailing:
                        controller.departurePoint.value == landmark
                            ? const Icon(
                              Icons.check_circle,
                              color: TColors.primary,
                            )
                            : null,
                    onTap: () {
                      controller.departurePoint.value = landmark;
                    },
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: TSpacing.md,
                      vertical: TSpacing.sm,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TRadius.md),
                    ),
                    tileColor:
                        controller.departurePoint.value == landmark
                            ? TColors.primary.withOpacity(0.05)
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
