import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // 1. Typography (Urbanist)
  static TextTheme _textTheme(Color textColor, Color secondaryColor) =>
      TextTheme(
        displayLarge: GoogleFonts.urbanist(
          fontSize: 32.sp,
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: -0.5,
        ),
        displayMedium: GoogleFonts.urbanist(
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: -0.5,
        ),
        headlineLarge: GoogleFonts.urbanist(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        headlineMedium: GoogleFonts.urbanist(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        titleLarge: GoogleFonts.urbanist(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        titleMedium: GoogleFonts.urbanist(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        bodyLarge: GoogleFonts.urbanist(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: textColor,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.urbanist(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: secondaryColor,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.urbanist(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        labelMedium: GoogleFonts.urbanist(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: secondaryColor,
        ),
      );

  // 2. Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.slate50, // Clean Off-White
      // Typography
      textTheme: _textTheme(
        AppColors.textMainLight,
        AppColors.textSecondaryLight,
      ),
      fontFamily: GoogleFonts.urbanist().fontFamily,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: Colors.white,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSurface: AppColors.textMainLight,
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.slate50,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textMainLight),
        titleTextStyle: _textTheme(
          AppColors.textMainLight,
          AppColors.textSecondaryLight,
        ).headlineMedium,
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r), // Pill Shape
          ),
          // Using a subtle shadow for better depth perception (Mobile UX)
          elevation: 4,
          shadowColor: AppColors.primary.withValues(alpha: 0.4),
          textStyle: _textTheme(Colors.white, Colors.white).titleMedium,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          side: const BorderSide(color: AppColors.slate200, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          textStyle: _textTheme(
            AppColors.primary,
            AppColors.primary,
          ).titleMedium,
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        hintStyle: _textTheme(
          AppColors.textMainLight,
          AppColors.slate400,
        ).bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),

      // Cards
      // cardTheme: CardTheme(
      //   color: Colors.white,
      //   elevation: 0,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(24.r),
      //     side: const BorderSide(color: AppColors.slate100, width: 1),
      //   ),
      //   margin: EdgeInsets.zero,
      // ),
      dividerTheme: const DividerThemeData(
        color: AppColors.slate200,
        thickness: 1,
      ),
    );
  }

  // 3. Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.slate950,

      // Typography
      textTheme: _textTheme(
        AppColors.textMainDark,
        AppColors.textSecondaryDark,
      ),
      fontFamily: GoogleFonts.urbanist().fontFamily,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.slate900,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSurface: AppColors.textMainDark,
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.slate950,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textMainDark),
        titleTextStyle: _textTheme(
          AppColors.textMainDark,
          AppColors.textSecondaryDark,
        ).headlineMedium,
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          textStyle: _textTheme(Colors.white, Colors.white).titleMedium,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          side: const BorderSide(color: AppColors.slate800, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          textStyle: _textTheme(
            AppColors.primary,
            AppColors.primary,
          ).titleMedium,
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.slate900,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        hintStyle: _textTheme(
          AppColors.textMainDark,
          AppColors.slate600,
        ).bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),

      // Cards
      // cardTheme: CardTheme(
      //   color: AppColors.slate900,
      //   elevation: 0,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(24.r),
      //     side: const BorderSide(color: AppColors.slate800, width: 1),
      //   ),
      //   margin: EdgeInsets.zero,
      // ),
      dividerTheme: const DividerThemeData(
        color: AppColors.slate800,
        thickness: 1,
      ),
    );
  }
}
