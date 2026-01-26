import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../core/widgets/custom_otp_field.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Obx(
          () => controller.currentStep.value > 0
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.slate900,
                  ),
                  onPressed: controller.prevStep,
                )
              : const SizedBox.shrink(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Obx(() {
          if (controller.currentStep.value < 2) return const SizedBox.shrink();
          return SizedBox(
            width: 150.w,
            child: LinearProgressIndicator(
              value:
                  (controller.currentStep.value - 1) /
                  3, // Normalized for profile steps
              backgroundColor: AppColors.slate100,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              borderRadius: BorderRadius.circular(4.r),
            ),
          );
        }),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildCurrentStep(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep(BuildContext context) {
    switch (controller.currentStep.value) {
      case 0:
        return _buildPhoneStep(context);
      case 1:
        return _buildOtpStep(context);
      case 2:
        return _buildNameStep(context);
      case 3:
        return _buildEmailStep(context);
      case 4:
        return _buildFinalStep(context);
      default:
        return const SizedBox.shrink();
    }
  }

  // Step 0: Phone
  Widget _buildPhoneStep(BuildContext context) {
    return Column(
      key: const ValueKey(0),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20.h),
        Text(
          "Quel est votre numéro ?",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 32.h),
        SenegalPhoneField(
          label: 'Numéro de mobile',
          controller: controller.phoneController,
        ),
        SizedBox(height: 16.h),
        Text(
          "Nous vous enverrons un code par SMS pour vérifier votre numéro.",
          style: TextStyle(color: AppColors.slate500, fontSize: 13.sp),
        ),
        const Spacer(),
        PrimaryButton(
          text: "Continuer",
          isLoading: controller.isLoading.value,
          onPressed: controller.submitPhone,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  // Step 1: OTP
  Widget _buildOtpStep(BuildContext context) {
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20.h),
        Text(
          "Entrez le code",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        Text(
          "Envoyé au ${controller.phoneController.text}",
          style: TextStyle(color: AppColors.slate500, fontSize: 14.sp),
        ),
        SizedBox(height: 32.h),
        CustomOtpField(
          controller: controller.otpController,
          length: 6,
          onCompleted: (_) => controller.verifyOtp(),
        ),
        const Spacer(),
        PrimaryButton(
          text: "Vérifier",
          isLoading: controller.isLoading.value,
          onPressed: controller.verifyOtp,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  // Step 2: Name
  Widget _buildNameStep(BuildContext context) {
    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20.h),
        Text(
          "Comment vous appelez-vous ?",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 32.h),
        CustomTextField(
          label: "Prénom",
          controller: controller.firstNameController,
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          label: "Nom",
          controller: controller.lastNameController,
        ),
        const Spacer(),
        PrimaryButton(text: "Suivant", onPressed: controller.submitName),
        SizedBox(height: 20.h),
      ],
    );
  }

  // Step 3: Email
  Widget _buildEmailStep(BuildContext context) {
    return Column(
      key: const ValueKey(3),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20.h),
        Text(
          "Quel est votre email ?",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 32.h),
        CustomTextField(
          label: "Email",
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16.h),
        Text(
          "Pour recevoir vos reçus de voyage.",
          style: TextStyle(color: AppColors.slate500, fontSize: 13.sp),
        ),
        const Spacer(),
        PrimaryButton(text: "Suivant", onPressed: controller.submitEmail),
        SizedBox(height: 20.h),
      ],
    );
  }

  // Step 4: DOB & Gender
  Widget _buildFinalStep(BuildContext context) {
    return Column(
      key: const ValueKey(4),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20.h),
        Text(
          "Quelques détails en plus",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 32.h),

        // DOB Input (Mock Picker)
        GestureDetector(
          onTap: () async {
            // Mock Date Picker
            controller.dobController.text = "01/01/1995";
          },
          child: AbsorbPointer(
            child: CustomTextField(
              label: "Date de naissance",
              hint: "JJ/MM/AAAA",
              controller: controller.dobController,
              prefixIcon: Icon(Icons.cake_outlined, color: AppColors.slate400),
            ),
          ),
        ),

        SizedBox(height: 24.h),

        // Gender Selector
        Text(
          "Genre",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
        SizedBox(height: 12.h),
        Obx(
          () => Row(
            children: [
              _buildGenderChip("Mme", "Female"),
              SizedBox(width: 12.w),
              _buildGenderChip("M.", "Male"),
              SizedBox(width: 12.w),
              _buildGenderChip("Autre", "Other"),
            ],
          ),
        ),

        const Spacer(),
        PrimaryButton(
          text: "Terminer",
          isLoading: controller.isLoading.value,
          onPressed: controller.completeRegistration,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildGenderChip(String label, String value) {
    final isSelected = controller.selectedGender.value == value;
    return GestureDetector(
      onTap: () => controller.selectedGender.value = value,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.slate200,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.slate600,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
