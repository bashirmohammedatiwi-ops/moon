import 'package:flutter/material.dart';

/// هوية قمر الزمان — فيروزي الشعار (#008995) مع تباين أسود واضح.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF008995);
  static const Color primaryDark = Color(0xFF006B76);
  static const Color primaryDeep = Color(0xFF004F57);
  static const Color primaryLight = Color(0xFFB8E8ED);
  static const Color primarySoft = Color(0xFFD6F2F5);
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color rose = Color(0xFF007A87);
  static const Color roseDark = Color(0xFF005A64);
  static const Color roseLight = Color(0xFF9FDDE4);
  static const Color roseSoft = Color(0xFFC8EBEF);
  static const Color blush = Color(0xFFEAF7F9);

  static const Color accent = Color(0xFF00B5C4);
  static const Color accentSoft = Color(0xFFCCF0F4);
  static const Color ink = Color(0xFF0A1E22);
  static const Color inkDeep = Color(0xFF000000);

  static const Color scaffold = Color(0xFFF8FCFD);
  static const Color mist = Color(0xFFE8F5F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);
  static const Color elevated = Color(0xFFF2FAFB);

  static const Color textPrimary = Color(0xFF0A1E22);
  static const Color textSecondary = Color(0xFF2E4A50);
  static const Color textMuted = Color(0xFF4F6A70);

  static const Color sale = Color(0xFF006B76);
  static const Color success = Color(0xFF0A8A62);
  static const Color warning = Color(0xFFD98E0A);
  static const Color star = Color(0xFFE8A317);

  static const Color border = Color(0xFF8ECFD8);
  static const Color divider = Color(0xFFC5E8EC);
  static const Color hairline = Color(0xFF9BD5DC);

  static const Color homeGradientTop = Color(0xFFE0F4F7);
  static const Color homeGradientMid = Color(0xFFF5FBFC);
  static const Color homeSurface = Color(0xFFFFFFFF);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, primary, primaryDark],
    stops: [0.0, 0.42, 1.0],
  );

  static const LinearGradient roseGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, primaryDeep],
  );

  static const LinearGradient luxuryGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFB8E8ED), Color(0xFFF8FCFD), Color(0xFF9FDDE4)],
  );

  static const LinearGradient offerHeroGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFF003840), Color(0xFF006B76), Color(0xFF008995)],
  );

  static const LinearGradient homeBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [homeGradientTop, homeGradientMid, scaffold],
    stops: [0.0, 0.28, 1.0],
  );

  static const LinearGradient flashSaleGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFF9FDDE4), Color(0xFFEAF7F9)],
  );

  static const LinearGradient mistWash = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFEAF7F9), Color(0xFFB8E8ED), Color(0xFF9FDDE4)],
  );

  static const Color shimmerBase = Color(0xFF9BD5DC);
  static const Color shimmerHighlight = Color(0xFFEAF7F9);

  static final List<BoxShadow> softShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.14),
      blurRadius: 20,
      offset: const Offset(0, 8),
      spreadRadius: -4,
    ),
    BoxShadow(
      color: ink.withValues(alpha: 0.06),
      blurRadius: 10,
      offset: const Offset(0, 3),
    ),
  ];

  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.10),
      blurRadius: 16,
      offset: const Offset(0, 5),
      spreadRadius: -2,
    ),
    BoxShadow(
      color: ink.withValues(alpha: 0.05),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  static final List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: primaryDark.withValues(alpha: 0.22),
      blurRadius: 26,
      offset: const Offset(0, 12),
      spreadRadius: -6,
    ),
    BoxShadow(
      color: ink.withValues(alpha: 0.07),
      blurRadius: 10,
      offset: const Offset(0, 3),
    ),
  ];

  static final List<BoxShadow> floatShadow = [
    BoxShadow(
      color: primaryDeep.withValues(alpha: 0.24),
      blurRadius: 28,
      offset: const Offset(0, 14),
      spreadRadius: -8,
    ),
  ];
}
