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
        child: Obx(() {
          if (controller.isSearching.value) {
            return _buildSearchingState(context);
          }
          return controller.hasSearched.value
              ? _buildSearchResults(context)
              : _buildSearchForm(context);
        }),
      ),
    );
  }

  Widget _buildSearchForm(BuildContext context) {
    return Column(
      children: [
        // Modern search header
        _buildModernSearchHeader(context),

        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main search interface - Google/Uber style
                _buildMainSearchInterface(context),

                const SizedBox(height: 32),

                // Quick suggestions
                _buildQuickSuggestions(context),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernSearchHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 24,
        right: 24,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        boxShadow: [
          BoxShadow(
            color: TColors.neutral900.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Back button
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

              // Search icon and title
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.search, color: TColors.primary, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Rechercher un trajet',
                  style: TTypography.headingLarge(context).copyWith(
                    fontWeight: FontWeight.w700,
                    color: TColors.textPrimary(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 56), // Align with title
            child: Text(
              'Trouvez des trajets partagés rapidement',
              style: TTypography.bodyMedium(
                context,
              ).copyWith(color: TColors.textSecondary(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainSearchInterface(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: TColors.neutral900.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: TColors.neutral900.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Location inputs - Google Maps style
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // From location
                _buildSearchLocationField(
                  context,
                  icon: Icons.radio_button_checked,
                  iconColor: TColors.primary,
                  label: 'Départ',
                  value: controller.departurePoint.value,
                  placeholder: 'D\'où partez-vous ?',
                  onTap: () => _showLocationPicker(context, true),
                ),

                // Connector line and swap button
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      const SizedBox(width: 24),
                      Container(
                        width: 2,
                        height: 20,
                        decoration: BoxDecoration(
                          color: TColors.neutral300,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _swapLocations,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: TColors.neutral100,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: TColors.neutral300,
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.swap_vert,
                            color: TColors.primary,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                    ],
                  ),
                ),

                // To location
                _buildSearchLocationField(
                  context,
                  icon: Icons.location_on,
                  iconColor: TColors.error,
                  label: 'Destination',
                  value: controller.arrivalPoint.value,
                  placeholder: 'Où allez-vous ?',
                  onTap: () => _showLocationPicker(context, false),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: TColors.neutral200),
          ),

          // Date selection
          Padding(
            padding: const EdgeInsets.all(20),
            child: _buildSearchDateField(context),
          ),

          // Search button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: _buildModernSearchButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchLocationField(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String? value,
    required String placeholder,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              child: Icon(icon, color: iconColor, size: 16),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TTypography.labelSmall(context).copyWith(
                      color: TColors.textSecondary(context),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value ?? placeholder,
                    style: TTypography.bodyLarge(context).copyWith(
                      color:
                          value != null
                              ? TColors.textPrimary(context)
                              : TColors.textSecondary(context),
                      fontWeight:
                          value != null ? FontWeight.w600 : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (value != null)
              GestureDetector(
                onTap: () {
                  // Clear the field
                  if (label == 'Départ') {
                    controller.departurePoint.value = null;
                  } else {
                    controller.arrivalPoint.value = null;
                  }
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: TColors.neutral300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 12,
                    color: TColors.textSecondary(context),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchDateField(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => _showDatePicker(context),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              child: Icon(Icons.calendar_today, color: TColors.info, size: 16),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date de départ',
                    style: TTypography.labelSmall(context).copyWith(
                      color: TColors.textSecondary(context),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.searchDate.value != null
                        ? DateFormat(
                          'EEEE d MMMM yyyy',
                          'fr_FR',
                        ).format(controller.searchDate.value!)
                        : 'Aujourd\'hui',
                    style: TTypography.bodyLarge(context).copyWith(
                      color: TColors.textPrimary(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: TColors.textSecondary(context),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernSearchButton(BuildContext context) {
    return Obx(() {
      final canSearch =
          controller.departurePoint.value != null &&
          controller.arrivalPoint.value != null;

      return Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient:
              canSearch
                  ? LinearGradient(
                    colors: [TColors.primary, TColors.primaryLight],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                  : null,
          color: canSearch ? null : TColors.neutral300,
          boxShadow:
              canSearch
                  ? [
                    BoxShadow(
                      color: TColors.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: canSearch ? () => controller.searchRides() : null,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: Colors.white, size: 22),
                  const SizedBox(width: 12),
                  Text(
                    'Rechercher',
                    style: TTypography.bodyLarge(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildQuickSuggestions(BuildContext context) {
    final popularRoutes = [
      {'from': 'Plateau', 'to': 'Almadies', 'icon': Icons.business},
      {'from': 'HLM', 'to': 'UCAD', 'icon': Icons.school},
      {'from': 'Pikine', 'to': 'Sandaga', 'icon': Icons.shopping_bag},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trajets populaires',
          style: TTypography.headingSmall(
            context,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ...popularRoutes
            .map((route) => _buildQuickRouteCard(context, route))
            .toList(),
      ],
    );
  }

  Widget _buildQuickRouteCard(
    BuildContext context,
    Map<String, dynamic> route,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            controller.departurePoint.value = route['from'];
            controller.arrivalPoint.value = route['to'];
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: TColors.surface(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: TColors.neutral300.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(route['icon'], color: TColors.primary, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${route['from']} → ${route['to']}',
                    style: TTypography.bodyMedium(
                      context,
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: TColors.textSecondary(context),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSearches(BuildContext context) {
    // This would be populated from actual recent searches
    return Container(); // Placeholder for now
  }

  // Helper methods for enhanced UX
  void _swapLocations() {
    final temp = controller.departurePoint.value;
    controller.departurePoint.value = controller.arrivalPoint.value;
    controller.arrivalPoint.value = temp;
  }

  void _showLocationPicker(BuildContext context, bool isDeparture) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.8,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder:
                (context, scrollController) => Container(
                  decoration: BoxDecoration(
                    color: TColors.surface(context),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Handle bar
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: TColors.neutral400.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      // Header
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                isDeparture
                                    ? 'Choisir le départ'
                                    : 'Choisir la destination',
                                style: TTypography.headingMedium(
                                  context,
                                ).copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(
                                Icons.close,
                                color: TColors.textSecondary(context),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Search field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Rechercher un lieu...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: TColors.neutral300.withOpacity(0.3),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: TColors.neutral300.withOpacity(0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: TColors.primary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Location suggestions
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          padding: const EdgeInsets.all(20),
                          children: [
                            // Current location option
                            if (isDeparture)
                              _buildLocationOption(
                                context,
                                icon: Icons.my_location,
                                title: 'Ma position actuelle',
                                subtitle: 'Utiliser le GPS',
                                onTap: () {
                                  controller.departurePoint.value =
                                      'Position actuelle';
                                  Get.back();
                                },
                              ),

                            const SizedBox(height: 16),

                            Text(
                              'Lieux populaires',
                              style: TTypography.bodySmall(context).copyWith(
                                color: TColors.textSecondary(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Popular locations
                            ...controller.dakarLandmarks
                                .map(
                                  (location) => _buildLocationOption(
                                    context,
                                    icon: Icons.location_on,
                                    title: location,
                                    subtitle: 'Dakar, Sénégal',
                                    onTap: () {
                                      if (isDeparture) {
                                        controller.departurePoint.value =
                                            location;
                                      } else {
                                        controller.arrivalPoint.value =
                                            location;
                                      }
                                      Get.back();
                                    },
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  Widget _buildLocationOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: TColors.neutral300.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: TColors.primary, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TTypography.bodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      subtitle,
                      style: TTypography.bodySmall(
                        context,
                      ).copyWith(color: TColors.textSecondary(context)),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: TColors.textSecondary(context),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final initialDate = controller.searchDate.value ?? now;

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: TColors.primary,
              onPrimary: Colors.white,
              surface: TColors.surface(context),
              onSurface: TColors.textPrimary(context),
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

  Widget _buildSearchingState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: TColors.primary),
          const SizedBox(height: 16),
          Text('Recherche en cours...', style: TTypography.bodyMedium(context)),
        ],
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
                  style: TTypography.bodyMedium(
                    context,
                  ).copyWith(color: TColors.textSecondary(context)),
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
                  style: TTypography.headingMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: controller.resetSearch,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
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
                Icon(Icons.trip_origin, size: 16, color: TColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    controller.departurePoint.value ?? '',
                    style: TTypography.bodySmall(
                      context,
                    ).copyWith(fontWeight: FontWeight.w600),
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
                    style: TTypography.bodySmall(
                      context,
                    ).copyWith(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.location_on, size: 16, color: TColors.accent),
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
                  isSelected:
                      controller.selectedSortFilter.value == 'price_asc',
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
          color:
              isSelected
                  ? TColors.primary
                  : TColors.neutral200.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
          border:
              isSelected
                  ? null
                  : Border.all(
                    color: TColors.neutral300.withOpacity(0.5),
                    width: 0.5,
                  ),
        ),
        child: Text(
          label,
          style: TTypography.labelMedium(context).copyWith(
            color: isSelected ? Colors.white : TColors.textSecondary(context),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
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
                              style: TTypography.bodyMedium(
                                context,
                              ).copyWith(fontWeight: FontWeight.w600),
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
                        style: TTypography.bodySmall(
                          context,
                        ).copyWith(fontWeight: FontWeight.w500),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
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
                  style: TTypography.headingMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  'Essayez de modifier vos critères de recherche',
                  style: TTypography.bodyMedium(
                    context,
                  ).copyWith(color: TColors.textSecondary(context)),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
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
