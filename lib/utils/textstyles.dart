import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  static TextStyle displayLarge = GoogleFonts.playfairDisplay(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static TextStyle displayMedium = GoogleFonts.playfairDisplay(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static TextStyle displaySmall = GoogleFonts.playfairDisplay(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static TextStyle headlineLarge = GoogleFonts.chivo(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static TextStyle headlineMedium = GoogleFonts.chivo(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static TextStyle headlineSmall = GoogleFonts.chivo(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static TextStyle titleLarge = GoogleFonts.chivo(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );

  static TextStyle titleMedium = GoogleFonts.chivo(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );

  static TextStyle titleSmall = GoogleFonts.chivo(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );

  static TextStyle bodyLarge = GoogleFonts.chivo(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );

  static TextStyle bodyMedium = GoogleFonts.chivo(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );

  static TextStyle bodySmall = GoogleFonts.chivo(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );

  static TextStyle labelLarge = GoogleFonts.chivo(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static TextStyle labelMedium = GoogleFonts.chivo(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );
}
