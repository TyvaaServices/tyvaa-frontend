import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:passenger_tyvaa/app/modules/home/controllers/home_controller.dart';
import 'package:passenger_tyvaa/app/modules/notification/controllers/notification_controller.dart';
import 'package:passenger_tyvaa/app/modules/profile/controllers/profile_controller.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';

import '../../search/views/search_page.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final NotificationController notificationController = Get.find();
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    final backgroundColor =
        isDark ? AppColors.darkBackground : const Color(0xFFF8F9FE);
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final surfaceColor = isDark ? const Color(0xFF1E1E2E) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      // floatingActionButton: _buildSpeedDial(isDark, primaryColor, surfaceColor),
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
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -60,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.05),
                ),
              ),
            ),

            // Main content
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Use a responsive padding at the top
                        SizedBox(height: Get.height * 0.02),
                        // AppBar content moved to body
                        _buildInlineAppBar(
                          isDark,
                          primaryColor,
                          textColor,
                          surfaceColor,
                        ),
                        // Use consistent spacing between sections
                        SizedBox(height: Get.height * 0.03),
                        _buildWelcomeCard(isDark, primaryColor, context),
                        SizedBox(height: Get.height * 0.03),
                        _buildSearchBar(
                          isDark,
                          surfaceColor,
                          textColor,
                          context,
                        ),
                        SizedBox(height: Get.height * 0.03),
                        _buildPromoSection(isDark, textColor),
                        // Add bottom padding for scrolling
                        SizedBox(height: Get.height * 0.03),
                      ],
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

  Widget _buildSpeedDial(bool isDark, Color primaryColor, Color surfaceColor) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: 3,
      childPadding: const EdgeInsets.all(5),
      spaceBetweenChildren: 4,
      elevation: 8.0,
      animationCurve: Curves.elasticInOut,
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      activeBackgroundColor: surfaceColor,
      activeForegroundColor: primaryColor,
      buttonSize: const Size(60, 60),
      childrenButtonSize: const Size(56, 56),
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.add_road_rounded),
          backgroundColor: const Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          label: 'Publier trajet',
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black,
          ),
          labelBackgroundColor: surfaceColor,
          onTap: () => Get.toNamed('/publier-trajet'),
        ),
        SpeedDialChild(
          child: const Icon(Icons.history_rounded),
          backgroundColor: const Color(0xFF4ECDC4),
          foregroundColor: Colors.white,
          label: 'Historique des trajets',
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black,
          ),
          labelBackgroundColor: surfaceColor,
          onTap: () {},
        ),
        SpeedDialChild(
          child: const Icon(Icons.support_agent_rounded),
          backgroundColor: const Color(0xFFFF6B6B),
          foregroundColor: Colors.white,
          label: 'Centre d\'aide',
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black,
          ),
          labelBackgroundColor: surfaceColor,
          onTap: () => Get.toNamed(Routes.AIDE),
        ),
      ],
    );
  }

  Widget _buildInlineAppBar(
    bool isDark,
    Color primaryColor,
    Color textColor,
    Color surfaceColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Hero(
            tag: 'profile_image',
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: primaryColor.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () => controller.changeTab(3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child:
                      profileController.profileImage.value != null
                          ? Image(
                            image: FileImage(
                              profileController.profileImage.value!,
                            ),
                            fit: BoxFit.cover,
                          )
                          : Image.asset(
                            'assets/images/default_profile.png',
                            fit: BoxFit.cover,
                          ),
                ),
              ),
            ),
          ),
          SizedBox(width: Get.width * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.4,
                child: Text(
                  'Salut, ${profileController.nameController.text} 👋',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 2),
              Obx(
                () => Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 12,
                      color: primaryColor.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: Get.width * 0.35,
                      child: Text(
                        controller.currentAddress.value,
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor.withOpacity(0.6),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color:
                      isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Obx(() {
              final hasNotifications =
                  notificationController.notifications.isNotEmpty;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: textColor,
                      size: Get.width * 0.055,
                    ),
                    onPressed: () => Get.toNamed('/notification'),
                    padding: EdgeInsets.all(Get.width * 0.02),
                    constraints: BoxConstraints(
                      minWidth: Get.width * 0.1,
                      minHeight: Get.width * 0.1,
                    ),
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  if (hasNotifications)
                    Positioned(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                          border: Border.all(color: surfaceColor, width: 1.5),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(
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
                  colors: [primaryColor, const Color(0xFF8A6FFF)],
                ),
              ),
            ),
            // Design elements
            Positioned(
              right: -Get.width * 0.12,
              top: -Get.height * 0.06,
              child: CircleAvatar(
                radius: Get.width * 0.18,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              left: -Get.width * 0.06,
              bottom: -Get.height * 0.04,
              child: CircleAvatar(
                radius: Get.width * 0.12,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            // Small circles
            Positioned(
              left: Get.width * 0.3,
              top: Get.height * 0.04,
              child: CircleAvatar(
                radius: 6,
                backgroundColor: Colors.white.withOpacity(0.2),
              ),
            ),
            Positioned(
              right: Get.width * 0.2,
              bottom: Get.height * 0.04,
              child: CircleAvatar(
                radius: 4,
                backgroundColor: Colors.white.withOpacity(0.2),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.directions_car_filled_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Tyvaa',
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
                  const Text(
                    'Voyagez ensemble,\néconomisez ensemble',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Trouvez des trajets partagés ou proposez les vôtres',
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

  // Replace your existing _buildSearchBar function with this updated version
  // Replace your existing _buildSearchBar function with this updated version
  Widget _buildSearchBar(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    BuildContext context,
  ) {
    return Hero(
      key: const Key('search_bar'),
      transitionOnUserGestures: true,
      tag: 'search_bar',
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap:
              () => showMaterialModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => LocationSearchModal(),
                enableDrag: true,
                bounce: true,
                duration: const Duration(milliseconds: 400),
                barrierColor: Colors.black54,
                elevation: 0,
                expand: false,
                isDismissible: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
              ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isDark ? const Color(0xFF252543) : Colors.white,
                  isDark ? const Color(0xFF1E1E2E) : const Color(0xFFF8F9FE),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  color: Get.theme.primaryColor,
                  size: 22,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Où souhaitez-vous aller ?',
                    style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.tune_rounded,
                    color: Get.theme.primaryColor,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildRecentTripSection(
  //   bool isDark,
  //   Color surfaceColor,
  //   Color textColor,
  // ) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'Trajets récents',
  //             style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               color: textColor,
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {},
  //             style: TextButton.styleFrom(
  //               foregroundColor: Get.theme.primaryColor,
  //               padding: EdgeInsets.zero,
  //               visualDensity: VisualDensity.compact,
  //             ),
  //             child: const Text('Voir tout'),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 16),
  //       _buildRecentTripCard(
  //         isDark,
  //         surfaceColor,
  //         textColor,
  //         'Dakar',
  //         'Kaolack',
  //         '130 km',
  //         '13 Mai 2025',
  //       ),
  //       const SizedBox(height: 12),
  //       _buildRecentTripCard(
  //         isDark,
  //         surfaceColor,
  //         textColor,
  //         'Dakar',
  //         'Mbour',
  //         '45 km',
  //         '8 Mai 2025',
  //       ),
  //     ],
  //   );
  // }

  Widget _buildRecentTripCard(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    String from,
    String to,
    String distance,
    String date,
  ) {
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Get.theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.route_rounded,
              color: Get.theme.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '$from → $to',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        distance,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 14,
                      color: textColor.withOpacity(0.5),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      date,
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
        ],
      ),
    );
  }

  Widget _buildPromoSection(bool isDark, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Offres spéciales',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: Get.height * 0.22,
          child: PageView.builder(
            controller: controller.bannerController,
            onPageChanged: (index) => controller.currentBanner.value = index,
            itemCount: controller.banners.length,
            itemBuilder: (context, index) {
              final banner = controller.banners[index];
              return Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color:
                          isDark
                              ? Colors.black26
                              : Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(banner['image']!, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                'PROMO',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              banner['title']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              banner['subtitle']!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(controller.banners.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: controller.currentBanner.value == index ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color:
                        controller.currentBanner.value == index
                            ? Get.theme.primaryColor
                            : (isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade300),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
