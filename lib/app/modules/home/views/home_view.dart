import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:passenger_tyvaa/app/modules/home/controllers/home_controller.dart';
import 'package:passenger_tyvaa/app/modules/notification/controllers/notification_controller.dart';
import 'package:passenger_tyvaa/app/modules/profile/controllers/profile_controller.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

import '../../../themes/tyvaa_theme.dart';
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
        Hero(
          tag: 'profile_image',
          child: GestureDetector(
            onTap: () => controller.changeTab(3),
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TRadius.md),
                border: Border.all(
                  color: TColors.primary.withOpacity(0.2),
                  width: 2,
                ),
                boxShadow: TShadows.subtle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(TRadius.md - 2),
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

      return Container(
        decoration: BoxDecoration(
          color: TColors.surface(context),
          borderRadius: BorderRadius.circular(TRadius.md),
          boxShadow: TShadows.subtle,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Get.toNamed('/notification'),
                borderRadius: BorderRadius.circular(TRadius.md),
                child: Padding(
                  padding: EdgeInsets.all(TSpacing.md),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: TColors.textPrimary(context),
                    size: 24,
                  ),
                ),
              ),
            ),
            if (hasNotifications)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: TColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: TColors.surface(context),
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: TRadius.cardRadius,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [TColors.primary, TColors.primaryLight],
        ),
        boxShadow: TShadows.medium,
      ),
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
                      ).copyWith(color: Colors.white, letterSpacing: 0.5),
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
                Text(
                  'Trouvez des trajets partagés ou proposez les vôtres',
                  style: TTypography.bodyMedium(
                    context,
                  ).copyWith(color: Colors.white.withOpacity(0.9)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Hero(
      tag: 'search_bar',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:
              () => showMaterialModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => LocationSearchModal(),
                shape: RoundedRectangleBorder(
                  borderRadius: TRadius.modalRadius,
                ),
              ),
          borderRadius: TRadius.inputRadius,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: TSpacing.lg,
              vertical: TSpacing.md,
            ),
            decoration: BoxDecoration(
              color: TColors.surface(context),
              borderRadius: TRadius.inputRadius,
              boxShadow: TShadows.subtle,
            ),
            child: Row(
              children: [
                Icon(Icons.search_rounded, color: TColors.primary, size: 22),
                SizedBox(width: TSpacing.md),
                Expanded(
                  child: Text(
                    'Où souhaitez-vous aller ?',
                    style: TTypography.bodyMedium(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(TSpacing.xs),
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(TRadius.sm),
                  ),
                  child: Icon(
                    Icons.tune_rounded,
                    color: TColors.primary,
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

  Widget _buildRecentTripCard(
    BuildContext context,
    String from,
    String to,
    String distance,
    String date,
  ) {
    return Container(
      width: 180,
      padding: EdgeInsets.all(TSpacing.md),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: TRadius.cardRadius,
        boxShadow: TShadows.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(TSpacing.xs),
            decoration: BoxDecoration(
              color: TColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(TRadius.sm),
            ),
            child: Icon(Icons.route_rounded, color: TColors.primary, size: 20),
          ),
          SizedBox(height: TSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '$from → $to',
                  style: TTypography.bodyMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: TSpacing.xs),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: TSpacing.sm,
              vertical: TSpacing.xs / 2,
            ),
            decoration: BoxDecoration(
              color: TColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(TRadius.pill),
            ),
            child: Text(
              distance,
              style: TTypography.labelSmall(
                context,
              ).copyWith(color: TColors.primary, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: TSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 12,
                color: TColors.textSecondary(context),
              ),
              SizedBox(width: TSpacing.xs),
              Text(date, style: TTypography.bodySmall(context)),
            ],
          ),
        ],
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
                  duration: TAnimations.medium,
                  width: controller.currentBanner.value == index ? 20 : 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: TSpacing.xs / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(TRadius.pill),
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
        Row(
          children: [
            Text(
              'Vos prochains trajets',
              style: TTypography.headingMedium(context),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: TSpacing.sm),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TRadius.pill),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Voir tout',
                    style: TTypography.labelMedium(
                      context,
                    ).copyWith(color: TColors.primary),
                  ),
                  SizedBox(width: TSpacing.xs),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: TColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: TSpacing.md),
        // For demo purposes, showing empty state since user may not have upcoming rides
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(TSpacing.lg),
          decoration: BoxDecoration(
            color: TColors.surface(context),
            borderRadius: TRadius.cardRadius,
            border: Border.all(color: TColors.neutral300, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(TSpacing.md),
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.directions_car_filled_outlined,
                  color: TColors.primary,
                  size: 32,
                ),
              ),
              SizedBox(height: TSpacing.md),
              Text(
                'Aucun trajet à venir',
                style: TTypography.headingSmall(context),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSpacing.sm),
              Text(
                'Réservez un trajet ou publiez votre propre itinéraire pour le voir apparaître ici.',
                style: TTypography.bodyMedium(
                  context,
                ).copyWith(color: TColors.textSecondary(context)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSpacing.lg),
            ],
          ),
        ),
      ],
    );
  }
}
