import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/ride_controller.dart';

class RideView extends GetView<RideController> {
  const RideView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          AppColors.slate50, // Light background for better contrast
      appBar: AppBar(
        title: const Text('Publier un trajet'),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close_rounded, color: AppColors.slate900),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. ITINERARY SECTION
                    _buildSectionHeader(
                      context,
                      "Itinéraire",
                      Icons.map_outlined,
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(20.w),
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
                        children: [
                          _buildInput(
                            context,
                            "D'où partez-vous ?",
                            Icons.circle_outlined,
                            AppColors.primary,
                            controller.fromController,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 11.w),
                            height: 30.h,
                            width: 2.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.slate200,
                                  AppColors.slate200.withValues(alpha: 0.5),
                                ],
                              ),
                            ),
                          ),
                          _buildInput(
                            context,
                            "Où allez-vous ?",
                            Icons.location_on_rounded,
                            AppColors.secondary,
                            controller.toController,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // 2. DATE & TIME
                    _buildSectionHeader(
                      context,
                      "Date et Heure",
                      Icons.calendar_today_rounded,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.pickDate(context),
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(color: AppColors.slate200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.slate500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Obx(
                                    () => Text(
                                      controller.selectedDate.value != null
                                          ? DateFormat(
                                              'EEE d MMM',
                                              'fr',
                                            ).format(
                                              controller.selectedDate.value!,
                                            )
                                          : "Choisir",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.slate900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.pickTime(context),
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(color: AppColors.slate200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Heure",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.slate500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Obx(
                                    () => Text(
                                      controller.selectedTime.value?.format(
                                            context,
                                          ) ??
                                          "Choisir",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.slate900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // 3. PASSENGERS & PRICE
                    Row(
                      children: [
                        // Passengers Counter
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.slate900.withValues(
                                    alpha: 0.04,
                                  ),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Passagers",
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: AppColors.slate500,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildCircleBtn(
                                      Icons.remove,
                                      controller.decrementSeats,
                                    ),
                                    Obx(
                                      () => Text(
                                        "${controller.seatCount.value}",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    _buildCircleBtn(
                                      Icons.add,
                                      controller.incrementSeats,
                                      color: AppColors.primary,
                                      iconColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Price Input
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.slate900.withValues(
                                    alpha: 0.04,
                                  ),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Prix par place",
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: AppColors.slate500,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controller.priceController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primary,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "FCFA",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.slate400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // 4. OPTIONS & VEHICLE
                    _buildSectionHeader(
                      context,
                      "Détails du véhicule",
                      Icons.directions_car_filled_outlined,
                    ),
                    SizedBox(height: 12.h),
                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: ExpansionTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          backgroundColor: Colors.white,
                          collapsedBackgroundColor: Colors.white,
                          tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
                          leading: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: AppColors.slate100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.directions_car_rounded,
                              color: AppColors.slate700,
                              size: 20.w,
                            ),
                          ),
                          title: Obx(
                            () => Text(
                              controller.selectedVehicle.value,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            "Cliquez để thay đổi",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.slate500,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                              child: Column(
                                children: [
                                  _buildVehicleOption(
                                    "Toyota Corolla",
                                    "DK-234-AA",
                                    true,
                                  ),
                                  SizedBox(height: 8.h),
                                  _buildVehicleOption(
                                    "Dacia Logan",
                                    "SL-987-BB",
                                    false,
                                  ),
                                  SizedBox(height: 12.h),
                                  OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add, size: 18),
                                    label: const Text("Ajouter un véhicule"),
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 44.h),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    _buildSectionHeader(
                      context,
                      "Préférences de voyage",
                      Icons.tune_rounded,
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        children: [
                          // Instant Booking
                          Obx(
                            () => SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Réservation Instantanée",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Validation automatique",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.slate500,
                                ),
                              ),
                              activeTrackColor: AppColors.primary,
                              value: controller.instantBooking.value,
                              onChanged: (v) =>
                                  controller.instantBooking.value = v,
                            ),
                          ),
                          Divider(height: 1),
                          // Ladies Only
                          Obx(
                            () => SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                children: [
                                  Text(
                                    "Jigeen ñi dong",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.female_rounded,
                                    size: 18.w,
                                    color: Colors.pinkAccent,
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                "Voyage entre femmes",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.slate500,
                                ),
                              ),
                              activeTrackColor: Colors.pinkAccent,
                              value: controller.ladiesOnly.value,
                              onChanged: (v) => controller.ladiesOnly.value = v,
                            ),
                          ),
                          Divider(height: 1),
                          // Max 2 Back
                          Obx(
                            () => SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Max 2 à l'arrière",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Confort garanti",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.slate500,
                                ),
                              ),
                              activeTrackColor: AppColors.secondary,
                              value: controller.maxTwoBack.value,
                              onChanged: (v) => controller.maxTwoBack.value = v,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // SAFETY NOTE
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.info.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.info.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            color: AppColors.info,
                            size: 20.w,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "En publiant, vous acceptez la Charte de Bonne Conduite Tyvaa.",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.slate700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            // BOTTOM BUTTON
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Obx(
                () => PrimaryButton(
                  text: "Publier le trajet",
                  isLoading: controller.isLoading.value,
                  onPressed: controller.publishRide,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, size: 18.w, color: AppColors.slate400),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.slate500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInput(
    BuildContext context,
    String hint,
    IconData icon,
    Color iconColor,
    TextEditingController ctrl,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20.w, color: iconColor),
        SizedBox(width: 16.w),
        Expanded(
          child: TextField(
            controller: ctrl,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.slate900,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.slate400,
                fontWeight: FontWeight.normal,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircleBtn(
    IconData icon,
    VoidCallback onTap, {
    Color color = AppColors.slate100,
    Color iconColor = AppColors.slate600,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20.w),
      ),
    );
  }

  Widget _buildVehicleOption(String model, String plate, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.selectedVehicle.value = "$model ($plate)",
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.slate100,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.directions_car_rounded,
              color: isSelected ? AppColors.primary : AppColors.slate400,
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    color: isSelected ? AppColors.primary : AppColors.slate800,
                  ),
                ),
                Text(
                  plate,
                  style: TextStyle(fontSize: 11.sp, color: AppColors.slate500),
                ),
              ],
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 20.w,
              ),
          ],
        ),
      ),
    );
  }
}
