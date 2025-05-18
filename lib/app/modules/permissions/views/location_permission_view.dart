import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:passenger_tyvaa/app/modules/permissions/controllers/location_permission_controller.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';

class LocationPermissionScreen extends GetView<LocationPermissionController> {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF2D3142);
    final secondaryTextColor = isDark ? Colors.white70 : const Color(0xFF9194A1);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Decorative background circles
          Positioned(
            top: -Get.height * .15,
            right: -Get.width * .2,
            child: Container(
              width: Get.width * .8,
              height: Get.width * .8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(.1),
              ),
            ),
          ),
          Positioned(
            bottom: -Get.height * .1,
            left: -Get.width * .15,
            child: Container(
              width: Get.width * .7,
              height: Get.width * .7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(.08),
              ),
            ),
          ),

          // Main content - made scrollable to fix overflow
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: Get.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height * 0.02),

                      // Location animation - made responsive with adaptive sizing
                      SizedBox(
                        width: Get.width * 0.6,
                        height: Get.width * 0.6,
                        child: Lottie.asset(
                          'assets/animations/location_permission.json',
                          fit: BoxFit.contain,
                        ),
                      ),

                      SizedBox(height: Get.height * 0.03),

                      // Title
                      Text(
                        'Activer la localisation',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: Get.height * 0.015),

                      // Description
                      Text(
                        'Pour vous offrir la meilleure expérience, Tyvaa a besoin d\'accéder à votre position',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: secondaryTextColor,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),

                      SizedBox(height: Get.height * 0.03),
                      Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () => controller.requestLocationPermission(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Activer la localisation',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: Get.height * 0.02),

                      // Maybe later button
                      TextButton(
                        onPressed: () => controller.skipPermission(),
                        child: Text(
                          'Plus tard',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(height: Get.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
