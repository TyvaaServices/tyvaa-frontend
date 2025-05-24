import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/home/views/trajet_view.dart';
import 'package:passenger_tyvaa/app/modules/profile/views/profile_view.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../themes/tyvaa_theme.dart';
import '../../chatbot/views/chooseChat_view.dart';
import '../controllers/home_controller.dart';
import 'home_view.dart';

class MainScreen extends GetView<HomeController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    Color iconColor =
        brightness == Brightness.dark
            ? AppColors.textPrimaryDark
            : AppColors.textPrimary;
    Color selectedColor =
        brightness == Brightness.dark
            ? AppColors.textPrimaryDark
            : AppColors.background;
    Color backgroundColor =
        brightness == Brightness.dark
            ? AppColors.darkBackground
            : AppColors.background;
    Color bottomNavBackgroundColor =
        brightness == Brightness.dark
            ? AppColors.primaryDark
            : AppColors.primary;
    Color selectedIconColor =
        brightness == Brightness.dark
            ? AppColors.background
            : AppColors.background;

    return Obx(() {
      final List<Widget> pages = [
        HomeScreen(key: const ValueKey('home')),
        const HistoriqueScreen(key: const ValueKey('historique')),
        const ChooseChatbotScreen(key: ValueKey('chat')),
        const ProfileScreen(key: ValueKey('profile')),
      ];

      return Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: pages[controller.selectedIndex.value],
        ),
        bottomNavigationBar: StylishBottomBar(
          option: BubbleBarOptions(barStyle: BubbleBarStyle.horizontal),
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTab,
          backgroundColor: backgroundColor,
          items: [
            BottomBarItem(
              icon: Icon(Icons.home_outlined, color: iconColor),
              title: Text('Accueil', style: TextStyle(color: selectedColor)),
              backgroundColor: bottomNavBackgroundColor,
              selectedColor: selectedIconColor,
              selectedIcon: Icon(Icons.home, color: selectedIconColor),
            ),
            BottomBarItem(
              icon: Icon(Icons.history_outlined, color: iconColor),
              title: Text('Historique', style: TextStyle(color: selectedColor)),
              backgroundColor: bottomNavBackgroundColor,
              selectedColor: selectedIconColor,
              selectedIcon: Icon(Icons.history, color: selectedIconColor),
            ),
            BottomBarItem(
              icon: Icon(Icons.chat_outlined, color: iconColor),
              title: Text('Assistant', style: TextStyle(color: selectedColor)),
              backgroundColor: bottomNavBackgroundColor,
              selectedColor: selectedIconColor,
              selectedIcon: Icon(Icons.chat, color: selectedIconColor),
            ),
            BottomBarItem(
              icon: Icon(Icons.person_outline, color: iconColor),
              title: Text('Profil', style: TextStyle(color: selectedColor)),
              backgroundColor: bottomNavBackgroundColor,
              selectedColor: selectedIconColor,
              selectedIcon: Icon(Icons.person, color: selectedIconColor),
            ),
          ],
        ),
      );
    });
  }
}

class HistoriqueScreen extends GetView<HomeController> {
  const HistoriqueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Historique'));
  }
}
