import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';

import '../controllers/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
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
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: FadeTransition(
              opacity: controller.fadeInAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/login_illustration.png',
                        height: size.height * 0.4,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.04),
                  Text(
                    'Créer un compte',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Entrez vos informations pour commencer',
                    style: TextStyle(fontSize: 16, color: secondaryTextColor),
                  ),
                  const SizedBox(height: 24),

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
                          Text(
                            'Nom complet',
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: controller.nameController,
                            keyboardType: TextInputType.name,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              hintText: 'Jean Dupont',
                              hintStyle: TextStyle(
                                color: secondaryTextColor.withOpacity(.7),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
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
                              filled: true,
                              fillColor:
                                  isDark ? Colors.grey[900] : Colors.grey[50],
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Veuillez entrer votre nom';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Téléphone',
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(
                            () => TextFormField(
                              focusNode: controller.phoneFocus,
                              controller: controller.phoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [controller.phoneMask],
                              style: TextStyle(color: textColor),
                              decoration: InputDecoration(
                                hintText: '78 277 55 79',
                                hintStyle: TextStyle(
                                  color: secondaryTextColor.withOpacity(.7),
                                ),
                                prefixIcon: Icon(
                                  Icons.phone,
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
                                filled: true,
                                fillColor:
                                    isDark ? Colors.grey[900] : Colors.grey[50],
                              ),
                              validator:
                                  (_) =>
                                      controller.isValid.value
                                          ? null
                                          : 'Numéro invalide',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Obx(
                            () => CheckboxListTile(
                              value: controller.isDriver.value,
                              onChanged: (value) {
                                controller.isDriver.value = value!;
                              },
                              activeColor: primaryColor,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Je souhaite devenir conducteur",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed:
                            controller.isLoading.value
                                ? null
                                : controller.handleRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child:
                            controller.isLoading.value
                                ? const SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 20,
                                )
                                : const Text(
                                  'Envoyer',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(
        () =>
            controller.isLoading.value
                ? Container(
                  color: Colors.black.withOpacity(.6),
                  child: Center(
                    child: Lottie.asset(
                      'assets/animations/loading.json',
                      width: 120,
                      height: 120,
                    ),
                  ),
                )
                : const SizedBox.shrink(),
      ),
    );
  }
}
