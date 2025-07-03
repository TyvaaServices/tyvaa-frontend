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
      body: SafeArea(
        child: Obx(
          () => controller.hasSearched.value
              ? _buildSearchResults(context)
              : _buildSearchForm(context),
        ),
      ),
    );
  }

  Widget _buildSearchForm(BuildContext context) {
    return Column(
      children: [
        // Clean header
        _buildCleanHeader(context),
        
        // Main search content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome text
                Text(
                  'Où souhaitez-vous aller?',
                  style: TTypography.headingLarge(context).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Trouvez des trajets partagés à Dakar',
                  style: TTypography.bodyMedium(context).copyWith(
                    color: TColors.textSecondary(context),
                  ),
                ),

                const SizedBox(height: 32),

                // Search form - clean design
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: TColors.surface(context),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: TColors.neutral300.withOpacity(0.3),
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      // From field
                      _buildLocationField(
                        context,
                        title: 'Départ',
                        icon: Icons.trip_origin,
                        hintText: 'Où partez-vous?',
                        value: controller.departurePoint.value,
                        onChanged: (value) => controller.departurePoint.value = value,
                        iconColor: TColors.primary,
                      ),

                      const SizedBox(height: 20),

                      // To field
                      _buildLocationField(
                        context,
                        title: 'Destination',
                        icon: Icons.location_on,
                        hintText: 'Où allez-vous?',
                        value: controller.arrivalPoint.value,
                        onChanged: (value) => controller.arrivalPoint.value = value,
                        iconColor: TColors.accent,
                      ),

                      const SizedBox(height: 20),

                      // Date field
                      _buildDateField(context),

                      const SizedBox(height: 32),

                      // Search button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: controller.searchRides,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.search, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Rechercher',
                                style: TTypography.bodyMedium(context).copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCleanHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        border: Border(
          bottom: BorderSide(
            color: TColors.neutral300.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: TColors.neutral200.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: TColors.textPrimary(context),
                size: 18,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Rechercher un trajet',
            style: TTypography.headingMedium(context).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationField(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String hintText,
    required String? value,
    required Function(String?) onChanged,
    required Color iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: TTypography.labelMedium(context).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TTypography.bodyMedium(context).copyWith(
              color: TColors.textSecondary(context),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: TColors.neutral300.withOpacity(0.5),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: TColors.neutral300.withOpacity(0.5),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: TColors.primary,
                width: 1.5,
              ),
            ),
            filled: true,
            fillColor: TColors.surface(context),
            contentPadding: const EdgeInsets.all(16),
          ),
          items: controller.dakarLandmarks
              .map((landmark) => DropdownMenuItem(
                    value: landmark,
                    child: Text(landmark),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today, size: 16, color: TColors.info),
            const SizedBox(width: 8),
            Text(
              'Date',
              style: TTypography.labelMedium(context).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Obx(() => TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Sélectionner une date',
            hintStyle: TTypography.bodyMedium(context).copyWith(
              color: TColors.textSecondary(context),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: TColors.neutral300.withOpacity(0.5),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: TColors.neutral300.withOpacity(0.5),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: TColors.primary,
                width: 1.5,
              ),
            ),
            filled: true,
            fillColor: TColors.surface(context),
            contentPadding: const EdgeInsets.all(16),
            suffixIcon: Icon(Icons.arrow_drop_down, color: TColors.textSecondary(context)),
          ),
          controller: TextEditingController(
            text: controller.searchDate.value != null
                ? DateFormat('EEEE d MMMM', 'fr_FR').format(controller.searchDate.value!)
                : null,
          ),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
            );
            if (date != null) {
              controller.searchDate.value = date;
            }
          },
        )),
      ],
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
              const SizedBox(height: 16),
              Text(
                'Recherche en cours...',
                style: TTypography.bodyMedium(context),
              ),
            ],
          ),
        );
      }

      if (controller.filteredResults.isEmpty) {
        return _buildNoResultsFound(context);
      }

      return Column(
        children: [
          // Clean header with filters
          _buildCleanResultsHeader(context),
          
          // Results list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              children: [
                const SizedBox(height: 16),
                
                // Results count
                Text(
                  '${controller.filteredResults.length} trajet${controller.filteredResults.length > 1 ? 's' : ''} trouvé${controller.filteredResults.length > 1 ? 's' : ''}',
                  style: TTypography.bodyMedium(context).copyWith(
                    color: TColors.textSecondary(context),
                  ),
                ),

                const SizedBox(height: 20),

                // Clean results list
                ...controller.filteredResults.map(
                  (ride) => _buildCleanRideCard(context, ride),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildCleanResultsHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        border: Border(
          bottom: BorderSide(
            color: TColors.neutral300.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          // Simple header with back button and title
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: TColors.neutral200.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: TColors.textPrimary(context),
                    size: 18,
                  ),
                  onPressed: controller.resetSearch,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Résultats',
                  style: TTypography.headingMedium(context).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: controller.resetSearch,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Modifier',
                  style: TTypography.bodySmall(context).copyWith(
                    color: TColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Simple route summary
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: TColors.neutral200.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trip_origin,
                  size: 16,
                  color: TColors.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    controller.departurePoint.value ?? '',
                    style: TTypography.bodySmall(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 14,
                  color: TColors.textSecondary(context),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    controller.arrivalPoint.value ?? '',
                    style: TTypography.bodySmall(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: TColors.accent,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Clean filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  context,
                  label: "Aujourd'hui",
                  isSelected: controller.selectedDateFilter.value == 'today',
                  onTap: () => controller.setDateFilter('today'),
                ),
                const SizedBox(width: 12),
                _buildFilterChip(
                  context,
                  label: 'Cette semaine',
                  isSelected: controller.selectedDateFilter.value == 'week',
                  onTap: () => controller.setDateFilter('week'),
                ),
                const SizedBox(width: 12),
                _buildFilterChip(
                  context,
                  label: 'Prix ↑',
                  isSelected: controller.selectedSortFilter.value == 'price_asc',
                  onTap: () => controller.setSortFilter('price_asc'),
                ),
                const SizedBox(width: 12),
                _buildFilterChip(
                  context,
                  label: 'Heure ↑',
                  isSelected: controller.selectedSortFilter.value == 'time_asc',
                  onTap: () => controller.setSortFilter('time_asc'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? TColors.primary
              : TColors.neutral200.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? null
              : Border.all(
                  color: TColors.neutral300.withOpacity(0.5),
                  width: 0.5,
                ),
        ),
        child: Text(
          label,
          style: TTypography.labelMedium(context).copyWith(
            color: isSelected
                ? Colors.white
                : TColors.textSecondary(context),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCleanRideCard(BuildContext context, RideSearchModel ride) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TColors.neutral300.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: () {
          controller.selectRide(ride);
          Get.to(() => RideDetailsView(), binding: RideSearchBinding());
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Header: Time and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Time
                Text(
                  '${ride.departureTime.hour.toString().padLeft(2, '0')}:${ride.departureTime.minute.toString().padLeft(2, '0')}',
                  style: TTypography.headingMedium(context).copyWith(
                    fontWeight: FontWeight.w700,
                    color: TColors.primary,
                  ),
                ),
                // Price
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: TColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${ride.price.toInt()} FCFA',
                    style: TTypography.bodyMedium(context).copyWith(
                      color: TColors.success,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Route
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: TColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              ride.departurePoint,
                              style: TTypography.bodyMedium(context).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: TColors.accent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              ride.arrivalPoint,
                              style: TTypography.bodyMedium(context).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Driver and details
            Row(
              children: [
                // Driver avatar
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: TColors.primary.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      ride.chauffeurImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Driver name and rating
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ride.chauffeurName,
                        style: TTypography.bodySmall(context).copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 12,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            ride.chauffeurRating.toString(),
                            style: TTypography.labelSmall(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Available seats
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: TColors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${ride.availableSeats} place${ride.availableSeats > 1 ? 's' : ''}',
                    style: TTypography.labelSmall(context).copyWith(
                      color: TColors.info,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultsFound(BuildContext context) {
    return Column(
      children: [
        _buildCleanResultsHeader(context),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: TColors.neutral200.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.search_off,
                    size: 40,
                    color: TColors.textSecondary(context),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Aucun trajet trouvé',
                  style: TTypography.headingMedium(context).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Essayez de modifier vos critères de recherche',
                  style: TTypography.bodyMedium(context).copyWith(
                    color: TColors.textSecondary(context),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: controller.resetSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Nouvelle recherche',
                    style: TTypography.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
