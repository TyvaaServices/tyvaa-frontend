import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;
  final _storage = const FlutterSecureStorage();

  final List<Map<String, String>> contents = [
    {
      "title": "RÉSERVER UN TRAJET",
      "desc":
          "Vous allez quelque part ? Le covoiturage est la solution ! Réservez à petit prix et voyagez avec des gens qui vont dans la même direction.",
      "image": "assets/images/img_onboarding_1.png",
    },
    {
      "title": "PROPOSER UN TRAJET",
      "desc":
          "Vous conduisez ? Publiez votre trajet ! Choisissez qui vient avec vous et profitez du voyage le moins cher que vous ayez jamais fait.",
      "image": "assets/images/img_onboarding_2.png",
    },
    {
      "title": "VOYAGEZ EN TOUTE CONFIANCE",
      "desc":
          "Un réseau mondial propulsé par des gens, avec une communauté de confiance de conducteurs et passagers opérant partout.",
      "image": "assets/images/img_onboarding_3.png",
    },
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < contents.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      finishOnboarding();
    }
  }

  void skip() {
    finishOnboarding();
  }

  Future<void> finishOnboarding() async {
    await _storage.write(key: 'has_seen_onboarding', value: 'true');
    Get.offAllNamed(Routes.AUTH); // Or DASHBOARD if we skip auth for now
  }
}
