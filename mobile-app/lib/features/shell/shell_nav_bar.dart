import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/entrance.dart';
import '../../core/utils/responsive.dart';

/// شريط تنقل سفلي عائم — كبسولة فيروزية للتبويب النشط.
class ShellNavBar extends StatelessWidget {
  final int currentIndex;
  final int cartCount;
  final ValueChanged<int> onSelect;
  final AppStrings strings;

  const ShellNavBar({
    super.key,
    required this.currentIndex,
    required this.cartCount,
    required this.onSelect,
    required this.strings,
  });

  static const _duration = Duration(milliseconds: 260);

  @override
  Widget build(BuildContext context) {
    final barHeight = Responsive.bottomNavHeight(context);
    final systemInset = Responsive.systemBottomInset(context);

    final items = [
      _NavItemData(0, Icons.home_outlined, Icons.home_rounded, strings.navHome),
      _NavItemData(1, Icons.grid_view_outlined, Icons.grid_view_rounded, strings.navCategories),
      _NavItemData(2, Icons.local_offer_outlined, Icons.local_offer_rounded, strings.navOffers),
      _NavItemData(3, Icons.shopping_bag_outlined, Icons.shopping_bag_rounded, strings.navCart, badge: cartCount),
      _NavItemData(4, Icons.person_outline_rounded, Icons.person_rounded, strings.navAccount),
    ];

    return RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.96),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border(
            top: BorderSide(color: AppColors.hairline.withValues(alpha: 0.9)),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.12),
              blurRadius: 28,
              offset: const Offset(0, -8),
              spreadRadius: -8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: barHeight,
                  child: Row(
                    children: [
                      for (final item in items)
                        _NavTab(
                          item: item,
                          active: currentIndex == item.index,
                          onTap: () {
                            HapticFeedback.selectionClick();
                            onSelect(item.index);
                          },
                        ),
                    ],
                  ),
                ),
                if (systemInset > 0) SizedBox(height: systemInset),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final int index;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int badge;

  const _NavItemData(this.index, this.icon, this.activeIcon, this.label, {this.badge = 0});
}

class _NavTab extends StatelessWidget {
  final _NavItemData item;
  final bool active;
  final VoidCallback onTap;

  const _NavTab({
    required this.item,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final narrow = Responsive.isNarrow(context);
    final iconSize = narrow ? 20.0 : 22.0;
    final inactiveColor = AppColors.ink.withValues(alpha: 0.36);
    final activeColor = AppColors.primaryDark;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: AppColors.primaryLight,
          highlightColor: AppColors.primarySoft,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: ShellNavBar._duration,
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.symmetric(
                    horizontal: active ? 14 : 10,
                    vertical: active ? 6 : 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: active ? AppColors.primaryGradient : null,
                    color: active ? null : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    boxShadow: active
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.28),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        active ? item.activeIcon : item.icon,
                        size: iconSize,
                        color: active ? Colors.white : inactiveColor,
                      ),
                      if (item.badge > 0)
                        Positioned(
                          top: -6,
                          right: -8,
                          child: _Badge(count: item.badge),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedDefaultTextStyle(
                  duration: ShellNavBar._duration,
                  curve: Curves.easeOutCubic,
                  style: GoogleFonts.cairo(
                    fontSize: Responsive.navLabelSize(context, active: active),
                    fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                    color: active ? activeColor : inactiveColor,
                    height: 1.05,
                  ),
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final int count;
  const _Badge({required this.count});

  @override
  Widget build(BuildContext context) {
    return PulseOnChange(
      trigger: count,
      from: 1.25,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
        decoration: BoxDecoration(
          color: AppColors.inkDeep,
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          count > 9 ? '9+' : '$count',
          style: GoogleFonts.cairo(
            color: Colors.white,
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),
      ),
    );
  }
}

double shellNavOuterHeight(BuildContext context) {
  return Responsive.shellNavDockHeight(context);
}
