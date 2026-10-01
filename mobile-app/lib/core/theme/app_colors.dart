import 'package:flutter/material.dart';

/// هوية متجر قمر الزمان — فيروزي الشعار، خلفية ضبابية بيضاء، تباين داكن للعروض.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF088898);
  static const Color primaryDark = Color(0xFF0C7475);
  static const Color primaryLight = Color(0xFFE6F7F9);
  static const Color primarySoft = Color(0xFFF2FBFC);
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// تباين العروض/المفضلة — فيروزي أعمق
  static const Color rose = Color(0xFF066A78);
  static const Color roseDark = Color(0xFF0A5558);
  static const Color roseLight = Color(0xFFE0F4F6);
  static const Color roseSoft = Color(0xFFD0EFF2);
  static const Color blush = Color(0xFFF5FCFD);

  static const Color accent = Color(0xFF48C0D0);
  static const Color accentSoft = Color(0xFFE8F8FA);
  static const Color ink = Color(0xFF14363C);
  static const Color inkDeep = Color(0xFF0A2428);

  static const Color scaffold = Color(0xFFEEF8F9);
  static const Color mist = Color(0xFFE4F3F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);
  static const Color elevated = Color(0xFFF7FCFD);

  static const Color textPrimary = Color(0xFF14363C);
  static const Color textSecondary = Color(0xFF4F6E74);
  static const Color textMuted = Color(0xFF7F99A0);

  static const Color sale = Color(0xFF0C7475);
  static const Color success = Color(0xFF0F8A6A);
  static const Color warning = Color(0xFFE8A317);
  static const Color star = Color(0xFFF5B942);

  static const Color border = Color(0xFFCDE6EA);
  static const Color divider = Color(0xFFE2F1F3);
  static const Color hairline = Color(0xFFD5EAEF);

  static const Color homeGradientTop = Color(0xFFEAF6F8);
  static const Color homeGradientMid = Color(0xFFF4FBFC);
  static const Color homeSurface = Color(0xFFFFFFFF);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, primary, primaryDark],
    stops: [0.0, 0.45, 1.0],
  );

  static const LinearGradient roseGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, primaryDark],
  );

  static const LinearGradient luxuryGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFE6F7F9), Color(0xFFF8FDFE), Color(0xFFDFF4F6)],
  );

  static const LinearGradient offerHeroGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFF08383E), Color(0xFF0C7475), Color(0xFF1AA3B0)],
  );

  static const LinearGradient homeBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [homeGradientTop, homeGradientMid, scaffold],
    stops: [0.0, 0.35, 1.0],
  );

  static const LinearGradient flashSaleGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFDFF4F6), Color(0xFFF4FBFC)],
  );

  static const LinearGradient mistWash = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF4FBFC), Color(0xFFE6F7F9), Color(0xFFDFF4F6)],
  );

  static const Color shimmerBase = Color(0xFFD5EAEF);
  static const Color shimmerHighlight = Color(0xFFF5FCFD);

  static final List<BoxShadow> softShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.08),
      blurRadius: 22,
      offset: const Offset(0, 8),
      spreadRadius: -6,
    ),
    BoxShadow(
      color: ink.withValues(alpha: 0.04),
      blurRadius: 10,
      offset: const Offset(0, 3),
    ),
  ];

  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.06),
      blurRadius: 18,
      offset: const Offset(0, 6),
      spreadRadius: -4,
    ),
  ];

  static final List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.16),
      blurRadius: 28,
      offset: const Offset(0, 12),
      spreadRadius: -8,
    ),
    BoxShadow(
      color: ink.withValues(alpha: 0.05),
      blurRadius: 10,
      offset: const Offset(0, 3),
    ),
  ];

  static final List<BoxShadow> floatShadow = [
    BoxShadow(
      color: primaryDark.withValues(alpha: 0.14),
      blurRadius: 30,
      offset: const Offset(0, 14),
      spreadRadius: -10,
    ),
  ];
}
