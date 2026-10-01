import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'sheen.dart';

/// شريط بحث موحّد بهوية قمر الزمان — حبة ناعمة + زر مسح متدرج.
class AppSearchScanBar extends StatelessWidget {
  final String hint;
  final String scanLabel;
  final VoidCallback onSearchTap;
  final VoidCallback onScanTap;
  final double height;
  final Color? fillColor;
  final Color? borderColor;

  const AppSearchScanBar({
    super.key,
    required this.hint,
    required this.scanLabel,
    required this.onSearchTap,
    required this.onScanTap,
    this.height = 52,
    this.fillColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final fill = fillColor ?? Colors.white;
    final border = borderColor ?? AppColors.hairline;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: border, width: 1.1),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  HapticFeedback.selectionClick();
                  onSearchTap();
                },
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 18, end: 8),
                  child: Row(
                    children: [
                      Icon(Icons.search_rounded, size: 21, color: AppColors.primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          hint,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: Sheen(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onScanTap();
                  },
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.barcode_reader, size: 16, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            scanLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
