import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar (Skip)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: controller.skip,
                child: Text(
                  "Passer",
                  style: TextStyle(
                    color: AppColors.slate500,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.contents.length,
                itemBuilder: (context, index) {
                  final content = controller.contents[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Illustration Placeholder
                        Container(
                          height: 250.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.slate50,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Image.asset(
                            content["image"]!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.image,
                              size: 80.w,
                              color: AppColors.slate200,
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Text(
                          content["title"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.slate900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          content["desc"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 1.5,
                            color: AppColors.slate500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Controls
            Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                children: [
                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.contents.length,
                      (index) => Obx(
                        () => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          height: 8.h,
                          width: controller.currentPage.value == index
                              ? 24.w
                              : 8.w,
                          decoration: BoxDecoration(
                            color: controller.currentPage.value == index
                                ? AppColors.primary
                                : AppColors.slate200,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  // Button
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => PrimaryButton(
                        text:
                            controller.currentPage.value ==
                                controller.contents.length - 1
                            ? "COMMENCER"
                            : "SUIVANT",
                        onPressed: controller.nextPage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
