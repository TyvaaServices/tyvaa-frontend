import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';

import '../controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.theme.brightness == Brightness.dark
              ? AppColors.darkBackground
              : AppColors.background,
      body: Center(
        child: Obx(
          () => AnimatedOpacity(
            opacity: controller.visibility.value,
            duration: Duration(milliseconds: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with simple reveal animation
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Obx(
                      () => AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: 400),
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 64,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: controller.letterSpacing.value,
                        ),
                        child: Text("T"),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24),

                Obx(
                  () => AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 500),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: controller.letterSpacing.value,
                    ),
                    child: Text(
                      "TYVAA",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
