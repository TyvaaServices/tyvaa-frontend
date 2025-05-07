import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final bannerController = PageController(viewportFraction: 0.9);
  final currentBanner = 0.obs;
  final selectedIndex = 0.obs;
  late Timer _bannerTimer;

  final banners = [
    {
      'image': 'assets/promo1.png',
      'title': 'Voyagez en toute sérénité',
      'subtitle': 'Des trajets vérifiés et sécurisés',
    },
    {
      'image': 'assets/promo2.png',
      'title': 'Éco-mobilité intelligente',
      'subtitle': 'Réduisez votre empreinte carbone',
    },
    {
      'image': 'assets/promo3.png',
      'title': 'Communauté bienveillante',
      'subtitle': 'Rejoignez des milliers de membres',
    },
  ];

  // @override
  // void onInit() {
  //   _bannerTimer = Timer.periodic(const Duration(seconds: 3), (_) {
  //     final next = (currentBanner.value + 1) % banners.length;
  //     if (bannerController.hasClients) {
  //       bannerController.animateToPage(
  //         next,
  //         duration: const Duration(milliseconds: 500),
  //         curve: Curves.easeInOut,
  //       );
  //     }
  //   });
  //   super.onInit();
  // }
  @override
  void onInit() {
    super.onInit();
    bannerController.addListener(() {
      final page = bannerController.page?.round() ?? 0;
      currentBanner.value = page;
    });
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (currentBanner.value + 1) % banners.length;
      if (bannerController.hasClients) {
        bannerController.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void onClose() {
    _bannerTimer.cancel();
    bannerController.dispose();
    super.onClose();
  }

  void changeTab(int index) => selectedIndex.value = index;
}
