import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

/// ثيم صفحة تفاصيل المنتج — ضباب فيروزي وصحيفة بيضاء ناعمة.
abstract final class ProductDetailTheme {
  static const galleryBg = AppColors.mist;
  static const sheetRadius = 30.0;
  static const overlap = 22.0;
  static const padH = 18.0;
  static const sectionGap = 14.0;

  static BoxDecoration sheetDecoration() => const BoxDecoration(
        color: AppColors.scaffold,
        borderRadius: BorderRadius.vertical(top: Radius.circular(sheetRadius)),
      );

  static BoxDecoration heroCardDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.hairline.withValues(alpha: 0.8)),
        boxShadow: AppColors.cardShadow,
      );

  static BoxDecoration sectionDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.hairline.withValues(alpha: 0.7)),
        boxShadow: AppColors.cardShadow,
      );

  static BoxDecoration shadeSectionDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.primarySoft.withValues(alpha: 0.9)),
      );

  static BoxDecoration chipDecoration({bool active = false}) => BoxDecoration(
        gradient: active ? AppColors.primaryGradient : null,
        color: active ? null : AppColors.elevated,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(
          color: active ? Colors.transparent : AppColors.hairline,
        ),
        boxShadow: active
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.22),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      );

  static BoxDecoration stockPillDecoration(Color color) => BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      );

  static BoxDecoration bottomBarDecoration() => BoxDecoration(
        color: Colors.white.withValues(alpha: 0.97),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: AppColors.hairline.withValues(alpha: 0.85))),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 22,
            offset: const Offset(0, -6),
            spreadRadius: -4,
          ),
        ],
      );

  static TextStyle sectionTitleStyle = GoogleFonts.elMessiri(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  static TextStyle brandStyle = GoogleFonts.cairo(
    color: AppColors.primary,
    fontWeight: FontWeight.w800,
    fontSize: 11,
    letterSpacing: 1.2,
  );
}
