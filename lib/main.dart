import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/themes/tyvaa_theme.dart';

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
        textTheme: TextTheme(bodyMedium: AppTextStyles.subtitle1),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        textTheme: TextTheme(bodyMedium: AppTextStyles.subtitle1Dark),
      ),
      themeMode: ThemeMode.system,
    ),
  );
}
