import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if we came from Profile to avoid circular navigation
    final previousRoute = Get.previousRoute;
    final cameFromProfile = previousRoute == Routes.PROFILE;

    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        title: const Text('Paramètres'),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/ic_back.png',
            width: 24.w,
            color: AppColors.textMain,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24.w),
          physics: const BouncingScrollPhysics(),
          children: [
            _buildSectionHeader(context, 'Compte'),
            _buildGroupedTiles([
              // Logic to prevent Profile -> Settings -> Profile Loop
              if (!cameFromProfile)
                _SettingsItem(
                  title: 'Mon Profil',
                  iconPath: 'assets/icons/nav_profile.png',
                  onTap: () => Get.toNamed(Routes.PROFILE),
                ),
              _SettingsItem(
                title: 'Mes Réservations',
                iconPath: 'assets/icons/nav_requests.png',
                onTap: () => Get.toNamed(Routes.MY_BOOKINGS),
              ),
            ]),

            SizedBox(height: 24.h),
            _buildSectionHeader(context, 'Activité'),
            _buildGroupedTiles([
              _SettingsItem(
                title: 'Mes Trajets Publiés',
                iconPath: 'assets/icons/nav_rides.png',
                onTap: () => Get.toNamed(Routes.MY_RIDES),
              ),
              _SettingsItem(
                title: 'Demandes de Réservation',
                iconPath: 'assets/icons/nav_requests.png',
                onTap: () => Get.toNamed(Routes.BOOKING_REQUESTS),
              ),
            ]),

            SizedBox(height: 24.h),
            _buildSectionHeader(context, 'Général'),
            _buildGroupedTiles([
              _SettingsItem(
                title: 'À propos de Tyvaa',
                iconPath: 'assets/icons/ic_bell.png', // Placeholder
                onTap: () {},
                subtitle: 'Version ${controller.appVersion.value}',
              ),
              _SettingsItem(
                title: 'Déconnexion',
                iconPath: 'assets/icons/ic_logout.png',
                onTap: controller.logout,
                color: AppColors.error,
                showArrow: false,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  // ... (Helper widgets remain the same)
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          letterSpacing: 1.5,
          fontWeight: FontWeight.w800,
          color: AppColors.slate500,
        ),
      ),
    );
  }

  Widget _buildGroupedTiles(List<Widget> children) {
    if (children.isEmpty)
      return const SizedBox.shrink(); // Handle empty group if Profile is hidden

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          final idx = entry.key;
          final widget = entry.value;
          final isLast = idx == children.length - 1;

          return Column(
            children: [
              widget,
              if (!isLast)
                Padding(
                  padding: EdgeInsets.only(left: 60.w),
                  child: const Divider(height: 1),
                ),
            ],
          );
        }).toList(),
      ),
    ).animate().fadeIn().slideY(begin: 0.05, end: 0);
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final String? subtitle;
  final Color? color;
  final bool showArrow;

  const _SettingsItem({
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.subtitle,
    this.color,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: (color ?? AppColors.primary).withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          iconPath,
          width: 20.w,
          color: color ?? AppColors.primary,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: color ?? AppColors.textMain,
        ),
      ),
      subtitle: subtitle != null
          ? Text(subtitle!, style: theme.textTheme.bodySmall)
          : null,
      trailing: showArrow
          ? Icon(
              Icons.chevron_right_rounded,
              color: AppColors.slate400,
              size: 24.w,
            )
          : null,
    );
  }
}
