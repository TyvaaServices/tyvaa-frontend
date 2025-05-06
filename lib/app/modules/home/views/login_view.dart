// lib/app/ui/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final backgroundColor =
    isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF2D3142);
    final secondaryTextColor =
    isDark ? Colors.white70 : const Color(0xFF9194A1);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Cercles de fond
          Positioned(
            top: -size.height * .15,
            right: -size.width * .2,
            child: Container(
              width: size.width * .8,
              height: size.width * .8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(.1),
              ),
            ),
          ),
          Positioned(
            bottom: -size.height * .1,
            left: -size.width * .15,
            child: Container(
              width: size.width * .7,
              height: size.width * .7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(.08),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FadeTransition(
                  opacity: controller.fadeInAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/login_illustration.png',
                        height: 350,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Bienvenue',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Connectez-vous avec votre numéro pour accéder à votre compte',
                        style: TextStyle(
                            fontSize: 16,
                            color: secondaryTextColor,
                            height: 1.5),
                      ),
                      SizedBox(height: size.height * .06),

                      // Formulaire
                      Form(
                        key: controller.formKey,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.05),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              )
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
                                    color: secondaryTextColor),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: isDark
                                          ? Colors.grey[800]!
                                          : Colors.grey[300]!),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: '+221',
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down_rounded,
                                        color: primaryColor),
                                    items: [
                                      DropdownMenuItem(
                                        value: '+221',
                                        child: Row(children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(4),
                                            child: Image.asset(
                                              'assets/flags/sn.png',
                                              width: 24,
                                              height: 18,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stack) =>
                                                  Icon(Icons.flag_rounded,
                                                      color: primaryColor),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text('Sénégal (+221)',
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 16)),
                                        ]),
                                      )
                                    ],
                                    onChanged: (_) {},
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Numéro de téléphone',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: secondaryTextColor),
                              ),
                              const SizedBox(height: 8),

                              Obx(
                                    () => TextFormField(
                                      focusNode: controller.phoneFocus,
                                  controller: controller.phoneController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [controller.phoneMask],
                                  style: TextStyle(
                                      fontSize: 16, color: textColor),
                                  decoration: InputDecoration(
                                    hintText: '78 277 55 79',
                                    hintStyle: TextStyle(
                                        color: secondaryTextColor
                                            .withOpacity(.7)),
                                    prefixIcon: Icon(
                                        Icons.phone_android_rounded,
                                        color: primaryColor),
                                    suffixIcon: controller.hasInput
                                        ? Icon(
                                      controller.isValid
                                          ? Icons.check_circle
                                          : Icons.error,
                                      color: controller.isValid
                                          ? Colors.green
                                          : Colors.red,
                                    )
                                        : null,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: controller.hasInput
                                            ? (controller.isValid
                                            ? Colors.green
                                            : Colors.red)
                                            : (isDark
                                            ? Colors.grey[800]!
                                            : Colors.grey[300]!),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: primaryColor, width: 2),
                                    ),
                                    filled: true,
                                    fillColor: isDark
                                        ? Colors.grey[900]
                                        : Colors.grey[50],
                                  ),
                                  validator: (_) => controller.isValid
                                      ? null
                                      : 'Veuillez entrer un numéro valide',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Bouton de connexion
                      Obx(
                            () => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: primaryColor.withOpacity(.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8))
                            ],
                          ),
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 0,
                            ),
                            child: controller.isLoading.value
                                ? const SpinKitThreeBounce(
                                color: Colors.white, size: 20)
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(width: 12),
                                Text('Continuer avec WhatsApp',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Besoin d\'aide?',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Overlay loading
          Obx(
                () => controller.isLoading.value
                ? Container(
              color: Colors.black.withOpacity(.6),
              child: Center(
                child: Container(
                  width: size.width * .8,
                  padding: const EdgeInsets.symmetric(
                      vertical: 32, horizontal: 24),
                  decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(24)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset('assets/animations/loading.json',
                          width: 120, height: 120),
                      const SizedBox(height: 24),
                      Text('Vérification en cours...',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor)),
                      const SizedBox(height: 12),
                      Text('Nous préparons votre compte',
                          style: TextStyle(
                              fontSize: 16,
                              color: secondaryTextColor),
                          textAlign: TextAlign.center),
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
