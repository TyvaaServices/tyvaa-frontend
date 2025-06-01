// lib/app/modules/auth/views/register_view.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';
import 'package:passenger_tyvaa/generated/assets.dart';

import '../controllers/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final width = Get.width;
    final height = Get.height;

    return Scaffold(
      backgroundColor: TColors.background(context),
      body: Stack(
        children: [
          // Background decorations
          _buildBackgroundDecorations(width, height),

          // Main content
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                _buildProgressIndicator(),
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      controller.currentStep.value = index;
                    },
                    children: [
                      _buildPhoneStep(context),
                      _buildNameStep(context),
                      _buildDetailsStep(context),
                    ],
                  ),
                ),
                _buildNavigationButtons(context),
              ],
            ),
          ),

          // Loading overlay
          _buildLoadingOverlay(context, width),
        ],
      ),
    );
  }

  Widget _buildBackgroundDecorations(double width, double height) {
    return Stack(
      children: [
        Positioned(
          top: -height * .15,
          right: -width * .2,
          child: Container(
            width: width * .8,
            height: width * .8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: TColors.primary.withOpacity(.1),
            ),
          ),
        ),
        Positioned(
          bottom: -height * .1,
          left: -width * .15,
          child: Container(
            width: width * .7,
            height: width * .7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: TColors.primary.withOpacity(.08),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSpacing.lg),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: TColors.textPrimary(context),
            ),
          ),
          Expanded(
            child: Text(
              'Créer un compte',
              style: TTypography.headingLarge(context),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSpacing.lg),
        child: Row(
          children: List.generate(3, (index) {
            final isActive = index <= controller.currentStep.value;

            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: index < 2 ? TSpacing.sm : 0),
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(TRadius.xs),
                  color: isActive ? TColors.primary : TColors.neutral300,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPhoneStep(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(TSpacing.lg),
        child: FadeTransition(
          opacity: controller.fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset(
                  Assets.assetsRegisterIllustration,
                  fit: BoxFit.contain,
                  height:
                      Get.bottomBarHeight > 0 ? height * 0.2 : height * 0.35,
                ),
              ),

              Text(
                'Créer un compte',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: TColors.textPrimary(context),
                ),
              ),

              SizedBox(height: height * 0.02),

              Text(
                'Entrez votre numéro de téléphone pour créer votre compte',
                style: TextStyle(
                  fontSize: 16,
                  color: TColors.textSecondary(context),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: height * 0.03),

              Form(
                key: controller.formKeys[0],
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: TColors.surface(context),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pays',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: TColors.textSecondary(context),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: TColors.neutral300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: '+221',
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: TColors.primary,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: '+221',
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.asset(
                                        Assets.flagsSn,
                                        width: 24,
                                        height: 18,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stack) => Icon(
                                              Icons.flag_rounded,
                                              color: TColors.primary,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Sénégal (+221)',
                                      style: TextStyle(
                                        color: TColors.textPrimary(context),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onChanged: (_) {},
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.02),

                      Text(
                        'Numéro de téléphone',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: TColors.textSecondary(context),
                        ),
                      ),
                      const SizedBox(height: 8),

                      Obx(
                        () => TextFormField(
                          controller: controller.phoneController,
                          focusNode: controller.phoneFocus,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [controller.phoneMask],
                          style: TextStyle(
                            fontSize: 16,
                            color: TColors.textPrimary(context),
                          ),
                          decoration: InputDecoration(
                            hintText: '78 277 55 79',
                            hintStyle: TextStyle(
                              color: TColors.textSecondary(
                                context,
                              ).withOpacity(.7),
                            ),
                            prefixIcon: Icon(
                              Icons.phone_android_rounded,
                              color: TColors.primary,
                            ),
                            suffixIcon:
                                controller.hasPhoneInput.value
                                    ? Icon(
                                      controller.isPhoneValid.value
                                          ? Icons.check_circle
                                          : Icons.error,
                                      color:
                                          controller.isPhoneValid.value
                                              ? Colors.green
                                              : Colors.red,
                                    )
                                    : null,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color:
                                    controller.hasPhoneInput.value
                                        ? (controller.isPhoneValid.value
                                            ? Colors.green
                                            : Colors.red)
                                        : TColors.neutral300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: TColors.primary,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.red[400]!,
                                width: 1.5,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.red[700]!,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: TColors.neutral200,
                          ),
                          validator: (value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Veuillez entrer votre numéro';
                            }
                            if (!controller.isPhoneValid.value) {
                              return 'Numéro de téléphone invalide';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameStep(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSpacing.xl),
          Text('Vos informations', style: TTypography.displaySmall(context)),
          const SizedBox(height: TSpacing.sm),
          Text(
            'Dites-nous comment vous appeler',
            style: TTypography.bodyMedium(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
          ),
          const SizedBox(height: TSpacing.xl),

          Form(
            key: controller.formKeys[1],
            child: Container(
              padding: const EdgeInsets.all(TSpacing.lg),
              decoration: BoxDecoration(
                color: TColors.surface(context),
                borderRadius: BorderRadius.circular(TRadius.xl),
                boxShadow: TShadows.subtle,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prénom',
                    style: TTypography.labelMedium(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                  const SizedBox(height: TSpacing.sm),
                  TextFormField(
                    controller: controller.firstNameController,
                    focusNode: controller.firstNameFocus,
                    textCapitalization: TextCapitalization.words,
                    style: TTypography.bodyMedium(context),
                    decoration: InputDecoration(
                      hintText: 'Votre prénom',
                      hintStyle: TTypography.bodyMedium(context).copyWith(
                        color: TColors.textSecondary(context).withOpacity(.7),
                      ),
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        color: TColors.primary,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        borderSide: BorderSide(color: TColors.neutral300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        borderSide: BorderSide(
                          color: TColors.primary,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        borderSide: BorderSide(color: TColors.error),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        borderSide: BorderSide(color: TColors.error, width: 2),
                      ),
                      filled: true,
                      fillColor: TColors.neutral200,
                    ),
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Veuillez entrer votre prénom';
                      }
                      if (value!.trim().length < 2) {
                        return 'Le prénom doit contenir au moins 2 caractères';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: TSpacing.lg),
                  Text(
                    'Nom de famille',
                    style: TTypography.labelMedium(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                  const SizedBox(height: TSpacing.sm),
                  TextFormField(
                    controller: controller.lastNameController,
                    focusNode: controller.lastNameFocus,
                    textCapitalization: TextCapitalization.words,
                    style: TTypography.bodyMedium(context),
                    decoration: InputDecoration(
                      hintText: 'Votre nom de famille',
                      hintStyle: TTypography.bodyMedium(context).copyWith(
                        color: TColors.textSecondary(context).withOpacity(.7),
                      ),
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        color: TColors.primary,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        borderSide: BorderSide(color: TColors.neutral300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        borderSide: BorderSide(
                          color: TColors.primary,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        borderSide: BorderSide(color: TColors.error),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        borderSide: BorderSide(color: TColors.error, width: 2),
                      ),
                      filled: true,
                      fillColor: TColors.neutral200,
                    ),
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Veuillez entrer votre nom de famille';
                      }
                      if (value!.trim().length < 2) {
                        return 'Le nom doit contenir au moins 2 caractères';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsStep(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSpacing.xl),
          Text('Quelques détails', style: TTypography.displaySmall(context)),
          const SizedBox(height: TSpacing.sm),
          Text(
            'Pour finaliser votre profil',
            style: TTypography.bodyMedium(
              context,
            ).copyWith(color: TColors.textSecondary(context)),
          ),
          const SizedBox(height: TSpacing.xl),

          Form(
            key: controller.formKeys[2],
            child: Container(
              padding: const EdgeInsets.all(TSpacing.lg),
              decoration: BoxDecoration(
                color: TColors.surface(context),
                borderRadius: BorderRadius.circular(TRadius.xl),
                boxShadow: TShadows.subtle,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date de naissance',
                    style: TTypography.labelMedium(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                  const SizedBox(height: TSpacing.sm),
                  Obx(
                    () => GestureDetector(
                      onTap: () => controller.selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.all(TSpacing.md),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(TRadius.lg),
                          border: Border.all(
                            color:
                                controller.selectedDate.value != null
                                    ? TColors.primary
                                    : TColors.neutral300,
                          ),
                          color: TColors.neutral200,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              color: TColors.primary,
                            ),
                            const SizedBox(width: TSpacing.md),
                            Expanded(
                              child: Text(
                                controller.selectedDate.value != null
                                    ? '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}'
                                    : 'Sélectionnez votre date de naissance',
                                style: TTypography.bodyMedium(context).copyWith(
                                  color:
                                      controller.selectedDate.value != null
                                          ? TColors.textPrimary(context)
                                          : TColors.textSecondary(
                                            context,
                                          ).withOpacity(.7),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              color: TColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSpacing.lg),
                  Text(
                    'Genre',
                    style: TTypography.labelMedium(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                  const SizedBox(height: TSpacing.sm),
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.selectGender('Homme'),
                            child: Container(
                              padding: const EdgeInsets.all(TSpacing.md),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(TRadius.lg),
                                border: Border.all(
                                  color:
                                      controller.selectedGender.value == 'Homme'
                                          ? TColors.primary
                                          : TColors.neutral300,
                                ),
                                color:
                                    controller.selectedGender.value == 'Homme'
                                        ? TColors.primary.withOpacity(.1)
                                        : TColors.neutral200,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.male_rounded,
                                    color:
                                        controller.selectedGender.value ==
                                                'Homme'
                                            ? TColors.primary
                                            : TColors.textSecondary(context),
                                  ),
                                  const SizedBox(width: TSpacing.sm),
                                  Text(
                                    'Homme',
                                    style: TTypography.bodyMedium(
                                      context,
                                    ).copyWith(
                                      color:
                                          controller.selectedGender.value ==
                                                  'Homme'
                                              ? TColors.primary
                                              : TColors.textSecondary(context),
                                      fontWeight:
                                          controller.selectedGender.value ==
                                                  'Homme'
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: TSpacing.md),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.selectGender('Femme'),
                            child: Container(
                              padding: const EdgeInsets.all(TSpacing.md),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(TRadius.lg),
                                border: Border.all(
                                  color:
                                      controller.selectedGender.value == 'Femme'
                                          ? TColors.primary
                                          : TColors.neutral300,
                                ),
                                color:
                                    controller.selectedGender.value == 'Femme'
                                        ? TColors.primary.withOpacity(.1)
                                        : TColors.neutral200,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.female_rounded,
                                    color:
                                        controller.selectedGender.value ==
                                                'Femme'
                                            ? TColors.primary
                                            : TColors.textSecondary(context),
                                  ),
                                  const SizedBox(width: TSpacing.sm),
                                  Text(
                                    'Femme',
                                    style: TTypography.bodyMedium(
                                      context,
                                    ).copyWith(
                                      color:
                                          controller.selectedGender.value ==
                                                  'Femme'
                                              ? TColors.primary
                                              : TColors.textSecondary(context),
                                      fontWeight:
                                          controller.selectedGender.value ==
                                                  'Femme'
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSpacing.lg),
                  Text(
                    'Email (optionnel)',
                    style: TTypography.labelMedium(
                      context,
                    ).copyWith(color: TColors.textSecondary(context)),
                  ),
                  const SizedBox(height: TSpacing.sm),
                  TextFormField(
                    controller: controller.emailController,
                    focusNode: controller.emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    style: TTypography.bodyMedium(context),
                    decoration: InputDecoration(
                      hintText: 'votre@email.com',
                      hintStyle: TTypography.bodyMedium(context).copyWith(
                        color: TColors.textSecondary(context).withOpacity(.7),
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: TColors.primary,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        borderSide: BorderSide(color: TColors.neutral300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        borderSide: BorderSide(
                          color: TColors.primary,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        borderSide: BorderSide(color: TColors.error),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TRadius.lg),
                        borderSide: BorderSide(color: TColors.error, width: 2),
                      ),
                      filled: true,
                      fillColor: TColors.neutral200,
                    ),
                    validator: (value) {
                      if (value?.trim().isNotEmpty ?? false) {
                        if (!GetUtils.isEmail(value!.trim())) {
                          return 'Email invalide';
                        }
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(TSpacing.lg),
        child: Row(
          children: [
            if (controller.currentStep.value > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.previousStep,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: TColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TRadius.lg),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: TSpacing.md),
                  ),
                  child: Text(
                    'Précédent',
                    style: TTypography.labelLarge(
                      context,
                    ).copyWith(color: TColors.primary),
                  ),
                ),
              ),
            if (controller.currentStep.value > 0)
              const SizedBox(width: TSpacing.md),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(TRadius.lg),
                  boxShadow: [
                    BoxShadow(
                      color: TColors.primary.withOpacity(.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : () {
                            // Dismiss keyboard
                            FocusScope.of(context).unfocus();
                            controller.nextStep();
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TRadius.lg),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: TSpacing.md),
                    elevation: 0,
                  ),
                  child:
                      controller.isLoading.value
                          ? const SpinKitThreeBounce(
                            color: Colors.white,
                            size: 20,
                          )
                          : Text(
                            controller.currentStep.value < 2
                                ? 'Continuer'
                                : 'Créer le compte',
                            style: TTypography.labelLarge(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingOverlay(BuildContext context, double width) {
    return Obx(
      () =>
          controller.isLoading.value
              ? Container(
                color: Colors.black.withOpacity(.6),
                child: Center(
                  child: Container(
                    width: width * .8,
                    padding: const EdgeInsets.symmetric(
                      vertical: TSpacing.xl,
                      horizontal: TSpacing.lg,
                    ),
                    decoration: BoxDecoration(
                      color: TColors.surface(context),
                      borderRadius: BorderRadius.circular(TRadius.xl),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(
                          Assets.animationsLoading,
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(height: TSpacing.lg),
                        Text(
                          'Création du compte...',
                          style: TTypography.headingMedium(context),
                        ),
                        const SizedBox(height: TSpacing.md),
                        Text(
                          'Nous préparons votre espace personnel',
                          style: TTypography.bodyMedium(
                            context,
                          ).copyWith(color: TColors.textSecondary(context)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              : const SizedBox.shrink(),
    );
  }
}
