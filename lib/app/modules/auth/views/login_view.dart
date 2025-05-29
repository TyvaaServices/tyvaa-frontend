// lib/app/ui/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:passenger_tyvaa/app/modules/auth/views/register_view.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    var width = Get.width;
    var height = Get.height;

    return Scaffold(
      backgroundColor: TColors.background(context),
      body: Stack(
        children: [
          Positioned(
            top: -height * .15,
            right: -width * .2,
            child: Container(
              width: Get.width * .8,
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

          GestureDetector(
            onTap: () {
              Get.focusScope?.unfocus();
            },
            behavior: HitTestBehavior.translucent,
            child: SafeArea(
              child: SingleChildScrollView(
                controller: controller.scrollController,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: FadeTransition(
                    opacity: controller.fadeInAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.asset(
                            'assets/login_illustration.png',
                            fit: BoxFit.contain,
                            height:
                                Get.bottomBarHeight > 0
                                    ? Get.height * 0.2
                                    : Get.height * 0.35,
                          ),
                        ),

                        Text(
                          'Bienvenue',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: TColors.textPrimary(context),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          'Connectez-vous avec votre numéro pour accéder à votre compte',
                          style: TextStyle(
                            fontSize: 16,
                            color: TColors.textSecondary(context),
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: height * .03),

                        Form(
                          key: controller.formKey,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                            margin: EdgeInsets.only(
                              bottom: Get.bottomBarHeight * 0.5,
                            ),
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
                                      border: Border.all(
                                        color: TColors.neutral300,
                                      ),
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
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: Image.asset(
                                                    'assets/flags/sn.png',
                                                    width: 24,
                                                    height: 18,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stack,
                                                        ) => Icon(
                                                          Icons.flag_rounded,
                                                          color:
                                                              TColors.primary,
                                                        ),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Text(
                                                  'Sénégal (+221)',
                                                  style: TextStyle(
                                                    color: TColors.textPrimary(
                                                      context,
                                                    ),
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
                                  SizedBox(height: Get.height * 0.02),
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
                                      focusNode: controller.phoneFocus,
                                      controller: controller.phoneController,
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
                                            controller.hasInput
                                                ? Icon(
                                                  controller.isValid
                                                      ? Icons.check_circle
                                                      : Icons.error,
                                                  color:
                                                      controller.isValid
                                                          ? Colors.green
                                                          : Colors.red,
                                                )
                                                : null,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          borderSide: BorderSide(
                                            color:
                                                controller.hasInput
                                                    ? (controller.isValid
                                                        ? Colors.green
                                                        : Colors.red)
                                                    : TColors.neutral300,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          borderSide: BorderSide(
                                            color: TColors.primary,
                                            width: 2,
                                          ),
                                        ),
                                        errorStyle: TextStyle(
                                          color: Colors.red[700],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.red[400]!,
                                            width: 1.5,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.red[700]!,
                                            width: 2,
                                          ),
                                        ),

                                        filled: true,
                                        fillColor: TColors.neutral200,
                                      ),
                                      validator:
                                          (_) =>
                                              controller.isValid
                                                  ? null
                                                  : 'Veuillez entrer un numéro valide',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: Get.height * 0.02),

                        // Bouton de connexion
                        Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: TColors.primary.withOpacity(.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            width: double.infinity,
                            height: Get.height * 0.07,
                            child: ElevatedButton(
                              onPressed:
                                  controller.isLoading.value
                                      ? null
                                      : controller.handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: TColors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                              ),
                              child:
                                  controller.isLoading.value
                                      ? const SpinKitThreeBounce(
                                        color: Colors.white,
                                        size: 20,
                                      )
                                      : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          SizedBox(width: 12),
                                          Text(
                                            'Continuer avec WhatsApp',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                            ),
                          ),
                        ),

                        SizedBox(height: Get.height * 0.01),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Get.to(() => RegisterScreen());
                            },
                            child: Text(
                              'S\'inscrire',
                              style: TextStyle(
                                color: TColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
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
          ),

          // Overlay loading
          Obx(
            () =>
                controller.isLoading.value
                    ? Container(
                      color: Colors.black.withOpacity(.6),
                      child: Center(
                        child: Container(
                          width: width * .8,
                          padding: const EdgeInsets.symmetric(
                            vertical: 32,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            color: TColors.surface(context),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.asset(
                                'assets/animations/loading.json',
                                width: 120,
                                height: 120,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Vérification en cours...',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: TColors.textPrimary(context),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Nous préparons votre compte',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: TColors.textSecondary(context),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
