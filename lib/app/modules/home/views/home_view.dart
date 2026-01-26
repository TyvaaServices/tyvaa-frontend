import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // 1. Header (Friendly Greeting)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bonjour 👋",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.slate500,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Où allez-vous ?",
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: AppColors.slate900,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.slate900.withValues(alpha: 0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {}, // Notifications
                      icon: Icon(
                        Icons.notifications_none_rounded,
                        size: 24.w,
                        color: AppColors.slate900,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // 2. MAIN SEARCH CARD (Blablacar Redesign Style)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.slate900.withValues(
                        alpha: 0.08,
                      ), // Slightly stronger for depth
                      blurRadius: 32, // Softer spread
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // A. Toggle Switch (Find / Offer)
                    Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.slate50,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildToggleTab(context, "Trouver", true),
                            ),
                            Expanded(
                              child: _buildToggleTab(
                                context,
                                "Publier",
                                false,
                                onTap: controller.goToPublish,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          // B. Connected Inputs
                          _buildConnectedInputs(context),

                          SizedBox(height: 16.h),

                          // C. Date (Solo) - Passenger count removed per case study
                          _buildCompactSelector(
                            context,
                            Icons.calendar_today_rounded,
                            "Aujourd'hui",
                          ),

                          SizedBox(height: 24.h),

                          // D. Search Button (Full Width)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Get.toNamed(Routes.SEARCH_RIDE),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 18.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                              ),
                              child: const Text("Rechercher"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().moveY(begin: 20, end: 0, duration: 500.ms),

              SizedBox(height: 24.h),

              // 2.5 Active Ride Tracking Banner (New Feature)
              // Only visible if user has an active ride (Mock logic)
              Container(
                margin: EdgeInsets.only(bottom: 24.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.directions_car_rounded,
                        color: Colors.white,
                        size: 24.w,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trajet en cours",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            "Arrivée prévue à 14:30",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.ACTIVE_RIDE),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child: const Text("Suivre"),
                    ),
                  ],
                ),
              ).animate().slideX(
                begin: 1,
                end: 0,
                delay: const Duration(seconds: 1),
              ),

              SizedBox(height: 24.h),

              // 3. Safety Banner (Case Study Insight)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.info.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.health_and_safety_outlined,
                      color: AppColors.info,
                      size: 28.w,
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "COVID-19 : Voyagez en toute sécurité",
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.slate900,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Masque recommandé. Consultez nos règles sanitaires.",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.slate600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, color: AppColors.info),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // 4. Recent Searches (Carousel)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recherches récentes",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Tout voir",
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 110.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildRecentCard(
                      context,
                      "Dakar",
                      "Saint-Louis",
                      "Auj, 14:00",
                    ),
                    SizedBox(width: 16.w),
                    _buildRecentCard(context, "Touba", "Dakar", "Demain"),
                    SizedBox(width: 16.w),
                    _buildRecentCard(context, "Mbour", "Kaolack", "24 Jan"),
                  ],
                ),
              ),

              SizedBox(height: 100.h), // Bottom Nav Spacing
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleTab(
    BuildContext context,
    String text,
    bool isSelected, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: isSelected ? AppColors.primary : AppColors.slate500,
          ),
        ),
      ),
    );
  }

  Widget _buildConnectedInputs(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // Visual Connection Line
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.radio_button_checked,
                size: 16.w,
                color: AppColors.primary,
              ),
              Expanded(
                child: Container(
                  width: 2.w,
                  color: AppColors.slate200,
                  margin: EdgeInsets.symmetric(vertical: 4.h),
                ),
              ),
              Icon(Icons.location_on, size: 16.w, color: AppColors.secondary),
            ],
          ),
          SizedBox(width: 16.w),

          // Inputs
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.SEARCH_RIDE),
                  child: Container(
                    height: 50.h,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 8.h),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.slate100),
                      ),
                    ),
                    child: Text(
                      "Dakar, Sénégal",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate900,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.SEARCH_RIDE),
                  child: Container(
                    height: 50.h,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Où allez-vous ?",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactSelector(
    BuildContext context,
    IconData icon,
    String label, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20.w, color: AppColors.slate400),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.slate700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentCard(
    BuildContext context,
    String from,
    String to,
    String date,
  ) {
    return Container(
      width: 160.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate900.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 14.w,
                color: AppColors.slate400,
              ),
              SizedBox(width: 4.w),
              Text(
                date,
                style: TextStyle(fontSize: 12.sp, color: AppColors.slate500),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            from,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.slate900,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "↓ $to",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.slate900,
            ),
          ),
        ],
      ),
    );
  }
}
