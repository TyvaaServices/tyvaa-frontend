import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/themes/tyvaa_theme.dart'; // Ensure this file includes AppColors & AppTextStyles

void main() {
  runApp(
    GetMaterialApp(
      title: "Tyvaa",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: TextTheme(
          bodyMedium: AppTextStyles.subtitle1, // Use the light theme text style
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        textTheme: TextTheme(
          bodyMedium: AppTextStyles.subtitle1Dark, // Use the dark theme text style
        ),
      ),
      themeMode: ThemeMode.system, // This automatically adjusts based on system preference
    ),
  );
}
