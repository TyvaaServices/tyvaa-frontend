import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/ride_detail_controller.dart';

class RideDetailView extends GetView<RideDetailController> {
  const RideDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/icons/ic_back.png',
                  width: 18.w,
                  color: AppColors.slate900,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.share_outlined,
                size: 20.w,
                color: AppColors.slate900,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final ride = controller.ride.value;
        if (ride == null)
          return const Center(child: CircularProgressIndicator());

        final dateStr = ride.dateDepart != null
            ? DateFormat('EEEE d MMMM', 'fr').format(ride.dateDepart!)
            : 'Date inconnue';
        final timeStr = ride.dateDepart != null
            ? DateFormat('HH:mm').format(ride.dateDepart!)
            : '--:--';
        final pricePerSeat = ride.prixTotal ?? 0;
        final commission = ride.commission ?? (pricePerSeat * 0.1);
        final seats = controller.seatsToBook.value;
        final totalTripPrice = pricePerSeat * seats;

        return Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // 1. HERO HEADER (Cities & Time)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(24.w, 120.h, 24.w, 40.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.15),
                          AppColors.slate50,
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timeStr,
                          style: TextStyle(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                            letterSpacing: -2,
                          ),
                        ),
                        Text(
                          dateStr.toUpperCase(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.slate500,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                ride.villeDepart,
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.slate900,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child:
                                  Image.asset(
                                    'assets/icons/ic_back.png',
                                    width: 24.w,
                                    color: AppColors.primary,
                                  ).animate().rotate(
                                    begin: 0.5,
                                    end: 0.5,
                                  ), // Facing right
                            ),
                            Expanded(
                              child: Text(
                                ride.villeArrivee,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.slate900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 2. MAIN CONTENT
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        // A. Logistics Card
                        _buildGlassCard(
                          child: Column(
                            children: [
                              _buildLocationRow(
                                "Point de départ",
                                "Dakar, Gare des Baux Maraîchers",
                                AppColors.primary,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Divider(
                                  color: AppColors.slate100,
                                  indent: 44.w,
                                ),
                              ),
                              _buildLocationRow(
                                "Point d'arrivée",
                                "Saint-Louis, Centre ville",
                                AppColors.secondary,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // B. Driver Card
                        _buildGlassCard(
                          child: Row(
                            children: [
                              Container(
                                width: 60.w,
                                height: 60.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.2,
                                    ),
                                    width: 3,
                                  ),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/icons/nav_profile.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          ride.driverName,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.slate900,
                                          ),
                                        ),
                                        SizedBox(width: 6.w),
                                        Icon(
                                          Icons.verified_rounded,
                                          size: 18.w,
                                          color: AppColors.secondary,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          size: 16.w,
                                          color: AppColors.warning,
                                        ),
                                        Text(
                                          " 4.9 • 156 avis",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.slate500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              _buildIconButton(
                                'assets/icons/ic_chat.png',
                                AppColors.primary,
                                () {},
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // C. Vehicle & Preferences
                        _buildGlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow(
                                'Véhicule',
                                ride.carModel,
                                Icons.directions_car_filled_outlined,
                              ),
                              const Divider(height: 32),
                              Text(
                                "Préférences de voyage",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.slate900,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Wrap(
                                spacing: 12.w,
                                runSpacing: 12.h,
                                children: [
                                  _buildPrefChip(
                                    Icons.ac_unit_rounded,
                                    "Climatisation",
                                  ),
                                  _buildPrefChip(
                                    Icons.luggage_rounded,
                                    "Bagage moyen",
                                  ),
                                  _buildPrefChip(
                                    Icons.smoke_free_rounded,
                                    "Non-fumeur",
                                  ),
                                  _buildPrefChip(
                                    Icons.health_and_safety_rounded,
                                    "COVID Safe",
                                    color: AppColors.success,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // D. Payment Breakdown
                        _buildGlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Détails du paiement",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.slate900,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              _buildPriceRow(
                                "Acompte (via App)",
                                "${(commission * seats).toStringAsFixed(0)} F",
                                isBold: true,
                                color: AppColors.primary,
                              ),
                              SizedBox(height: 12.h),
                              _buildPriceRow(
                                "Au conducteur (Cash)",
                                "${(totalTripPrice - (commission * seats)).toStringAsFixed(0)} F",
                              ),
                              const Divider(height: 32),
                              _buildPriceRow(
                                "Total Voyage",
                                "${totalTripPrice.toStringAsFixed(0)} FCFA",
                                isTotal: true,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 140.h), // Spacing for bottom bar
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 3. STICKY BOOKING BAR (Floating Modern Design)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 40.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.slate900.withValues(alpha: 0.1),
                      blurRadius: 30,
                      offset: const Offset(0, -10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Seat Counter
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.slate100,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          _buildSmallBtn(
                            Icons.remove,
                            controller.decrementSeats,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              "$seats",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          _buildSmallBtn(Icons.add, controller.incrementSeats),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // Booking Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.bookRide,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          elevation: 8,
                          shadowColor: AppColors.primary.withValues(alpha: 0.4),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "Réserver pour ${totalTripPrice.toStringAsFixed(0)} F",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate900.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildLocationRow(String label, String address, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 3),
              ),
            ),
          ],
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate400,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                address,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.slate900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.slate100,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18.w, color: AppColors.slate700),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColors.slate500,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.slate900,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrefChip(IconData icon, String label, {Color? color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: (color ?? AppColors.slate700).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.w, color: color ?? AppColors.slate700),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: color ?? AppColors.slate700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String value, {
    bool isBold = false,
    bool isTotal = false,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal || isBold ? FontWeight.w800 : FontWeight.w500,
            color: isTotal ? AppColors.slate900 : AppColors.slate500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20.sp : 15.sp,
            fontWeight: isTotal || isBold ? FontWeight.w900 : FontWeight.w700,
            color: color ?? AppColors.slate900,
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(String asset, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Image.asset(asset, width: 20.w, color: color),
      ),
    );
  }

  Widget _buildSmallBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: 22.w, color: AppColors.slate900),
    );
  }
}
