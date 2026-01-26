import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/dashboard_controller.dart';
import '../../home/views/home_view.dart';
import '../../my_rides/views/my_rides_view.dart';
import '../../messages/views/messages_view.dart';
import '../../profile/views/profile_view.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: const [
            HomeView(),
            MyRidesView(),
            MessagesView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: EdgeInsets.only(bottom: 12.h, left: 16.w, right: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
            boxShadow: [
              BoxShadow(
                color: AppColors.slate900.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, -8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: NavigationBar(
              selectedIndex: controller.tabIndex.value,
              onDestinationSelected: controller.changeTabIndex,
              backgroundColor: Colors.white,
              indicatorColor: AppColors.primary.withValues(alpha: 0.1),
              surfaceTintColor: Colors.transparent,
              height: 64.h,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              elevation: 0,
              destinations: [
                _buildNavDestination(
                  'nav_home.png',
                  'Home',
                  controller.tabIndex.value == 0,
                ),
                _buildNavDestination(
                  'nav_rides.png',
                  'Trajets',
                  controller.tabIndex.value == 1,
                ),
                _buildNavDestination(
                  'nav_requests.png',
                  'Messages',
                  controller.tabIndex.value == 2,
                ),
                _buildNavDestination(
                  'nav_profile.png',
                  'Profil',
                  controller.tabIndex.value == 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NavigationDestination _buildNavDestination(
    String assetName,
    String label,
    bool isSelected,
  ) {
    return NavigationDestination(
      icon: Image.asset(
        'assets/icons/$assetName',
        width: 24.w,
        height: 24.w,
        color: AppColors.slate400,
      ),
      selectedIcon: Image.asset(
        'assets/icons/$assetName',
        width: 24.w,
        height: 24.w,
        color: AppColors.primary,
      ),
      label: label,
    );
  }
}
