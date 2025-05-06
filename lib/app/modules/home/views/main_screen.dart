import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/home/views/profile_view.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../themes/tyvaa_theme.dart';
import '../controllers/home_controller.dart';
import 'chooseChat_view.dart';
import 'home_view1.dart';

class MainScreen extends GetView<HomeController> {
  final List<Widget> pages = [
    const HomeScreen(key: ValueKey('home')),
    const HomeScreen(key: ValueKey('trajets')),
    const ChooseChatbotScreen(key: ValueKey('chat')),
    const ProfileScreen(key: ValueKey('profile')),
  ];


  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    // Define dynamic colors based on the theme (light or dark)
    Color iconColor = brightness == Brightness.dark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    Color selectedColor = brightness == Brightness.dark ? AppColors
        .textPrimaryDark : AppColors.background;
    Color backgroundColor = brightness == Brightness.dark ? AppColors.darkBackground : AppColors.background;
    Color bottomNavBackgroundColor = brightness == Brightness.dark ? AppColors.primaryDark : AppColors.primary;
    Color selectedIconColor = brightness == Brightness.dark ? AppColors
        .background : AppColors.background;

    return Obx(() => Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
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
            icon: Icon(Icons.directions_car_outlined, color: iconColor),
            title: Text('Trajets', style: TextStyle(color: selectedColor)),
            backgroundColor: bottomNavBackgroundColor,
            selectedColor: selectedIconColor,
            selectedIcon: Icon(Icons.directions_car, color: selectedIconColor),
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
    ));
  }
}
