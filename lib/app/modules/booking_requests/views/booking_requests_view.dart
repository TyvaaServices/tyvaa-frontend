import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/booking_requests_controller.dart';

class BookingRequestsView extends GetView<BookingRequestsController> {
  const BookingRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        title: const Text('Demandes'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/ic_back.png',
            width: 24.w,
            color: AppColors.textMain,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.bookings.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/img_empty_requests.png',
                  height: 200.h,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.inbox, size: 80, color: AppColors.slate200),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Aucune demande',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Vos demandes de réservation apparaîtront ici.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.slate500,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadPendingBookings,
          color: AppColors.primary,
          child: ListView.builder(
            itemCount: controller.bookings.length,
            padding: EdgeInsets.all(24.w),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final booking = controller.bookings[index];
              return _buildBookingCard(context, booking);
            },
          ),
        );
      }),
    );
  }

  Widget _buildBookingCard(BuildContext context, dynamic booking) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: AppColors.slate100,
                  backgroundImage: const AssetImage(
                    'assets/icons/nav_profile.png',
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Passager',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.slate400,
                        ),
                      ),
                      Text(
                        'Passager #${booking.passagerId.substring(0, 5)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'En attente',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            const Divider(),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoRow(
                  context,
                  'Places demandées',
                  '${booking.nombrePlacesReservees}',
                ),
                _buildInfoRow(
                  context,
                  'Total',
                  '${booking.montantTotal?.toStringAsFixed(0)} FCFA',
                  isBold: true,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => controller.rejectBooking(booking.remoteId),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text('Refuser'),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.acceptBooking(booking.remoteId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text('Accepter'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.05, end: 0);
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: AppColors.slate400,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            color: isBold ? AppColors.primary : AppColors.textMain,
          ),
        ),
      ],
    );
  }
}
