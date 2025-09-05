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
        SliverAppBar(
          pinned: true,
          backgroundColor: TColors.background(context),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: TColors.textPrimary(context)),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Rechercher un trajet',
            style: TTypography.headingMedium(context).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildSearchCard(context),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
        _buildPopularRoutesSection(context),
      ],
    );
  }

  Widget _buildSearchCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TColors.neutral300.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          _buildLocationInputs(context),
          Divider(height: 1, color: TColors.neutral300.withOpacity(0.5)),
          _buildDateSelector(context),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildSearchButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInputs(BuildContext context) {
    return Column(
      children: [
        _buildLocationField(
          context,
          icon: Icons.trip_origin,
          iconColor: TColors.primary,
          label: 'Départ',
          value: controller.departurePoint.value,
          placeholder: 'D\'où partez-vous ?',
          onTap: () => _showLocationPicker(context, true),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  height: 1,
                  color: TColors.neutral300.withOpacity(0.5),
                ),
              ),
              IconButton(
                icon: Icon(Icons.swap_vert, color: TColors.primary),
                onPressed: _swapLocations,
              ),
            ],
          ),
        ),
        _buildLocationField(
          context,
          icon: Icons.location_on_outlined,
          iconColor: TColors.accent,
          label: 'Destination',
          value: controller.destinationPoint.value,
          placeholder: 'Où allez-vous ?',
          onTap: () => _showLocationPicker(context, false),
        ),
      ],
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  value ?? placeholder,
                  style: TTypography.bodyLarge(context).copyWith(
                    color: value != null
                        ? TColors.textPrimary(context)
                        : TColors.textSecondary(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined, color: TColors.primary, size: 24), 
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    controller.searchDate.value != null
                        ? DateFormat('EEEE d MMMM yyyy', 'fr_FR')
                            .format(controller.searchDate.value!)
                        : 'Aujourd\'hui',
                    style: TTypography.bodyLarge(context).copyWith(
                      color: TColors.textPrimary(context),
                    ),
                  ),
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

      return ElevatedButton(
        onPressed: canSearch ? () => controller.searchRides() : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Rechercher',
          style: TTypography.bodyLarge(context).copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
    });
  }

  

  

  Widget _buildPopularRoutesSection(BuildContext context) {
    final popularRoutes = [
      {
        'from': 'Plateau',
        'to': 'Almadies',
        'icon': Icons.business,
        'price': '1500',
      },
      {
        'from': 'City A',
        'to': 'City B',
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

    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Trajets populaires',
            style: TTypography.headingMedium(context).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...popularRoutes.map((route) => _buildPopularRouteCard(context, route)),
      ]),
    );
  }

  Widget _buildPopularRouteCard(
    BuildContext context,
    Map<String, dynamic> route,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          controller.departurePoint.value = route['from'];
          controller.destinationPoint.value = route['to'];
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                      style: TTypography.bodyLarge(context).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'À partir de ${route['price']} FCFA',
                      style: TTypography.bodyMedium(context).copyWith(
                        color: TColors.textSecondary(context),
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

                            ...controller.popularLocations.map(
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
          SliverAppBar(
            pinned: true,
            backgroundColor: TColors.background(context),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: TColors.textPrimary(context)),
              onPressed: () => controller.resetSearch(),
            ),
            title: Column(
              children: [
                Text(
                  '${controller.departurePoint.value} → ${controller.destinationPoint.value}',
                  style: TTypography.bodyLarge(context).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${controller.searchResults.length} trajet${controller.searchResults.length > 1 ? 's' : ''} trouvé${controller.searchResults.length > 1 ? 's' : ''}',
                  style: TTypography.bodySmall(context).copyWith(
                    color: TColors.textSecondary(context),
                  ),
                ),
              ],
            ),
            centerTitle: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
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
    final profileImage = ride.ride?.driver?.profileImage;
    final driverNote = ride.ride?.driver?.driverProfile?.driverNote ?? 0.0;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: TColors.neutral300.withOpacity(0.5)),
      ),
      child: InkWell(
        onTap: () {
          controller.selectRide(ride);
          Get.to(() => RideDetailsView(), binding: RideSearchBinding());
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(DateTime.parse(ride.rideDate)),
                        style: TTypography.headingMedium(context).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        DateFormat('dd MMM', 'fr_FR').format(DateTime.parse(ride.rideDate)),
                        style: TTypography.bodySmall(context).copyWith(
                          color: TColors.textSecondary(context),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '${ride.ride?.price?.toInt() ?? 0} FCFA',
                    style: TTypography.headingMedium(context).copyWith(
                      fontWeight: FontWeight.w700,
                      color: TColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Column(
                    children: [
                      Icon(Icons.trip_origin, color: TColors.primary, size: 20),
                      Container(
                        width: 1,
                        height: 24,
                        color: TColors.neutral300,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      Icon(Icons.location_on, color: TColors.accent, size: 20),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ride.ride?.departure ?? 'Départ non spécifié',
                          style: TTypography.bodyMedium(context).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          ride.ride?.destination ?? 'Destination non spécifiée',
                          style: TTypography.bodyMedium(context).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 32),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: profileImage != null
                        ? Image.asset(
                            profileImage,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildDefaultAvatar(),
                          )
                        : _buildDefaultAvatar(),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ride.ride?.driver?.fullName ?? 'Conducteur',
                          style: TTypography.bodyMedium(context).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              driverNote.toString(),
                              style: TTypography.bodySmall(context).copyWith(
                                color: TColors.textSecondary(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      Icon(Icons.person_outline, color: TColors.textSecondary(context), size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${ride.ride?.seatsAvailable ?? 0}',
                        style: TTypography.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        color: TColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.person, color: TColors.primary, size: 24),
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
