import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import 'home_theme.dart';

/// بطاقة دخول للعروض — أسفل الأقسام في الرئيسية.
class HomeOffersPromoCard extends ConsumerWidget {
  const HomeOffersPromoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.s;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: const EdgeInsets.fromLTRB(HomeTheme.paddingH, 6, HomeTheme.paddingH, 4),
      child: Column(
        children: [
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 22,
            color: AppColors.primary.withValues(alpha: 0.65),
          ),
          const SizedBox(height: 2),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                HapticFeedback.mediumImpact();
                context.push('/offers');
              },
              borderRadius: BorderRadius.circular(24),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: AppColors.offerHeroGradient,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: AppColors.floatShadow,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: isRtl ? null : -18,
                      left: isRtl ? -18 : null,
                      top: -20,
                      child: Icon(
                        Icons.local_offer_rounded,
                        size: 110,
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.primaryGradient,
                              border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
                            ),
                            child: const Icon(Icons.local_offer_rounded, color: Colors.white, size: 26),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  s.offersPromoTitle,
                                  style: GoogleFonts.elMessiri(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    height: 1.15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  s.offersPromoSubtitle,
                                  style: GoogleFonts.cairo(
                                    color: Colors.white.withValues(alpha: 0.82),
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.16),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
                            ),
                            child: Icon(
                              isRtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
