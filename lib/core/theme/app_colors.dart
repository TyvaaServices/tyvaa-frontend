import 'package:flutter/material.dart';

class AppColors {
  // --- Core Palette ---
  // Rebranding: Switching from Electric Purple to a Premium Indigo + Teal combination
  // Indigo: Trust, Professionalism, Modern Tech
  static const Color primary = Color(0xFF4F46E5); // Indigo 600 (Was 0xFF6F00F8)

  // Teal: Safety, Freshness, Energy (Great for secondary actions/accents)
  static const Color secondary = Color(0xFF0D9488); // Teal 600 (Was 0xFF00D2FF)

  // Accent: Kept Gold but refined for better contrast
  static const Color accent = Color(0xFFF59E0B); // Amber 500 (Was 0xFFFFD700)

  // --- Neutrals (Slate Scale) ---
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color slate950 = Color(0xFF020617);

  // --- Semantic Colors ---
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // --- Light Theme Specific ---
  static const Color backgroundLight = Color(0xFFF1F5F9); // Refined off-white
  static const Color surfaceLight = Colors.white;
  static const Color textMainLight = slate900;
  static const Color textSecondaryLight = slate600; // Increased contrast
  static const Color borderLight = slate200;

  // --- Dark Theme Specific ---
  static const Color backgroundDark = slate950;
  static const Color surfaceDark = slate900;
  static const Color textMainDark = slate50;
  static const Color textSecondaryDark = slate400;
  static const Color borderDark = slate800;

  // --- Compatibility Getters (for old code) ---
  static Color get background => backgroundLight;
  static Color get textMain => textMainLight;
  static Color get textSecondary => textSecondaryLight;
  static Color get textInverse => Colors.white;
  static Color get primaryVariant => primary;
}
