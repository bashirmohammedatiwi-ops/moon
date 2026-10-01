import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

/// ثيم موحّد لصفحة قائمة المنتجات — هوية قمر الزمان.
abstract final class ListingTheme {
  static const canvas = AppColors.scaffold;
  static const headerBg = AppColors.primarySoft;
  static const card = Colors.white;
  static const wash = AppColors.primaryLight;
  static const chipBg = AppColors.mist;

  static const cardRadius = 22.0;
  static const chipRadius = 16.0;
  static const padH = 18.0;

  static BoxDecoration cardDecoration() => BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: AppColors.hairline.withValues(alpha: 0.75)),
        boxShadow: AppColors.cardShadow,
      );

  static TextStyle sectionTitle = GoogleFonts.elMessiri(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static TextStyle sectionHint = GoogleFonts.cairo(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted.withValues(alpha: 0.95),
  );
}
