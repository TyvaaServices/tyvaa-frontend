import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller; // Init controller

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Elements (Optional subtle patterns)
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300.w,
              height: 300.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
          ),

          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),

                  // 1. Hero Illustration
                  // Using the new asset
                  Image.asset(
                        'assets/images/img_splash_hero.png',
                        width: 300.w,
                        height: 300.w,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Container(
                          width: 200.w,
                          height: 200.w,
                          color: AppColors.slate100,
                          child: Icon(
                            Icons.broken_image,
                            color: AppColors.slate400,
                          ),
                        ), // Fallback if asset missing
                      )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        curve: Curves.easeOutBack,
                      ),

                  SizedBox(height: 40.h),

                  // 2. Brand Name
                  Text(
                    'TYVAA',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColors.primary,
                      letterSpacing: 2, // Tighter tracking for modern look
                      fontWeight: FontWeight.w900, // Bolder
                      fontSize: 42.sp,
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),

                  SizedBox(height: 12.h),

                  // 3. Tagline
                  Text(
                    'Voyagez ensemble, voyagez mieux.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.slate500),
                  ).animate().fadeIn(delay: 500.ms),

                  const Spacer(flex: 2),

                  // 4. Loading Spinner (Minimal)
                  SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),

                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
