import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/theme/app_theme.dart';

import 'app/routes/app_pages.dart';

import 'app/bindings/initial_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr', null);

  runApp(
    ScreenUtilInit(
      designSize: const Size(393, 852), // iPhone 14 Pro dimensions
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "Tyvaa",
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          initialBinding: InitialBinding(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
