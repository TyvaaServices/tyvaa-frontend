import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../themes/design_system.dart';

class NetworkErrorPage extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final String? assetPath;

  const NetworkErrorPage({super.key, this.message, this.onRetry, this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child:
                  assetPath != null
                      ? Lottie.asset(
                        assetPath!,
                        height: 250,
                        fit: BoxFit.contain,
                      )
                      : Image.asset(
                        'assets/error_global.png',
                        height: 250,
                        fit: BoxFit.contain,
                      ),
            ),

            const SizedBox(height: 40),

            Text(
              'Oops!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: TColors.primary,
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                message ?? 'Problème de connexion au réseau',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Veuillez vérifier votre connexion internet et réessayer',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),

            const SizedBox(height: 40),

            InkWell(
              onTap: onRetry ?? () => Get.back(),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 48,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [TColors.primary, TColors.primary.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: TColors.primary.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Text(
                  'RÉESSAYER',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            TextButton(
              onPressed: () {
                Get.close(0);
                Get.back();
              },
              child: Text(
                'Quitter',
                style: TextStyle(
                  color: TColors.error,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
