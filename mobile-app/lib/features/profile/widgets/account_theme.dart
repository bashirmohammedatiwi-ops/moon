import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../cart/widgets/cart_theme.dart';

/// ثيم صفحة حسابي — عائلة فيروزية واحدة بدون ألوان متضاربة.
abstract final class AccountTheme {
  static const pageBg = AppColors.scaffold;
  static const sectionGap = 20.0;
  static const hPad = 18.0;

  static const orders = AppColors.primary;
  static const wishlist = AppColors.primaryDark;
  static const loyalty = Color(0xFF1AA3B0);
  static const addresses = Color(0xFF0C7475);
  static const brands = Color(0xFF48C0D0);
  static const notifications = AppColors.primary;
  static const settings = Color(0xFF4F6E74);
  static const danger = Color(0xFFC04545);
  static const dangerSoft = Color(0xFFFFF0F0);

  static BoxDecoration pageCard({Color? color}) => BoxDecoration(
        color: color ?? CartTheme.card,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.hairline.withValues(alpha: 0.85)),
        boxShadow: AppColors.cardShadow,
      );

  static BoxDecoration heroDecoration() => BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(30),
        boxShadow: AppColors.floatShadow,
      );

  static Widget sectionTitle(String title, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(width: 10),
          if (icon != null) ...[
            Icon(icon, size: 17, color: CartTheme.brandDark),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: CartTheme.charcoal,
              letterSpacing: -0.15,
            ),
          ),
        ],
      ),
    );
  }
}
