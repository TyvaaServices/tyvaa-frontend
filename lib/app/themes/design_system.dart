import 'package:flutter/material.dart';

/// Design System for Tyvaa app
/// This file defines the core design elements that should be used throughout the app
/// to ensure consistency and professional quality.

class TColors {
  static const Color primary = Color(0xFF6A0DAD);
  static const Color primaryLight = Color(0xFF9356D0);
  static const Color primaryDark = Color(0xFF4A0080);

  static const Color neutral100 = Color(0xFFF8F9FE);
  static const Color neutral200 = Color(0xFFEEEFF4);
  static const Color neutral300 = Color(0xFFDFE1E9);
  static const Color neutral400 = Color(0xFFBFC3D0);
  static const Color neutral500 = Color(0xFF9FA4B4);
  static const Color neutral600 = Color(0xFF7E8497);
  static const Color neutral700 = Color(0xFF5D6273);
  static const Color neutral800 = Color(0xFF3C3F4A);
  static const Color neutral900 = Color(0xFF1C1D22);

  // Accent Colors
  static const Color accent = Color(0xFF4ECDC4);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  static const Color darkBackground = Color(0xFF121214);
  static const Color darkSurface = Color(0xFF1E1E24);
  static const Color darkCard = Color(0xFF2A2A32);

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkBackground
          : neutral100;

  static Color surface(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkSurface
          : Colors.white;

  static Color textPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : neutral900;

  static Color textSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? neutral400 : neutral600;
}

class TSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  static const double cardPadding = 16.0;
  static const double sectionSpacing = 24.0;
  static const double buttonPadding = 16.0;
}

class TRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double pill = 100.0;

  static BorderRadius get buttonRadius => BorderRadius.circular(lg);
  static BorderRadius get cardRadius => BorderRadius.circular(lg);
  static BorderRadius get inputRadius => BorderRadius.circular(md);
  static BorderRadius get chipRadius => BorderRadius.circular(pill);
  static BorderRadius get modalRadius =>
      const BorderRadius.vertical(top: Radius.circular(xl));
}

class TTypography {
  // Display styles
  static TextStyle displayLarge(BuildContext context) => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: TColors.textPrimary(context),
  );

  static TextStyle displayMedium(BuildContext context) => TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: TColors.textPrimary(context),
  );

  static TextStyle displaySmall(BuildContext context) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: TColors.textPrimary(context),
  );

  // Heading styles
  static TextStyle headingLarge(BuildContext context) => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: TColors.textPrimary(context),
  );

  static TextStyle headingMedium(BuildContext context) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: TColors.textPrimary(context),
  );

  static TextStyle headingSmall(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: TColors.textPrimary(context),
  );

  // Body styles
  static TextStyle bodyLarge(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: TColors.textPrimary(context),
  );

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: TColors.textPrimary(context),
  );

  static TextStyle bodySmall(BuildContext context) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: TColors.textSecondary(context),
  );

  // Label styles
  static TextStyle labelLarge(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: TColors.textPrimary(context),
  );

  static TextStyle labelMedium(BuildContext context) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: TColors.textPrimary(context),
  );

  static TextStyle labelSmall(BuildContext context) => TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: TColors.textSecondary(context),
  );
}

class TShadows {
  static List<BoxShadow> get subtle => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get medium => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get strong => [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
}

class TAnimations {
  static const Duration short = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration long = Duration(milliseconds: 500);
}

class TTextStyles {
  static TextStyle button(BuildContext context) =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);

  static TextStyle get buttonStatic =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);

  static TextStyle body(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: TColors.textPrimary(context),
  );

  static TextStyle bodySecondary(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: TColors.textSecondary(context),
  );

  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: TColors.textSecondary(context),
  );
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: TColors.primary,
  scaffoldBackgroundColor: TColors.neutral100,
  cardColor: Colors.white,
  dividerColor: TColors.neutral300,
  appBarTheme: AppBarTheme(
    backgroundColor: TColors.neutral100,
    elevation: 0,
    iconTheme: IconThemeData(color: TColors.neutral900),
    titleTextStyle: TextStyle(
      color: TColors.neutral900,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: TColors.primary,
    secondary: TColors.accent,
    error: TColors.error,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: TColors.primary,
  scaffoldBackgroundColor: TColors.darkBackground,
  cardColor: TColors.darkCard,
  dividerColor: TColors.neutral700,
  appBarTheme: AppBarTheme(
    backgroundColor: TColors.darkBackground,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  colorScheme: ColorScheme.dark(
    primary: TColors.primary,
    secondary: TColors.accent,
    error: TColors.error,
  ),
);
