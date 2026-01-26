import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../data/entities/ride.dart';
import '../controllers/my_rides_controller.dart';

class MyRidesView extends GetView<MyRidesController> {
  const MyRidesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        title: const Text('Mes Trajets'),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_list_rounded,
              color: AppColors.slate900,
            ),
            onPressed: () {}, // Filter logic
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: controller.tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.slate400,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: "Réservations"),
                Tab(text: "Publications"),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return TabBarView(
          controller: controller.tabController,
          children: [
            _buildRideList(context, controller.bookedRides, isDriver: false),
            _buildRideList(context, controller.publishedRides, isDriver: true),
          ],
        );
      }),
    );
  }

  Widget _buildRideList(
    BuildContext context,
    List<Ride> rides, {
    required bool isDriver,
  }) {
    if (rides.isEmpty) {
      return _buildEmptyState(context, isDriver);
    }

    return RefreshIndicator(
      onRefresh: controller.loadMyRides,
      color: AppColors.primary,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        itemCount: rides.length,
        itemBuilder: (context, index) {
          final ride = rides[index];
          final status = _getStatus(index); // Mock logic moved here

          return Column(
            children: [
              // Date Header (Optional grouping could go here)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Status Header
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: status.bgColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(status.icon, size: 16.w, color: status.color),
                          SizedBox(width: 8.w),
                          Text(
                            status.text,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: status.color,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 16.w,
                            color: status.color.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),

                    // The Ride Card Content
                    // We wrap the existing RideCard but disable its default elevation/margin if needed
                    // Or simply put it here. Assuming RideCard has its own decoration, we might need to clip it.
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(16.r),
                      ),
                      child: RideCard(
                        ride: ride,
                        onTap: () => controller.goToRideDetail(ride),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDriver) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.slate900.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  isDriver
                      ? Icons.add_circle_outline_rounded
                      : Icons.search_rounded,
                  size: 64.w,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                isDriver ? 'Aucune publication' : 'Aucune réservation',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.slate900,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                isDriver
                    ? 'Proposez vos places libres et économisez sur vos frais de voyage.'
                    : 'Recherchez un trajet pour votre prochain déplacement interurbain.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.slate500,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 32.h),
              if (!isDriver)
                PrimaryButton(
                  text: "Rechercher un trajet",
                  onPressed: () {},
                ), // Add navigation
              if (isDriver)
                PrimaryButton(text: "Publier un trajet", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  ({String text, Color color, Color bgColor, IconData icon}) _getStatus(
    int index,
  ) {
    if (index % 3 == 1) {
      return (
        text: "Terminé",
        color: AppColors.success,
        bgColor: AppColors.success.withValues(alpha: 0.1),
        icon: Icons.check_circle_rounded,
      );
    } else if (index % 3 == 2) {
      return (
        text: "Annulé",
        color: AppColors.error,
        bgColor: AppColors.error.withValues(alpha: 0.1),
        icon: Icons.cancel_rounded,
      );
    }
    return (
      text: "À venir",
      color: AppColors.primary,
      bgColor: AppColors.primary.withValues(alpha: 0.1),
      icon: Icons.schedule_rounded,
    );
  }
}
