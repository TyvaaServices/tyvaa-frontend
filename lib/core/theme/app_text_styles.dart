import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  // --- Display Styles ---
  static TextStyle get displayLarge => GoogleFonts.outfit(
    fontSize: 48.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -2.0,
    height: 1.1,
  );

  static TextStyle get displayMedium => GoogleFonts.outfit(
    fontSize: 36.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.5,
    height: 1.2,
  );

  // --- Heading Styles ---
  static TextStyle get heading1 => GoogleFonts.outfit(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static TextStyle get heading2 => GoogleFonts.outfit(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
  );

  static TextStyle get heading3 =>
      GoogleFonts.outfit(fontSize: 18.sp, fontWeight: FontWeight.w600);

  // --- Body Styles ---
  static TextStyle get bodyLarge => GoogleFonts.outfit(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.outfit(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle get bodySmall =>
      GoogleFonts.outfit(fontSize: 12.sp, fontWeight: FontWeight.w400);

  // --- Action Styles ---
  static TextStyle get button => GoogleFonts.outfit(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static TextStyle get label => GoogleFonts.outfit(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    textStyle: const TextStyle(textBaseline: TextBaseline.alphabetic),
  );

  // --- Compatibility Getters ---
  static TextStyle get display => displayLarge;
}
