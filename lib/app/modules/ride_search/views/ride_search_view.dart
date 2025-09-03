import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:passenger_tyvaa/app/modules/ride_search/controllers/ride_search_controller.dart';
import 'package:passenger_tyvaa/app/modules/ride_search/views/ride_details_view.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';
import 'package:passenger_tyvaa/domain/entities/ride_instance.dart';

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
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Simple header with back button
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Simple back button
                Container(
                  decoration: BoxDecoration(
                    color: TColors.surface(context),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: TColors.neutral900.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: TColors.primary,
                    ),
                    splashRadius: 24,
                  ),
                ),

                const SizedBox(height: 24),

                // Clean title
                Text(
                  'Rechercher un trajet',
                  style: TTypography.displaySmall(
                    context,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'Trouvez le trajet parfait pour votre destination',
                  style: TTypography.bodyLarge(
                    context,
                  ).copyWith(color: TColors.textSecondary(context)),
                ),
              ],
            ),
          ),
        ),

        // Search form content
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Search card
              _buildSearchCard(context),

              const SizedBox(height: 32),

              // Quick access section
              _buildQuickAccessSection(context),

              const SizedBox(height: 32),

              // Popular routes
              _buildPopularRoutesSection(context),

              const SizedBox(height: 100),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: TColors.neutral900.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Location inputs
            _buildLocationInputs(context),

            const SizedBox(height: 20),

            // Date selector
            _buildDateSelector(context),

            const SizedBox(height: 24),

            // Search button
            _buildSearchButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInputs(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.background(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TColors.neutral300.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Departure
          _buildLocationField(
            context,
            icon: Icons.radio_button_checked,
            iconColor: TColors.primary,
            label: 'Départ',
            value: controller.departurePoint.value,
            placeholder: 'D\'où partez-vous ?',
            onTap: () => _showLocationPicker(context, true),
          ),

          // Swap button
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 1,
                  color: TColors.neutral300.withOpacity(0.3),
                ),
                GestureDetector(
                  onTap: _swapLocations,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: TColors.surface(context),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: TColors.neutral300.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.swap_vert,
                      color: TColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Destination
          _buildLocationField(
            context,
            icon: Icons.location_on,
            iconColor: TColors.accent,
            label: 'Destination',
            value: controller.destinationPoint.value,
            placeholder: 'Où allez-vous ?',
            onTap: () => _showLocationPicker(context, false),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationField(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String? value,
    required String placeholder,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TTypography.labelMedium(context).copyWith(
                        color: TColors.textSecondary(context),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (value != null)
                GestureDetector(
                  onTap: () {
                    if (label == 'Départ') {
                      controller.departurePoint.value = null;
                    } else {
                      controller.destinationPoint.value = null;
                    }
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: TColors.neutral300.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 14,
                      color: TColors.textSecondary(context),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return Obx(
      () => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showDatePicker(context),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: TColors.background(context),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: TColors.neutral300.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: TColors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.calendar_today,
                    color: TColors.info,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date de départ',
                        style: TTypography.labelMedium(context).copyWith(
                          color: TColors.textSecondary(context),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return Obx(() {
      final canSearch =
          controller.departurePoint.value != null &&
          controller.destinationPoint.value != null;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient:
              canSearch
                  ? const LinearGradient(
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
                      blurRadius: 16,
                      offset: const Offset(0, 8),
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
                  Icon(
                    Icons.search,
                    color:
                        canSearch
                            ? Colors.white
                            : TColors.textSecondary(context),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Rechercher des trajets',
                    style: TTypography.bodyLarge(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color:
                          canSearch
                              ? Colors.white
                              : TColors.textSecondary(context),
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

  Widget _buildQuickAccessSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Accès rapide',
          style: TTypography.headingMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildQuickAccessCard(
                context,
                icon: Icons.my_location,
                title: 'Ma position',
                subtitle: 'Utiliser le GPS',
                color: TColors.primary,
                onTap: () {
                  controller.departurePoint.value = 'Position actuelle';
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildQuickAccessCard(
                context,
                icon: Icons.history,
                title: 'Récents',
                subtitle: 'Trajets récents',
                color: TColors.info,
                onTap: () {
                  // TODO: Show recent searches
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TColors.surface(context),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: TColors.neutral300.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TTypography.bodyMedium(
                  context,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TTypography.bodySmall(
                  context,
                ).copyWith(color: TColors.textSecondary(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularRoutesSection(BuildContext context) {
    final popularRoutes = [
      {
        'from': 'Plateau',
        'to': 'Almadies',
        'icon': Icons.business,
        'price': '1500',
      },
      {'from': 'HLM', 'to': 'UCAD', 'icon': Icons.school, 'price': '800'},
      {
        'from': 'Pikine',
        'to': 'Sandaga',
        'icon': Icons.shopping_bag,
        'price': '1200',
      },
      {
        'from': 'Yoff',
        'to': 'Plateau',
        'icon': Icons.flight_takeoff,
        'price': '2000',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trajets populaires',
          style: TTypography.headingMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        ...popularRoutes.map((route) => _buildPopularRouteCard(context, route)),
      ],
    );
  }

  Widget _buildPopularRouteCard(
    BuildContext context,
    Map<String, dynamic> route,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            controller.departurePoint.value = route['from'];
            controller.destinationPoint.value = route['to'];
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: TColors.surface(context),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: TColors.neutral300.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(route['icon'], color: TColors.primary, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${route['from']} → ${route['to']}',
                        style: TTypography.bodyLarge(
                          context,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'À partir de ${route['price']} FCFA',
                        style: TTypography.bodySmall(context).copyWith(
                          color: TColors.success,
                          fontWeight: FontWeight.w500,
                        ),
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
      ),
    );
  }

  void _swapLocations() {
    final temp = controller.departurePoint.value;
    controller.departurePoint.value = controller.destinationPoint.value;
    controller.destinationPoint.value = temp;
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
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Handle
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
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                isDeparture
                                    ? 'Choisir le départ'
                                    : 'Choisir la destination',
                                style: TTypography.headingMedium(
                                  context,
                                ).copyWith(fontWeight: FontWeight.w700),
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
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Rechercher un lieu...',
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: TColors.background(context),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),

                      // Location list
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          padding: const EdgeInsets.all(24),
                          children: [
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

                            ...controller.popularLocations.value.map(
                              (location) => _buildLocationOption(
                                context,
                                icon: Icons.location_on,
                                title: location,
                                subtitle: 'Dakar, Sénégal',
                                onTap: () {
                                  if (isDeparture) {
                                    controller.departurePoint.value = location;
                                  } else {
                                    controller.destinationPoint.value =
                                        location;
                                  }
                                  Get.back();
                                },
                              ),
                            ),
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
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: TColors.primary, size: 24),
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [TColors.primary, TColors.primaryLight],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Recherche en cours...',
                    style: TTypography.headingSmall(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nous cherchons les meilleurs trajets pour vous',
                    style: TTypography.bodyMedium(
                      context,
                    ).copyWith(color: Colors.white.withOpacity(0.9)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    return Obx(() {
      if (controller.searchResults.isEmpty) {
        return _buildNoResults(context);
      }

      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Results header
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: TColors.surface(context),
                boxShadow: [
                  BoxShadow(
                    color: TColors.neutral900.withOpacity(0.05),
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
                      Container(
                        decoration: BoxDecoration(
                          color: TColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () => controller.resetSearch(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: TColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Résultats de recherche',
                          style: TTypography.headingMedium(
                            context,
                          ).copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: TColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: TColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.departurePoint.value ?? '',
                            style: TTypography.bodyMedium(
                              context,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.arrow_forward, size: 16),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.destinationPoint.value ?? '',
                            style: TTypography.bodyMedium(
                              context,
                            ).copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: TColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${controller.searchResults.length} trajet${controller.searchResults.length > 1 ? 's' : ''} trouvé${controller.searchResults.length > 1 ? 's' : ''}',
                    style: TTypography.bodyMedium(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                ],
              ),
            ),
          ),

          // Results list
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final ride = controller.searchResults[index];
                return _buildRideCard(context, ride);
              }, childCount: controller.searchResults.length),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildRideCard(BuildContext context, Rideinstance ride) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: TColors.neutral900.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            controller.selectRide(ride);
            Get.to(() => RideDetailsView(), binding: RideSearchBinding());
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Header with time and price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat(
                            'HH:mm',
                          ).format(DateTime.parse(ride.rideDate)),
                          style: TTypography.displaySmall(context).copyWith(
                            fontWeight: FontWeight.w800,
                            color: TColors.primary,
                          ),
                        ),
                        Text(
                          DateFormat(
                            'dd MMM',
                            'fr_FR',
                          ).format(DateTime.parse(ride.rideDate)),
                          style: TTypography.bodySmall(
                            context,
                          ).copyWith(color: TColors.textSecondary(context)),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            TColors.success,
                            TColors.success.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${ride.ride!.price.toInt()} FCFA',
                        style: TTypography.bodyLarge(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Route info
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _buildRoutePoint(
                            context,
                            color: TColors.primary,
                            text: ride.ride!.departure,
                          ),
                          Container(
                            width: 2,
                            height: 20,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: TColors.neutral300,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          _buildRoutePoint(
                            context,
                            color: TColors.accent,
                            text: ride.ride!.destination,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Driver info and seats
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: TColors.primary.withOpacity(0.2),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          ride.ride!.driver!.profileImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ride.ride!.driver!.fullName!,
                            style: TTypography.bodyMedium(
                              context,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                ride.ride!.driver!.driverProfile!.driverNote
                                    .toString(),
                                style: TTypography.bodySmall(context).copyWith(
                                  color: TColors.textSecondary(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: TColors.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.person,
                            color: TColors.info,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${ride.ride!.seatsAvailable}',
                            style: TTypography.bodySmall(context).copyWith(
                              color: TColors.info,
                              fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }

  Widget _buildRoutePoint(
    BuildContext context, {
    required Color color,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TTypography.bodyMedium(
              context,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildNoResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: TColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              Icons.search_off,
              size: 60,
              color: TColors.primary.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Aucun trajet trouvé',
            style: TTypography.headingMedium(
              context,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Text(
            'Essayez de modifier vos critères de recherche\nou créez une alerte pour ce trajet',
            style: TTypography.bodyMedium(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => controller.resetSearch(),
                icon: const Icon(Icons.refresh),
                label: const Text('Nouvelle recherche'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Create alert
                },
                icon: const Icon(Icons.notifications_active),
                label: const Text('Créer une alerte'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: TColors.primary,
                  side: const BorderSide(color: TColors.primary),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
