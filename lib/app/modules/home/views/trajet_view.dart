import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/design_system.dart';

class DriverHomeView extends GetView<DriverController> {
  const DriverHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = TColors.background(context);
    final textColor = TColors.textPrimary(context);
    final primaryColor = TColors.primary;
    final surfaceColor = TColors.surface(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed('/publier-trajet'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        label: const Text(
          'Publier un trajet',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        icon: const Icon(Icons.add_road_rounded),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildDriverAppBar(isDark, primaryColor, textColor, surfaceColor),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    _buildDriverWelcomeCard(isDark, primaryColor, context),
                    SizedBox(height: Get.height * 0.035),
                    _buildDriverStatusCard(isDark, surfaceColor, textColor),
                    SizedBox(height: Get.height * 0.035),
                    // _buildDriverStatsSection(isDark, surfaceColor, textColor),
                    SizedBox(height: Get.height * 0.035),
                    _buildUpcomingTripsSection(isDark, surfaceColor, textColor),
                    SizedBox(height: Get.height * 0.08),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverAppBar(
    bool isDark,
    Color primaryColor,
    Color textColor,
    Color surfaceColor,
  ) {
    final backgroundColor = TColors.background(Get.context!);
    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      pinned: true,
      snap: false,
      floating: true,
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.drive_eta_rounded, color: primaryColor, size: 24),
          ),
          const SizedBox(width: 12),
          Text(
            'Espace Conducteur',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
    );
  }

  Widget _buildDriverWelcomeCard(
    bool isDark,
    Color primaryColor,
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : primaryColor.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            Container(
              height: Get.height * 0.22,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryColor, TColors.accent],
                ),
              ),
            ),
            // Design elements (circles etc.)
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.drive_eta_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Mode Conducteur',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.015),
                  Text(
                    'Conduisez, gagnez,\npartagez votre route',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Publiez vos trajets et maximisez vos revenus',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
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

  Widget _buildDriverStatusCard(
    bool isDark,
    Color surfaceColor,
    Color textColor,
  ) {
    final primaryColor = TColors.primary;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.online_prediction_rounded,
              color: primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Êtes-vous prêt à conduire ?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Passez en ligne pour recevoir des demandes',
                  style: TextStyle(
                    fontSize: 13,
                    color: textColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Switch(
              value: controller.isDriverOnline.value,
              onChanged: (value) => controller.toggleDriverOnline(),
              activeColor: primaryColor,
              activeTrackColor: primaryColor.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    IconData icon,
    String title,
    String value,
  ) {
    final primaryColor = TColors.primary;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryColor, size: 18),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 13, color: textColor.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }

  // Upcoming trips section
  Widget _buildUpcomingTripsSection(
    bool isDark,
    Color surfaceColor,
    Color textColor,
  ) {
    final primaryColor = TColors.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trajets à venir',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),
              child: const Text('Voir tout'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTripCard(
          isDark,
          surfaceColor,
          textColor,
          'Dakar',
          'Kaolack',
          '13 Mai 2025',
          '09:00',
          '3 passagers',
        ),
        const SizedBox(height: 12),
        _buildTripCard(
          isDark,
          surfaceColor,
          textColor,
          'Dakar',
          'Mbour',
          '15 Mai 2025',
          '14:30',
          '2 passagers',
        ),
      ],
    );
  }

  Widget _buildTripCard(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    String from,
    String to,
    String date,
    String time,
    String passengers,
  ) {
    final primaryColor = TColors.primary;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
            blurRadius: 10,
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.directions_car_filled_rounded,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$from → $to',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 14,
                          color: textColor.withOpacity(0.5),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$date - $time',
                          style: TextStyle(
                            fontSize: 12,
                            color: textColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.people_alt_rounded,
                      size: 14,
                      color: primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      passengers,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DriverController extends GetxController {
  final isDriverOnline = false.obs;
  final currentTrips = <Map<String, dynamic>>[].obs;
  final completedTrips = <Map<String, dynamic>>[].obs;
  final statistics =
      {
        'trips': '0',
        'earnings': '0 CFA',
        'rating': '0.0',
        'passengers': '0',
      }.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDriverData();
  }

  void toggleDriverOnline() {
    isDriverOnline.value = !isDriverOnline.value;
    // Here you can add code to actually go online/offline
    if (isDriverOnline.value) {
      Get.snackbar(
        'En ligne',
        'Vous êtes maintenant disponible pour recevoir des demandes de trajet',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TColors.primary,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );
    } else {
      Get.snackbar(
        'Hors ligne',
        'Vous n\'êtes plus disponible pour recevoir des demandes',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
        icon: const Icon(Icons.offline_bolt, color: Colors.white),
      );
    }
  }

  void fetchDriverData() {
    // In a real app, you would call API endpoints to fetch driver data
    // For now, using mock data

    statistics.value = {
      'trips': '12',
      'earnings': '25400 CFA',
      'rating': '4.8',
      'passengers': '37',
    };

    // And similar mock data for trips
  }
}
