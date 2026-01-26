import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/entities/ride.dart';
import '../theme/app_colors.dart';

class RideCard extends StatelessWidget {
  final Ride ride;
  final VoidCallback onTap;

  const RideCard({super.key, required this.ride, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeFormat = DateFormat('HH:mm');
    final startStr = ride.dateDepart != null
        ? timeFormat.format(ride.dateDepart!)
        : '--:--';
    // Mock arrival time (e.g. +3 hours) for visualization if not present
    final endStr = ride.dateDepart != null
        ? timeFormat.format(ride.dateDepart!.add(const Duration(hours: 3)))
        : '--:--';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.slate900.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // 1. Route Timeline & Price
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline (Times + Graphic)
                  Column(
                    children: [
                      Text(
                        startStr,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Expanded(
                        child: Container(width: 2.w, color: AppColors.slate200),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        endStr,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.slate400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 12.w),

                  // Route Graphic (Circles)
                  Column(
                    children: [
                      Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: AppColors.slate900,
                            width: 2.5,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Expanded(
                        child: Container(width: 2.w, color: AppColors.slate200),
                      ), // Dashed line effect implied
                      SizedBox(height: 4.h),
                      Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: const BoxDecoration(
                          color: AppColors.slate900,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.w),

                  // Locations & Price
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ride.villeDepart,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 24.h), // Spacing for timeline
                        Text(
                          ride.villeArrivee,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.slate500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Price & Seats
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${ride.prixTotal?.toStringAsFixed(0)} F',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: ride.nombrePlaces > 0
                              ? AppColors.success.withValues(alpha: 0.1)
                              : AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '${ride.nombrePlaces} places',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: ride.nombrePlaces > 0
                                ? AppColors.success
                                : AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Divider(color: AppColors.slate100, height: 1),
            ),

            // 2. Driver & Trust Info
            Row(
              children: [
                // Avatar
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.slate100,
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/icons/nav_profile.png',
                      ), // Placeholder
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Name & Rating
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          ride.driverName,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.verified_rounded,
                          size: 14.w,
                          color: AppColors.secondary,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 14.w,
                          color: AppColors.warning,
                        ),
                        Text(
                          ' ${ride.driverRating} • Super Driver',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppColors.slate500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.health_and_safety_rounded,
                        size: 14.w,
                        color: AppColors.success,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Safe',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // Amenities Icons
                Icon(
                  Icons.ac_unit_rounded,
                  color: AppColors.slate400,
                  size: 18.w,
                ),
              ],
            ),
          ],
        ),
      ).animate().fadeIn().moveY(begin: 10, end: 0, duration: 400.ms),
    );
  }
}
