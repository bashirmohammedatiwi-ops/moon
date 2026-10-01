import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// أنماط نص قمر الزمان — عناوين تحريرية وأسعار فيروزية واضحة.
abstract final class AppTypography {
  static TextStyle get display => GoogleFonts.elMessiri(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: 0.4,
        height: 1.12,
      );

  static TextStyle get sectionTitle => GoogleFonts.elMessiri(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: 0.2,
        height: 1.2,
      );

  static TextStyle get screenTitle => GoogleFonts.cairo(
        fontSize: 17,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: -0.15,
      );

  static TextStyle get body => GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyStrong => GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get caption => GoogleFonts.cairo(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
        height: 1.4,
      );

  static TextStyle get overline => GoogleFonts.cairo(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
        letterSpacing: 0.8,
        height: 1.2,
      );

  static TextStyle get price => GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w900,
        color: AppColors.primaryDark,
        height: 1.1,
      );

  static TextStyle get priceLarge => GoogleFonts.cairo(
        fontSize: 26,
        fontWeight: FontWeight.w900,
        color: AppColors.primaryDark,
        letterSpacing: -0.4,
      );

  static TextStyle get brand => GoogleFonts.elMessiri(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: 0.3,
        height: 1.15,
      );
}
