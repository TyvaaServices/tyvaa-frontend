import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:passenger_tyvaa/app/modules/permissions/controllers/location_permission_controller.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';

class LocationPermissionScreen extends GetView<LocationPermissionController> {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -Get.height * .15,
            right: -Get.width * .2,
            child: Container(
              width: Get.width * .8,
              height: Get.width * .8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor.withOpacity(.1),
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
                color: AppColors.primaryColor.withOpacity(.08),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: Get.height * 0.06),
                          SizedBox(
                            width: Get.width * 0.6,
                            height: Get.width * 0.6,
                            child: Lottie.asset(
                              'assets/animations/location_permission.json',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.03),
                          Text(
                            'Activer la localisation',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Get.height * 0.015),
                          Text(
                            'Pour vous offrir la meilleure expérience, Tyvaa a besoin d\'accéder à votre position',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Button at bottom
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 64, // taller button
                        child: ElevatedButton(
                          onPressed:
                              () => controller.requestLocationPermission(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Activer la localisation',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => controller.skipPermission(),
                        child: Text(
                          'Plus tard',
                          style: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
