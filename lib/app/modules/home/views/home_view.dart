import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/home/views/aide_view.dart';
import 'package:passenger_tyvaa/app/modules/notification/controllers/notification_controller.dart';
import 'package:passenger_tyvaa/app/modules/search/views/search_page.dart';

import '../../../themes/tyvaa_theme.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final NotificationController notificationController = Get.find();
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    final backgroundColor =
        isDark ? AppColors.darkBackground : const Color(0xFFF7F8FC);
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final surfaceColor = isDark ? const Color(0xFF1E1E2E) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(isDark, primaryColor, textColor, surfaceColor),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.015),
                    _buildWelcomeCard(isDark, primaryColor),
                    SizedBox(height: Get.height * 0.035),
                    _buildSearchBar(isDark, surfaceColor, textColor),
                    SizedBox(height: Get.height * 0.035),
                    _buildQuickActions(isDark, surfaceColor, textColor),
                    SizedBox(height: Get.height * 0.035),
                    _buildPromoSection(isDark, textColor),
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

  Widget _buildAppBar(
    bool isDark,
    Color primaryColor,
    Color textColor,
    Color surfaceColor,
  ) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      surfaceTintColor: Colors.transparent,
      floating: true,
      elevation: 0,
      toolbarHeight: 80,
      backgroundColor:
          isDark ? AppColors.darkBackground : const Color(0xFFF7F8FC),
      title: Row(
        children: [
          SizedBox(
            height: Get.height * 0.05,
            width: Get.height * 0.05,
            // child: const Icon(Icons.person, color: Colors.white),
            child:
                profileController.profileImage.value != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image(
                        image: FileImage(profileController.profileImage.value!),
                        fit: BoxFit.cover,
                      ),
                    )
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image(
                        image:
                            Image.asset(
                              'assets/images/default_profile.png',
                            ).image,
                        fit: BoxFit.cover,
                      ),
                    ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.4,
                child: Text(
                  'Bonjour, ${profileController.nameController.text} 👋🏾',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                'Bienvenue sur Tyvaa',
                style: TextStyle(
                  fontSize: 12,
                  color: textColor.withOpacity(0.7),
                ),
              ),
              Obx(
                () => Text(
                  controller.currentAddress.value,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
                blurRadius: 10,
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
                    Icons.notifications_none_rounded,
                    color: textColor,
                  ),
                  onPressed: () => Get.toNamed('/notification'),
                ),
                if (hasNotifications)
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
                  ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard(bool isDark, Color primaryColor) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : primaryColor.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Container(
              height: Get.height * 0.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, const Color(0xFF8A6FFF)],
                ),
              ),
            ),
            Positioned(
              right: -Get.width * 0.1,
              top: -Get.height * 0.04,
              child: CircleAvatar(
                radius: Get.width * 0.15,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              left: -Get.width * 0.08,
              bottom: -Get.height * 0.05,
              child: CircleAvatar(
                radius: Get.width * 0.13,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Voyagez avec la communauté',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Trouvez facilement des trajets ou proposez les vôtres',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () => Get.to(SearchView()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        'Rechercher un trajet',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
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

  Widget _buildSearchBar(bool isDark, Color surfaceColor, Color textColor) {
    return GestureDetector(
      onTap: () => Get.to(SearchView()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
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
            Icon(Icons.search_rounded, color: textColor.withOpacity(0.6)),
            const SizedBox(width: 12),
            Text(
              'Où souhaitez-vous aller ?',
              style: TextStyle(color: textColor.withOpacity(0.6), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(bool isDark, Color surfaceColor, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions rapides',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildActionCard(
              isDark,
              surfaceColor,
              textColor,
              Icons.add_road_rounded,
              'Publier trajet',
              const Color(0xFF6C63FF),
              () {
                Get.toNamed('/publier-trajet');
              },
            ),
            _buildActionCard(
              isDark,
              surfaceColor,
              textColor,
              Icons.history_rounded,
              'Historique',
              const Color(0xFF4ECDC4),
              () {},
            ),
            _buildActionCard(
              isDark,
              surfaceColor,
              textColor,
              Icons.support_agent_rounded,
              'Aide',
              const Color(0xFFFF6B6B),
              () => Get.to(() => AideScreen()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    IconData icon,
    String label,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.26,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
          height: Get.height * 0.23,
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
                  width: controller.currentBanner.value == index ? 20 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color:
                        controller.currentBanner.value == index
                            ? const Color(0xFF6C63FF)
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
