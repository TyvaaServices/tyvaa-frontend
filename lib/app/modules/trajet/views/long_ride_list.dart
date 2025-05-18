import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:passenger_tyvaa/domain/entities/location_info.dart';
import 'package:passenger_tyvaa/domain/entities/long_ride.dart';
import 'package:shimmer/shimmer.dart';

import '../../../api/api_client.dart';
import '../../../themes/tyvaa_theme.dart';

class LongRideListController extends GetxController {
  LocationInfo? locationInfo;
  final ApiClient apiClient = ApiClient();
  final RxList<LongRide> rides = <LongRide>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedFilter = 'Tous'.obs;
  final RxBool isSearching = false.obs;

  final List<String> filterOptions = [
    'Tous',
    'Aujourd\'hui',
    'Demain',
    'Cette semaine',
    'Prix bas',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchRides();
  }

  Future<void> fetchRides() async {
    try {
      isLoading(true);

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      locationInfo = Get.arguments;
      if (locationInfo != null) {
        rides.value = await apiClient.getRidesByDestination(locationInfo!);
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      hasError(true);
      errorMessage(e.toString());
    }
  }

  void navigateToRideDetails(String rideId) {
    // Implementation for navigation to detail page
    Get.toNamed('/ride-details/$rideId');
  }

  void toggleSearch() {
    isSearching(!isSearching.value);
  }

  void setFilter(String filterOption) {
    selectedFilter(filterOption);
    // Implement actual filtering logic here
  }
}

class LongRideListScreen extends GetView<LongRideListController> {
  const LongRideListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LongRideListController(), fenix: true);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [_buildAppBar(context), _buildSearchAndFilter(context)];
          },
          body: _buildRideList(context),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              'Trajets',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            Obx(
                  () =>
              controller.isSearching.value
                  ? IconButton(
                icon: Icon(
                  Icons.close,
                  color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70
                      : AppColors.textSecondary,
                ),
                onPressed: controller.toggleSearch,
              )
                  : IconButton(
                icon: Icon(
                  Icons.search,
                  color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70
                      : AppColors.textSecondary,
                ),
                onPressed: controller.toggleSearch,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.notifications_none_outlined,
                color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white70
                    : AppColors.textSecondary,
              ),
              onPressed: () {
                // Implement notification functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          // Search bar (conditionally visible)
          Obx(
                () =>
            controller.isSearching.value
                ? Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: _buildSearchBar(context),
            )
                : const SizedBox.shrink(),
          ),

          // Filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _buildFilterChips(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search, color: AppColors.primary),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un trajet',
                hintStyle: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.textPrimary,
                fontSize: 16,
              ),
              autofocus: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: controller.filterOptions.length,
        itemBuilder: (context, index) {
          final option = controller.filterOptions[index];
          return Obx(() {
            final isSelected = controller.selectedFilter.value == option;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                label: Text(option),
                selected: isSelected,
                onSelected: (_) => controller.setFilter(option),
                backgroundColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[100],
                selectedColor: AppColors.primary.withOpacity(0.2),
                labelStyle: TextStyle(
                  color:
                  isSelected
                      ? AppColors.primary
                      : Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70
                      : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side:
                  isSelected
                      ? BorderSide(color: AppColors.primary, width: 1)
                      : BorderSide.none,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildRideList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.fetchRides,
      color: AppColors.primary,
      child: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmerLoading(context);
        }

        if (controller.hasError.value) {
          return _buildErrorView(context);
        }

        if (controller.rides.isEmpty) {
          return _buildEmptyView(context);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.rides.length,
          itemBuilder: (context, index) {
            final ride = controller.rides[index];
            return _buildRideCard(context, ride);
          },
        );
      }),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Shimmer.fromColors(
            baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
            highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            size: 80,
            color: isDark ? Colors.grey[600] : Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Impossible de charger les trajets',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.errorMessage.value,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: controller.fetchRides,
            icon: const Icon(Icons.refresh),
            label: const Text('Réessayer'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.directions_car_outlined,
              size: 80,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Aucun trajet disponible',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Nous ne trouvons pas de trajets correspondant à vos critères. Essayez de modifier vos filtres.',
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              // Reset all filters
              controller.selectedFilter('Tous');
              controller.fetchRides();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Réinitialiser les filtres'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideCard(BuildContext context, LongRide ride) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final date = Jiffy.parseFromDateTime(ride.dateTime).format(pattern: 'EEEE');
    final time = Jiffy.parseFromDateTime(
      ride.dateTime,
    ).format(pattern: 'HH:mm');

    return GestureDetector(
      onTap: () => controller.navigateToRideDetails(ride.id.toString()),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow:
          isDark
              ? []
              : [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row: Date, Time, Price
            Row(
              children: [
                _infoPill(Icons.calendar_today, date, context),
                const SizedBox(width: 8),
                _infoPill(Icons.access_time, time, context),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${ride.price.toStringAsFixed(0)} FCFA',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Route
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _locationText(ride.departure, AppColors.primary, context),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    height: 1,
                    width: 30,
                    color: isDark ? Colors.grey[700] : Colors.grey[300],
                  ),
                ),
                _locationText(ride.destination, Colors.redAccent, context),
              ],
            ),

            const SizedBox(height: 16),

            /// Driver Info
            Row(
              children: [
                CircleAvatar(
                  // backgroundImage: CachedNetworkImageProvider(ride.driverPhoto),
                  radius: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ride.driverId.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          // Text(
                          //   '${ride.driverRating} • ${ride.driverTrips} trajets',
                          //   style: TextStyle(
                          //     fontSize: 13,
                          //     color: isDark ? Colors.white54 : Colors.grey[600],
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _infoPill(Icons.event_seat, '${ride.places} dispo', context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoPill(IconData icon, String text, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationText(String location, Color color, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Icon(Icons.circle, size: 10, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            location,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class RideModel {
  final String id;
  final String driverId;
  final String driverName;
  final String driverPhoto;
  final double driverRating;
  final int driverTrips;
  final String origin;
  final String destination;
  final DateTime departureDate;
  final double price;
  final int availableSeats;
  final int totalSeats;
  final String description;
  final String estimatedDuration;
  final String carModel;
  final String carColor;
  final List<String> amenities;

  RideModel({
    required this.id,
    required this.driverId,
    required this.driverName,
    required this.driverPhoto,
    required this.driverRating,
    required this.driverTrips,
    required this.origin,
    required this.destination,
    required this.departureDate,
    required this.price,
    required this.availableSeats,
    required this.totalSeats,
    required this.description,
    required this.estimatedDuration,
    required this.carModel,
    required this.carColor,
    required this.amenities,
  });
}