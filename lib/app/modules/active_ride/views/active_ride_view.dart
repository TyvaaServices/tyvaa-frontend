import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/active_ride_controller.dart';

class ActiveRideView extends GetView<ActiveRideController> {
  const ActiveRideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        title: const Text('Détails du trajet'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.slate900),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // 1. Logistics Summary Card (Meeting Point focus)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.slate900.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Itinerary
                  Row(
                    children: [
                      _buildPoint("DE", "Dakar", "11:30", AppColors.primary),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: [
                              Text(
                                "3h 45m",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.slate400,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: List.generate(
                                  15,
                                  (index) => Expanded(
                                    child: Container(
                                      height: 1.5,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 1.w,
                                      ),
                                      color: index % 2 == 0
                                          ? AppColors.slate200
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Icon(
                                Icons.directions_car_rounded,
                                size: 16.w,
                                color: AppColors.slate300,
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildPoint(
                        "À",
                        "Saint-Louis",
                        "15:15",
                        AppColors.secondary,
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  // Meeting Point Highlight
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: AppColors.primary,
                          size: 24.w,
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lieu de rendez-vous",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Gare routière des Baux Maraîchers",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.slate900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Driver & Vehicle Info
                  _buildSectionTitle("Conducteur & Véhicule"),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28.r,
                          backgroundColor: AppColors.primary.withValues(
                            alpha: 0.1,
                          ),
                          child: Text(
                            "AS",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Arjun Singh",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    size: 14.w,
                                    color: AppColors.warning,
                                  ),
                                  Text(
                                    " 4.8",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Text(
                                    " • Toyota Corolla",
                                    style: TextStyle(
                                      color: AppColors.slate500,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Plage: DK-234-AA",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildCircleAction(
                          Icons.phone_rounded,
                          AppColors.success,
                          () {},
                        ),
                        SizedBox(width: 12.w),
                        _buildCircleAction(
                          Icons.message_rounded,
                          AppColors.primary,
                          () {},
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // 3. Passenger List
                  _buildSectionTitle("Passagers (3/4)"),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Column(
                      children: [
                        _buildPassengerItem("Moi", true),
                        const Divider(height: 24),
                        _buildPassengerItem("Fatou Diop", false),
                        const Divider(height: 24),
                        _buildPassengerItem("Moussa Sow", false),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // 4. Safety & Tools
                  _buildSectionTitle("Sécurité & Options"),
                  SizedBox(height: 12.h),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 2.5,
                    children: [
                      _buildActionTile(
                        Icons.sos_rounded,
                        "Appel d'urgence",
                        AppColors.error,
                      ),
                      _buildActionTile(
                        Icons.share_rounded,
                        "Partager trajet",
                        AppColors.info,
                      ),
                      _buildActionTile(
                        Icons.help_outline_rounded,
                        "Centre d'aide",
                        AppColors.slate600,
                      ),
                      _buildActionTile(
                        Icons.cancel_outlined,
                        "Annuler",
                        AppColors.slate400,
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoint(String label, String city, String time, Color color) {
    return Column(
      crossAxisAlignment: label == "DE"
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: AppColors.slate400,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.slate900,
          ),
        ),
        Text(
          city,
          style: TextStyle(
            fontSize: 14.sp,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w800,
          color: AppColors.slate800,
        ),
      ),
    );
  }

  Widget _buildPassengerItem(String name, bool isMe) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16.r,
          backgroundColor: AppColors.slate100,
          child: Text(
            name.substring(0, 1),
            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          name,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isMe ? FontWeight.w700 : FontWeight.w500,
            color: AppColors.slate800,
          ),
        ),
        if (isMe) ...[
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              "VOUS",
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.success,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCircleAction(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20.w, color: color),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.w, color: color),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
