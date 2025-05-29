import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

import '../controllers/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? TColors.primaryDark : TColors.primary;
    final backgroundColor = TColors.background(context);
    final cardColor = TColors.surface(context);
    final textColor = TColors.textPrimary(context);
    final secondaryTextColor = TColors.textSecondary(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
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

          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
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
                                MediaQuery.of(context).viewInsets.bottom > 0
                                    ? Get.height * 0.2
                                    : Get.height * 0.35,
                          ),
                        ),

                        SizedBox(height: Get.height * 0.02),
                        Text(
                          'Créer un compte',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Text(
                          'Entrez vos informations pour commencer',
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryTextColor,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: Get.height * .03),

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
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Country section (consistent with login)
                                Text(
                                  'Pays',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: secondaryTextColor,
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
                                      color:
                                          isDark
                                              ? Colors.grey[800]!
                                              : Colors.grey[300]!,
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: '+221',
                                      isExpanded: true,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: primaryColor,
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
                                                      (context, error, stack) =>
                                                          Icon(
                                                            Icons.flag_rounded,
                                                            color: primaryColor,
                                                          ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                'Sénégal (+221)',
                                                style: TextStyle(
                                                  color: textColor,
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
                                // Name field
                                Text(
                                  'Nom complet',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: secondaryTextColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: controller.nameController,
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: textColor,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Jean Dupont',
                                    hintStyle: TextStyle(
                                      color: secondaryTextColor.withOpacity(.7),
                                    ),

                                    prefixIcon: Icon(
                                      Icons.person_outline_rounded,
                                      color: primaryColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color:
                                            isDark
                                                ? Colors.grey[800]!
                                                : Colors.grey[300]!,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    errorStyle: TextStyle(
                                      color: Colors.red[700],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
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
                                    fillColor:
                                        isDark
                                            ? Colors.grey[900]
                                            : Colors.grey[50],
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Veuillez entrer votre nom';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: Get.height * 0.02),
                                // Phone field
                                Text(
                                  'Numéro de téléphone',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: secondaryTextColor,
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
                                      color: textColor,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '78 277 55 79',
                                      hintStyle: TextStyle(
                                        color: secondaryTextColor.withOpacity(
                                          .7,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.phone_android_rounded,
                                        color: primaryColor,
                                      ),
                                      suffixIcon:
                                          controller.hasInput.value
                                              ? Icon(
                                                controller.isValid.value
                                                    ? Icons.check_circle
                                                    : Icons.error,
                                                color:
                                                    controller.isValid.value
                                                        ? Colors.green
                                                        : Colors.red,
                                              )
                                              : null,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color:
                                              controller.hasInput.value
                                                  ? (controller.isValid.value
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
                                          color: primaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      errorStyle: TextStyle(
                                        color: Colors.red[700],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
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
                                      fillColor:
                                          isDark
                                              ? Colors.grey[900]
                                              : Colors.grey[50],
                                    ),
                                    validator:
                                        (_) =>
                                            controller.isValid.value
                                                ? null
                                                : 'Veuillez entrer un numéro valide',
                                  ),
                                ),

                                SizedBox(height: Get.height * 0.02),
                                // Driver checkbox
                                // Replace the existing checkbox with this
                                SizedBox(height: Get.height * 0.02),
                                Obx(
                                  () => InkWell(
                                    onTap:
                                        () =>
                                            controller.isDriver.value =
                                                !controller.isDriver.value,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 200,
                                            ),
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                color:
                                                    controller.isDriver.value
                                                        ? primaryColor
                                                        : isDark
                                                        ? Colors.grey[700]!
                                                        : Colors.grey[400]!,
                                                width:
                                                    controller.isDriver.value
                                                        ? 0
                                                        : 1.5,
                                              ),
                                              color:
                                                  controller.isDriver.value
                                                      ? primaryColor
                                                      : Colors.transparent,
                                              boxShadow:
                                                  controller.isDriver.value
                                                      ? [
                                                        BoxShadow(
                                                          color: primaryColor
                                                              .withOpacity(0.3),
                                                          blurRadius: 8,
                                                          offset: const Offset(
                                                            0,
                                                            2,
                                                          ),
                                                        ),
                                                      ]
                                                      : null,
                                            ),
                                            child:
                                                controller.isDriver.value
                                                    ? const Icon(
                                                      Icons.check,
                                                      size: 18,
                                                      color: Colors.white,
                                                    )
                                                    : null,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              "Je souhaite devenir conducteur",
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
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
                        ),

                        SizedBox(height: Get.height * 0.02),

                        // Register button with shadow
                        Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(.3),
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
                                      : controller.handleRegister,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
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
                                      : const Text(
                                        'S\'inscrire',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                            ),
                          ),
                        ),

                        SizedBox(height: Get.height * 0.01),
                        Center(
                          child: TextButton(
                            onPressed: () => Get.back(),
                            child: Text(
                              'Déjà un compte? Se connecter',
                              style: TextStyle(
                                color: primaryColor,
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

          Obx(
            () =>
                controller.isLoading.value
                    ? Container(
                      color: Colors.black.withOpacity(.6),
                      child: Center(
                        child: Container(
                          width: Get.width * .8,
                          padding: const EdgeInsets.symmetric(
                            vertical: 32,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            color: cardColor,
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
                                'Inscription en cours...',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Nous préparons votre compte',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: secondaryTextColor,
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
