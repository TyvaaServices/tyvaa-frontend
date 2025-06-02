import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:passenger_tyvaa/app/modules/ride_search/controllers/ride_search_controller.dart';
import 'package:passenger_tyvaa/app/modules/ride_search/views/ride_details_view.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

import '../bindings/ride_search_binding.dart';

class RideSearchView extends StatelessWidget {
  final RideSearchController controller = Get.put(RideSearchController());

  RideSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      appBar: AppBar(
        title: Text(
          'Rechercher un trajet',
          style: TTypography.headingMedium(context),
        ),
        elevation: 0,
        backgroundColor: TColors.background(context),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: TColors.textPrimary(context)),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () =>
              controller.hasSearched.value
                  ? _buildSearchResults(context)
                  : _buildSearchForm(context),
        ),
      ),
    );
  }

  Widget _buildSearchForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Intro text
          Text(
            'Où souhaitez-vous aller?',
            style: TTypography.headingLarge(context),
          ),

          const SizedBox(height: TSpacing.sm),

          Text(
            'Trouvez des trajets partagés à Dakar',
            style: TTypography.bodyMedium(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
          ),

          const SizedBox(height: TSpacing.xl),

          // Departure point selection
          _buildPointSelection(
            context,
            title: 'Point de départ',
            hint: 'D\'où partez-vous?',
            icon: Icons.trip_origin,
            iconColor: TColors.primary,
            selectedValue: controller.departurePoint,
            onTap:
                () => _showLandmarkSelection(
                  context,
                  'Choisir un point de départ',
                  controller.departurePoint,
                ),
          ),

          const SizedBox(height: TSpacing.lg),

          // Destination selection
          _buildPointSelection(
            context,
            title: 'Destination',
            hint: 'Où allez-vous?',
            icon: Icons.location_on,
            iconColor: TColors.accent,
            selectedValue: controller.arrivalPoint,
            onTap:
                () => _showLandmarkSelection(
                  context,
                  'Choisir une destination',
                  controller.arrivalPoint,
                  exclude: controller.departurePoint.value,
                ),
          ),

          const SizedBox(height: TSpacing.lg),

          // Date selection
          // _buildDateSelection(context),
          const SizedBox(height: TSpacing.xxl),

          // Search button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: controller.searchRides,
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: TRadius.buttonRadius,
                ),
                elevation: 0,
              ),
              child: Text('Rechercher', style: TTextStyles.buttonStatic),
            ),
          ),

          const SizedBox(height: TSpacing.xl),

          // Recent searches (can be expanded in the future)
          Text('Recherches récentes', style: TTypography.headingSmall(context)),

          const SizedBox(height: TSpacing.md),

          _buildRecentSearchItem(
            context,
            departure: 'UCAD',
            arrival: 'Almadies',
            onTap: () {
              controller.departurePoint.value = 'UCAD';
              controller.arrivalPoint.value = 'Almadies';
            },
          ),

          _buildRecentSearchItem(
            context,
            departure: 'Médina',
            arrival: 'Pikine',
            onTap: () {
              controller.departurePoint.value = 'Médina';
              controller.arrivalPoint.value = 'Pikine';
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPointSelection(
    BuildContext context, {
    required String title,
    required String hint,
    required IconData icon,
    required Color iconColor,
    required Rx<String?> selectedValue,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(TSpacing.md),
        decoration: BoxDecoration(
          color: TColors.surface(context),
          borderRadius: TRadius.cardRadius,
          boxShadow: TShadows.subtle,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(TSpacing.sm),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor),
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
                  const SizedBox(height: 4),
                  Obx(
                    () => Text(
                      selectedValue.value ?? hint,
                      style:
                          selectedValue.value != null
                              ? TTypography.bodyMedium(context)
                              : TTypography.bodyMedium(
                                context,
                              ).copyWith(color: TColors.textSecondary(context)),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: TColors.textSecondary(context),
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(TSpacing.sm),
              decoration: BoxDecoration(
                color: TColors.info.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.calendar_today, color: TColors.info),
            ),
            const SizedBox(width: TSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: TTypography.labelSmall(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                  const SizedBox(height: 4),
                  Obx(
                    () => Text(
                      controller.searchDate.value != null
                          ? DateFormat(
                            'EEEE d MMMM yyyy',
                            'fr_FR',
                          ).format(controller.searchDate.value!)
                          : "Aujourd'hui ou une date ultérieure",
                      style:
                          controller.searchDate.value != null
                              ? TTypography.bodyMedium(context)
                              : TTypography.bodyMedium(
                                context,
                              ).copyWith(color: TColors.textSecondary(context)),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: TColors.textSecondary(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearchItem(
    BuildContext context, {
    required String departure,
    required String arrival,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: TSpacing.sm),
        padding: const EdgeInsets.all(TSpacing.md),
        decoration: BoxDecoration(
          color: TColors.surface(context).withOpacity(0.7),
          borderRadius: TRadius.cardRadius,
          border: Border.all(color: TColors.neutral300, width: 1),
        ),
        child: Row(
          children: [
            Icon(
              Icons.history,
              color: TColors.textSecondary(context),
              size: 20,
            ),
            const SizedBox(width: TSpacing.md),
            Expanded(
              child: Text(
                '$departure → $arrival',
                style: TTypography.bodyMedium(context),
              ),
            ),
            Icon(Icons.north_west, color: TColors.primary, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    return Obx(() {
      if (controller.isSearching.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: TColors.primary),
              const SizedBox(height: TSpacing.md),
              Text(
                'Recherche en cours...',
                style: TTypography.bodyMedium(context),
              ),
            ],
          ),
        );
      }

      if (controller.searchResults.isEmpty) {
        return _buildNoResultsFound(context);
      }

      return Stack(
        children: [
          // Search results list
          ListView(
            padding: const EdgeInsets.all(TSpacing.lg),
            children: [
              // Search summary
              _buildSearchSummary(context),

              const SizedBox(height: TSpacing.lg),

              // Results count
              Text(
                '${controller.searchResults.length} trajets trouvés',
                style: TTypography.bodyMedium(
                  context,
                ).copyWith(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: TSpacing.md),

              // Results list
              ...controller.searchResults.map(
                (ride) => _buildRideItem(context, ride),
              ),

              // Bottom padding for floating button
              const SizedBox(height: 80),
            ],
          ),

          // New search floating button
          Positioned(
            bottom: TSpacing.lg,
            right: TSpacing.lg,
            child: FloatingActionButton(
              onPressed: controller.resetSearch,
              backgroundColor: TColors.surface(context),
              child: Icon(Icons.search, color: TColors.primary),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSearchSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TSpacing.md),
      decoration: BoxDecoration(
        color: TColors.primary.withOpacity(0.1),
        borderRadius: TRadius.cardRadius,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.trip_origin, color: TColors.primary, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        controller.departurePoint.value ?? '',
                        style: TTypography.bodyMedium(
                          context,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    width: 1,
                    height: 20,
                    color: TColors.primary.withOpacity(0.3),
                  ),
                ),

                Row(
                  children: [
                    Icon(Icons.location_on, color: TColors.accent, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        controller.arrivalPoint.value ?? '',
                        style: TTypography.bodyMedium(
                          context,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: TSpacing.md),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: TSpacing.md,
              vertical: TSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: TColors.surface(context),
              borderRadius: TRadius.chipRadius,
              border: Border.all(color: TColors.neutral300, width: 1),
            ),
            child: Obx(
              () => Text(
                controller.searchDate.value != null
                    ? DateFormat(
                      'dd/MM/yyyy',
                      'fr_FR',
                    ).format(controller.searchDate.value!)
                    : "Aujourd'hui",
                style: TTypography.labelMedium(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideItem(BuildContext context, RideSearchModel ride) {
    return InkWell(
      onTap: () {
        controller.selectRide(ride);
        // Use a more direct navigation approach
        Get.to(() => RideDetailsView(), binding: RideSearchBinding());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: TSpacing.md),
        decoration: BoxDecoration(
          color: TColors.surface(context),
          borderRadius: TRadius.cardRadius,
          boxShadow: TShadows.subtle,
        ),
        child: Column(
          children: [
            // Ride info section
            Padding(
              padding: const EdgeInsets.all(TSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Route and time info
                  Row(
                    children: [
                      // Time info
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSpacing.md,
                          vertical: TSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: TColors.primary.withOpacity(0.1),
                          borderRadius: TRadius.cardRadius,
                        ),
                        child: Text(
                          '${ride.departureTime.hour.toString().padLeft(2, '0')}:${ride.departureTime.minute.toString().padLeft(2, '0')}',
                          style: TTypography.headingSmall(
                            context,
                          ).copyWith(color: TColors.primary),
                        ),
                      ),

                      const SizedBox(width: TSpacing.md),

                      // Route info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ride.departurePoint,
                              style: TTypography.bodyMedium(
                                context,
                              ).copyWith(fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 1,
                                  color: TColors.textSecondary(context),
                                ),
                                const Icon(Icons.arrow_right_alt, size: 16),
                              ],
                            ),

                            Text(
                              ride.arrivalPoint,
                              style: TTypography.bodyMedium(
                                context,
                              ).copyWith(fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Price tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSpacing.md,
                          vertical: TSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: TColors.success.withOpacity(0.1),
                          borderRadius: TRadius.cardRadius,
                        ),
                        child: Text(
                          '${ride.price.toInt()} FCFA',
                          style: TTypography.labelLarge(context).copyWith(
                            color: TColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: TSpacing.md),

                  // Date info and recurring badge
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: TColors.textSecondary(context),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        DateFormat(
                          'EEEE d MMMM',
                          'fr_FR',
                        ).format(ride.departureDate),
                        style: TTypography.bodySmall(
                          context,
                        ).copyWith(color: TColors.textSecondary(context)),
                      ),

                      if (ride.isRecurring) ...[
                        const SizedBox(width: TSpacing.md),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: TColors.info.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(TRadius.pill),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.repeat, size: 12, color: TColors.info),
                              const SizedBox(width: 4),
                              Text(
                                'Récurrent',
                                style: TTypography.labelSmall(
                                  context,
                                ).copyWith(color: TColors.info),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Divider
            Divider(
              height: 1,
              thickness: 1,
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? TColors.neutral800
                      : TColors.neutral200,
            ),

            // Chauffeur info
            Padding(
              padding: const EdgeInsets.all(TSpacing.md),
              child: Row(
                children: [
                  // Chauffeur image
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: TColors.primary.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        ride.chauffeurImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: TSpacing.md),

                  // Chauffeur name and rating
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ride.chauffeurName,
                          style: TTypography.bodyMedium(context),
                        ),

                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              ride.chauffeurRating.toString(),
                              style: TTypography.bodySmall(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Available seats
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSpacing.md,
                      vertical: TSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: TColors.surface(context),
                      borderRadius: TRadius.cardRadius,
                      border: Border.all(color: TColors.neutral300, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.airline_seat_recline_normal,
                          size: 16,
                          color: TColors.textSecondary(context),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${ride.availableSeats} place${ride.availableSeats > 1 ? 's' : ''}',
                          style: TTypography.labelMedium(context),
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
    );
  }

  Widget _buildNoResultsFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: TColors.neutral400),
          const SizedBox(height: TSpacing.md),
          Text(
            'Aucun trajet trouvé',
            style: TTypography.headingMedium(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSpacing.sm),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSpacing.xl),
            child: Text(
              'Nous n\'avons pas trouvé de trajets correspondant à votre recherche. Veuillez essayer avec d\'autres critères.',
              style: TTypography.bodyMedium(
                context,
              ).copyWith(color: TColors.textSecondary(context)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: TSpacing.xl),
          TextButton.icon(
            onPressed: controller.resetSearch,
            icon: const Icon(Icons.refresh),
            label: const Text('Nouvelle recherche'),
            style: TextButton.styleFrom(foregroundColor: TColors.primary),
          ),
        ],
      ),
    );
  }

  // Helper methods
  Future<void> _showLandmarkSelection(
    BuildContext context,
    String title,
    Rx<String?> selectedValue, {
    String? exclude,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: TColors.surface(context),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(TRadius.xl),
              ),
            ),
            child: Column(
              children: [
                // Handle
                Container(
                  margin: const EdgeInsets.only(top: TSpacing.md),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: TColors.neutral400,
                    borderRadius: BorderRadius.circular(TRadius.pill),
                  ),
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.all(TSpacing.lg),
                  child: Text(title, style: TTypography.headingMedium(context)),
                ),

                // Search field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSpacing.lg),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher un lieu',
                      prefixIcon: Icon(
                        Icons.search,
                        color: TColors.textSecondary(context),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: TRadius.inputRadius,
                        borderSide: BorderSide(color: TColors.neutral300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: TRadius.inputRadius,
                        borderSide: BorderSide(color: TColors.neutral300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: TRadius.inputRadius,
                        borderSide: BorderSide(color: TColors.primary),
                      ),
                      filled: true,
                      fillColor: TColors.surface(context),
                    ),
                  ),
                ),

                const SizedBox(height: TSpacing.md),

                // Landmark list
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSpacing.lg,
                    ),
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

                      // Skip the excluded landmark (e.g., already selected departure point)
                      if (landmark == exclude) {
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
                            color: TColors.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.location_on_outlined,
                            color: TColors.primary,
                          ),
                        ),
                        onTap: () {
                          selectedValue.value = landmark;
                          Get.back();
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: TSpacing.md,
                          vertical: TSpacing.sm,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final initialDate = controller.searchDate.value ?? now;
    final firstDate = now;
    final lastDate = now.add(const Duration(days: 30));

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: const Locale('fr', 'FR'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: TColors.primary,
              onPrimary: Colors.white,
              onSurface: TColors.neutral900,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      controller.searchDate.value = selectedDate;
    }
  }
}
