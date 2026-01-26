import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/my_bookings_controller.dart';

class MyBookingsView extends GetView<MyBookingsController> {
  const MyBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        title: const Text('Mes Réservations'),
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
            child: Padding(
              padding: EdgeInsets.all(40.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/img_empty_history.png',
                    height: 200.h,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.bookmark_border,
                      size: 80,
                      color: AppColors.slate200,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Aucune réservation',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Retrouvez ici tous les trajets que vous avez réservés.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.slate500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadBookings,
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
    final isConfirmed = booking.statut == 'confirmee';

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Réservation',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.slate400,
                      ),
                    ),
                    Text(
                      '#${booking.trajetId.substring(0, 8)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: (isConfirmed ? AppColors.success : AppColors.warning)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    isConfirmed ? 'Confirmée' : 'En attente',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: isConfirmed
                          ? AppColors.success
                          : AppColors.warning,
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
                _buildInfoCol(
                  context,
                  'Places',
                  '${booking.nombrePlacesReservees}',
                ),
                _buildInfoCol(
                  context,
                  'Total',
                  '${booking.montantTotal?.toStringAsFixed(0)} FCFA',
                  isPrimary: true,
                ),
              ],
            ),
            if (booking.statut == 'en_attente') ...[
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => controller.cancelBooking(booking.remoteId),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: const Text('Annuler la réservation'),
                ),
              ),
            ],
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _buildInfoCol(
    BuildContext context,
    String label,
    String value, {
    bool isPrimary = false,
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
            color: isPrimary ? AppColors.primary : AppColors.textMain,
            fontWeight: isPrimary ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
