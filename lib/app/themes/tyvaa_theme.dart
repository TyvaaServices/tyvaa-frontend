import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF6A0DAD); // Strong purple
  static const Color primaryLight = Color(0xFFB266FF); // Soft lavender
  static const Color primaryDark = Color(0xFF4A0080); // Deep purple

  // Accent Colors
  static const Color accent = Color(0xFFFFC107); // Amber for highlights
  static const Color success = Color(0xFF4CAF50); // Green for success
  static const Color warning = Color(0xFFFF9800); // Orange for warnings
  static const Color error = Color(0xFFF44336); // Red for errors
  static const Color info = Color(0xFF2196F3); // Blue for information

  // Light Mode Backgrounds
  static const Color background = Color(0xFFF8F9FB); // Light app background
  static const Color card = Color(0xFFFFFFFF); // Card color for light mode
  static const Color navBackground = Color(
    0xFFF8F9FB,
  ); // Light background for nav

  // Dark Mode Backgrounds
  static const Color darkBackground = Color(0xFF121212); // Dark mode background
  static const Color cardDark = Color(0xFF1E1E1E); // Card color for dark mode
  static const Color navBackgroundDark = Color(
    0xFF121212,
  ); // Dark background for nav

  // Text colors (Light Mode)
  static const Color textPrimary = Color(
    0xFF212121,
  ); // Primary text color for light mode
  static const Color textSecondary = Color(
    0xFF757575,
  ); // Secondary text color for light mode
  static const Color textOnPrimary =
      Colors.white; // Text on primary background (white)

  // Text colors (Dark Mode)
  static const Color textPrimaryDark =
      Colors.white; // Primary text color for dark mode
  static const Color textSecondaryDark =
      Colors.white70; // Secondary text color for dark mode

  // Dividers (Light and Dark Mode)
  static const Color divider = Color(0xFFDDDDDD); // Divider for light mode
  static const Color darkDivider = Color(0xFF333333); // Divider for dark mode

  // Navigation (Light and Dark Mode)
  static const Color navActive = Color(0xFF6A0DAD); // Active nav item
  static const Color navInactive = Color(0xFF757575); // Inactive nav item
}

class AppTextStyles {
  // Headings
  static TextStyle get h1 => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  ); // For light mode

  static TextStyle get h1Dark => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimaryDark,
  ); // For dark mode

  static TextStyle get h2 => TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  ); // For light mode

  static TextStyle get h2Dark => TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  ); // For dark mode

  static TextStyle get h3 => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  ); // For light mode

  static TextStyle get h3Dark => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  ); // For dark mode

  // Subheadings / Section titles
  static TextStyle get subtitle1 => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  ); // For light mode

  static TextStyle get subtitle1Dark => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondaryDark,
  ); // For dark mode

  static TextStyle get subtitle2 => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  ); // For light mode

  static TextStyle get subtitle2Dark => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryDark,
  ); // For dark mode

  // Body text
  static TextStyle get body =>
      TextStyle(fontSize: 16, color: AppColors.textPrimary); // For light mode

  static TextStyle get bodyDark => TextStyle(
    fontSize: 16,
    color: AppColors.textPrimaryDark,
  ); // For dark mode

  static TextStyle get bodySecondary =>
      TextStyle(fontSize: 14, color: AppColors.textSecondary); // For light mode

  static TextStyle get bodySecondaryDark => TextStyle(
    fontSize: 14,
    color: AppColors.textSecondaryDark,
  ); // For dark mode

  // Buttons
  static TextStyle get button => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
  );

  // Captions
  static TextStyle get caption =>
      TextStyle(fontSize: 12, color: AppColors.textSecondary); // For light mode

  static TextStyle get captionDark => TextStyle(
    fontSize: 12,
    color: AppColors.textSecondaryDark,
  ); // For dark mode

  // Overline
  static TextStyle get overline =>
      TextStyle(fontSize: 10, color: AppColors.textSecondary); // For light mode

  static TextStyle get overlineDark => TextStyle(
    fontSize: 10,
    color: AppColors.textSecondaryDark,
  ); // For dark mode
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.card,
  dividerColor: AppColors.divider,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.textPrimary),
    titleTextStyle: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
    titleSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimary),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondary),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textOnPrimary,
    ),
    bodySmall: TextStyle(fontSize: 12, color: AppColors.textSecondary),
    labelSmall: TextStyle(fontSize: 10, color: AppColors.textSecondary),
  ),
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.accent,
    error: AppColors.error,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  cardColor: AppColors.cardDark,
  dividerColor: AppColors.darkDivider,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
    titleTextStyle: TextStyle(
      color: AppColors.textPrimaryDark,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimaryDark,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondaryDark,
    ),
    titleSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryDark,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimaryDark),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondaryDark),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textOnPrimary,
    ),
    bodySmall: TextStyle(fontSize: 12, color: AppColors.textSecondaryDark),
    labelSmall: TextStyle(fontSize: 10, color: AppColors.textSecondaryDark),
  ),
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.accent,
    error: AppColors.error,
  ),
);

// Usage in MaterialApp
// theme: lightTheme,
// darkTheme: darkTheme,
// themeMode: ThemeMode.system,
