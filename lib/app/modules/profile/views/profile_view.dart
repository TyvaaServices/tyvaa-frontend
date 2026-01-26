import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.slate50, // 1. Background color change
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Aide",
              style: TextStyle(color: AppColors.primary, fontSize: 14.sp),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final user = controller.user.value;
        if (controller.isLoading.value && user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            children: [
              // 1. Profile Header
              _buildHeader(theme, user),
              SizedBox(height: 24.h),

              // 2. Info Banner
              _buildInfoBanner(theme),
              SizedBox(height: 24.h),

              // 3. Section: Account
              _buildSectionTitle(theme, "Compte"),
              _buildSectionContainer([
                _buildListItem(
                  "Infos personnelles",
                  icon: Icons.person_outline_rounded,
                  onTap: controller.toggleEdit,
                ),
                _buildDivider(),
                _buildListItem(
                  "Mes Véhicules",
                  icon: Icons.directions_car_outlined,
                  subtitle: "Gérer mes voitures",
                  onTap: () {},
                ),
                _buildDivider(),
                _buildListItem(
                  "Vérification d'identité",
                  icon: Icons.verified_user_outlined,
                  subtitle: "Requis pour conduire",
                  onTap: () {},
                ),
                _buildDivider(),
                _buildListItem(
                  "Notifications",
                  icon: Icons.notifications_none_rounded,
                  onTap: () {},
                ),
              ]),

              SizedBox(height: 24.h),

              // 4. Section: Payments
              _buildSectionTitle(theme, "Paiements"),
              _buildSectionContainer([
                _buildListItem(
                  "Méthodes de paiement",
                  icon: Icons.payment_outlined,
                  subtitle: "Wave, Orange Money",
                  onTap: () {},
                ),
                _buildDivider(),
                _buildListItem(
                  "Historique",
                  icon: Icons.receipt_long_outlined,
                  onTap: () {},
                ),
              ]),

              SizedBox(height: 24.h),

              // 5. Section: Preferences
              _buildSectionTitle(theme, "Préférences"),
              _buildSectionContainer([
                _buildListItem(
                  "Accessibilité",
                  icon: Icons.accessibility_new_rounded,
                  onTap: () {},
                ),
                _buildDivider(),
                _buildListItem(
                  "Langue",
                  icon: Icons.language_rounded,
                  trailingText: "Français",
                  onTap: () {},
                ),
              ]),

              SizedBox(height: 32.h),

              // 6. Actions (Logout)
              _buildLogoutButton(theme),

              SizedBox(height: 40.h),

              // 7. Footer
              Text(
                "Version 1.0.0",
                style: TextStyle(color: AppColors.slate400, fontSize: 12.sp),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader(ThemeData theme, dynamic user) {
    return Column(
      children: [
        GestureDetector(
          onTap: controller.toggleEdit,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 48.r,
                  backgroundColor: AppColors.slate100,
                  backgroundImage: const AssetImage(
                    'assets/icons/nav_profile.png',
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.w),
                  ),
                  child: Icon(Icons.edit, size: 14.w, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          user?.fullName ?? 'Utilisateur',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.h),
        if (user?.role == 'conducteur')
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 14.w, color: AppColors.success),
                SizedBox(width: 4.w),
                Text(
                  "Vérifié",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          )
        else
          Text(
            "Passager",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.slate500,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  Widget _buildInfoBanner(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield_outlined,
              color: AppColors.primary,
              size: 24.w,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profil complété à 85%",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Ajoutez une photo pour rassurer les autres membres.",
                  style: TextStyle(fontSize: 12.sp, color: AppColors.slate500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: AppColors.slate500,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.slate50,
      indent: 56.w,
    );
  }

  Widget _buildListItem(
    String title, {
    String? subtitle,
    required IconData icon,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              Icon(icon, size: 22.w, color: AppColors.slate400),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate900,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.slate500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailingText != null)
                Text(
                  trailingText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.slate400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (trailingText == null)
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20.w,
                  color: AppColors.slate300,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: TextButton.icon(
        onPressed: controller.logout,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          backgroundColor: AppColors.error.withOpacity(0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        icon: Icon(Icons.logout_rounded, size: 20.w, color: AppColors.error),
        label: Text(
          "Se déconnecter",
          style: TextStyle(
            color: AppColors.error,
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}
