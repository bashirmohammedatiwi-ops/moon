import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

/// هوية صفحة العروض — فيروزي عميق مع ضباب فاتح.
abstract final class OffersTheme {
  static const brand = AppColors.primary;
  static const brandDark = AppColors.primaryDark;
  static const brandSoft = AppColors.primaryLight;
  static const brandWash = AppColors.primarySoft;
  static const sale = AppColors.sale;
  static const accent = AppColors.accent;

  static const canvas = AppColors.scaffold;
  static const surface = Colors.white;
  static const line = AppColors.hairline;

  static const ink = AppColors.textPrimary;
  static const inkSoft = AppColors.textSecondary;
  static const inkMuted = AppColors.textMuted;

  static const hPad = 18.0;
  static const cardRadius = 22.0;

  static TextStyle title({double size = 19, Color? color}) => GoogleFonts.elMessiri(
        fontSize: size,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: 0.15,
        color: color ?? ink,
      );

  static TextStyle body({
    double size = 13,
    Color? color,
    FontWeight weight = FontWeight.w500,
  }) =>
      GoogleFonts.cairo(
        fontSize: size,
        fontWeight: weight,
        height: 1.45,
        color: color ?? inkSoft,
      );

  static TextStyle chip({bool selected = false}) => GoogleFonts.cairo(
        fontSize: 12.5,
        fontWeight: FontWeight.w800,
        color: selected ? Colors.white : ink,
        height: 1.2,
      );

  static BoxDecoration canvasDecoration() => const BoxDecoration(
        gradient: AppColors.homeBackgroundGradient,
      );

  static BoxDecoration heroDecoration() => BoxDecoration(
        gradient: AppColors.offerHeroGradient,
        borderRadius: BorderRadius.circular(26),
        boxShadow: AppColors.floatShadow,
      );

  static BoxDecoration surfaceCard() => BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: line.withValues(alpha: 0.85)),
        boxShadow: AppColors.cardShadow,
      );

  static BoxDecoration chipDecoration({bool selected = false}) => BoxDecoration(
        gradient: selected ? AppColors.primaryGradient : null,
        color: selected ? null : surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: selected ? Colors.transparent : line),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.22),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      );
}

class OffersCanvas extends StatelessWidget {
  final Widget child;

  const OffersCanvas({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: OffersTheme.canvasDecoration(),
      child: child,
    );
  }
}

class OffersSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const OffersSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(OffersTheme.hPad, 20, OffersTheme.hPad, 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: OffersTheme.title(size: 17)),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: OffersTheme.body(size: 12)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OffersPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OffersPrimaryButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.28),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(26),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
