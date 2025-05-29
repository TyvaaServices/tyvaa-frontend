import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:passenger_tyvaa/app/modules/home/controllers/home_controller.dart';
import 'package:passenger_tyvaa/app/modules/notification/controllers/notification_controller.dart';
import 'package:passenger_tyvaa/app/modules/profile/controllers/profile_controller.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';
import '../../../routes/app_pages.dart';
import '../../search/views/search_page.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final NotificationController notificationController = Get.find();
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed('/publier-trajet'),
        backgroundColor: TColors.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: TRadius.buttonRadius),
        label: Text(
          'Publier un trajet',
          style: TTypography.labelLarge(
            context,
          ).copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        icon: const Icon(Icons.add_road_rounded),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(TSpacing.md),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    SizedBox(height: TSpacing.lg),
                    _buildWelcomeCard(context),
                    SizedBox(height: TSpacing.lg),
                    _buildSearchBar(context),
                    SizedBox(height: TSpacing.xl),
                    _buildPromoSection(context),
                    SizedBox(height: TSpacing.xl),
                    _buildUpcomingRidesSection(context),
                    SizedBox(height: TSpacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // Profile image with improved tap indication
        Hero(
          tag: 'profile_image',
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => controller.changeTab(3),
              borderRadius: BorderRadius.circular(TRadius.md),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(TRadius.md),
                  border: Border.all(color: TColors.primary, width: 2),
                  boxShadow: TShadows.subtle,
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(TRadius.md - 2),
                      child: Container(
                        height: 48,
                        width: 48,
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
                    // Small icon indicator for tappable profile
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: TColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: TSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Salut, ${profileController.nameController.text} 👋',
                style: TTypography.headingSmall(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: TSpacing.xs),
              Obx(
                () => Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: TColors.primary.withOpacity(0.7),
                    ),
                    SizedBox(width: TSpacing.xs),
                    Expanded(
                      child: Text(
                        controller.currentAddress.value,
                        style: TTypography.bodySmall(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _buildNotificationButton(context),
      ],
    );
  }

  Widget _buildNotificationButton(BuildContext context) {
    return Obx(() {
      final hasNotifications = notificationController.notifications.isNotEmpty;

      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(TRadius.md),
        child: Ink(
          decoration: BoxDecoration(
            color: TColors.surface(context),
            borderRadius: BorderRadius.circular(TRadius.md),
            boxShadow: TShadows.subtle,
            border: Border.all(
              color:
                  hasNotifications
                      ? TColors.error.withOpacity(0.5)
                      : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: InkWell(
            onTap: () => Get.toNamed('/notification'),
            borderRadius: BorderRadius.circular(TRadius.md),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: EdgeInsets.all(TSpacing.md),
                  child: Icon(
                    Icons.notifications_outlined,
                    color:
                        hasNotifications
                            ? TColors.error
                            : TColors.textPrimary(context),
                    size: 24,
                  ),
                ),
                if (hasNotifications)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: TColors.error,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: TColors.surface(context),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: TColors.error.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: TRadius.cardRadius,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: TRadius.cardRadius,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [TColors.primary, TColors.primaryLight],
          ),
          boxShadow: TShadows.medium,
        ),
        child: InkWell(
          onTap: () => Get.toNamed('/publier-trajet'),
          borderRadius: TRadius.cardRadius,
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Stack(
            children: [
              // Visual elements
              Positioned(
                right: -30,
                top: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                bottom: -30,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.all(TSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(TSpacing.sm),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(TRadius.sm),
                              ),
                              child: const Icon(
                                Icons.directions_car_filled_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: TSpacing.sm),
                            Text(
                              'Tyvaa',
                              style: TTypography.headingMedium(
                                context,
                              ).copyWith(
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(TSpacing.xs),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: TSpacing.md),
                    Text(
                      'Voyagez ensemble,\néconomisez ensemble',
                      style: TTypography.displaySmall(
                        context,
                      ).copyWith(color: Colors.white, height: 1.2),
                    ),
                    SizedBox(height: TSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Trouvez des trajets partagés ou proposez les vôtres',
                            style: TTypography.bodyMedium(
                              context,
                            ).copyWith(color: Colors.white.withOpacity(0.9)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: TSpacing.md),
                          padding: EdgeInsets.symmetric(
                            horizontal: TSpacing.md,
                            vertical: TSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(TRadius.pill),
                          ),
                          child: Text(
                            'Publier',
                            style: TTypography.labelMedium(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: TSpacing.xs,
        vertical: TSpacing.sm,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(TRadius.lg),
        child: Ink(
          decoration: BoxDecoration(
            color: TColors.surface(context),
            borderRadius: BorderRadius.circular(TRadius.lg),
            boxShadow: [
              BoxShadow(
                color: TColors.primary.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            onTap: () => Get.toNamed(Routes.RIDE_SEARCH),
            borderRadius: BorderRadius.circular(TRadius.lg),
            child: Padding(
              padding: EdgeInsets.all(TSpacing.lg),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(TSpacing.sm),
                        decoration: BoxDecoration(
                          color: TColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search_rounded,
                          color: TColors.primary,
                          size: 22,
                        ),
                      ),
                      SizedBox(width: TSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Rechercher un trajet',
                              style: TTypography.bodyLarge(context).copyWith(
                                color: TColors.textPrimary(context),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Départ, destination, date...',
                              style: TTypography.bodySmall(
                                context,
                              ).copyWith(color: TColors.textSecondary(context)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(TSpacing.sm),
                        decoration: BoxDecoration(
                          color: TColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: TSpacing.md),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: TSpacing.sm),
                    decoration: BoxDecoration(
                      color: TColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(TRadius.md),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.touch_app, color: TColors.primary, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Appuyez pour chercher un trajet',
                          style: TTypography.labelMedium(context).copyWith(
                            color: TColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPromoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Offres spéciales', style: TTypography.headingMedium(context)),
        SizedBox(height: TSpacing.md),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: PageView.builder(
            controller: controller.bannerController,
            onPageChanged: (index) => controller.currentBanner.value = index,
            itemCount: controller.banners.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final banner = controller.banners[index];
              return Container(
                margin: EdgeInsets.only(right: TSpacing.md),
                decoration: BoxDecoration(
                  borderRadius: TRadius.cardRadius,
                  boxShadow: TShadows.medium,
                ),
                child: ClipRRect(
                  borderRadius: TRadius.cardRadius,
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
                            stops: const [0.6, 1.0],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(TSpacing.lg),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: TSpacing.md,
                                vertical: TSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: TColors.accent.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(
                                  TRadius.pill,
                                ),
                              ),
                              child: Text(
                                'PROMO',
                                style: TTypography.labelSmall(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: TSpacing.md),
                            Text(
                              banner['title']!,
                              style: TTypography.headingMedium(
                                context,
                              ).copyWith(color: Colors.white),
                            ),
                            SizedBox(height: TSpacing.xs),
                            Text(
                              banner['subtitle']!,
                              style: TTypography.bodyMedium(
                                context,
                              ).copyWith(color: Colors.white.withOpacity(0.9)),
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
        SizedBox(height: TSpacing.md),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(controller.banners.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: TSpacing.xs),
                  width: controller.currentBanner.value == index ? 12 : 8,
                  height: controller.currentBanner.value == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        controller.currentBanner.value == index
                            ? TColors.primary
                            : TColors.neutral300,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingRidesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Prochains trajets', style: TTypography.headingMedium(context)),
        SizedBox(height: TSpacing.md),
        Obx(
          () =>
              controller.upcomingRides.isEmpty
                  ? Center(
                    child: Text(
                      'Aucun trajet prévu pour le moment',
                      style: TTypography.bodyMedium(context),
                    ),
                  )
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.upcomingRides.length,
                    itemBuilder: (context, index) {
                      final ride = controller.upcomingRides[index];
                      return ListTile(
                        title: Text(ride['title']),
                        subtitle: Text(ride['date']),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap:
                            () => Get.toNamed('/ride-details', arguments: ride),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
