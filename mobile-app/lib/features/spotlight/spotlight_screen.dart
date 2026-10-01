import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/l10n/locale_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/friendly_error.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/app_network_image.dart';
import '../../core/widgets/states.dart';
import '../../data/models/spotlight_item.dart';
import '../home/home_link.dart';
import 'spotlight_providers.dart';

/// «سبوت لايت» — تغذية عمودية بصور دعائية مميزة (مثل ريلز).
class SpotlightScreen extends ConsumerStatefulWidget {
  const SpotlightScreen({super.key});

  @override
  ConsumerState<SpotlightScreen> createState() => _SpotlightScreenState();
}

class _SpotlightScreenState extends ConsumerState<SpotlightScreen> {
  final _pageController = PageController();
  int _index = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feed = ref.watch(spotlightFeedProvider);
    final lang = ref.watch(languageCodeProvider);
    final s = ref.s;
    final bottomPad = Responsive.shellBottomReserve(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.inkDeep,
        body: feed.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          ),
          error: (e, _) => ErrorView(
            message: friendlyError(e),
            onRetry: () => ref.invalidate(spotlightFeedProvider),
          ),
          data: (items) {
            if (items.isEmpty) {
              return _SpotlightEmpty(s: s);
            }

            return Stack(
              fit: StackFit.expand,
              children: [
                PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: items.length,
                  onPageChanged: (i) {
                    HapticFeedback.lightImpact();
                    setState(() => _index = i);
                  },
                  itemBuilder: (context, i) {
                    return _SpotlightSlide(
                      item: items[i],
                      lang: lang,
                      s: s,
                      active: i == _index,
                    );
                  },
                ),
                _SpotlightChrome(
                  s: s,
                  count: items.length,
                  index: _index,
                  bottomPad: bottomPad,
                ),
                Positioned(
                  right: 14,
                  top: MediaQuery.paddingOf(context).top + 72,
                  bottom: bottomPad + 120,
                  child: _ReelProgress(
                    count: items.length,
                    index: _index,
                    onTap: (i) {
                      _pageController.animateToPage(
                        i,
                        duration: const Duration(milliseconds: 420),
                        curve: Curves.easeOutCubic,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SpotlightSlide extends StatelessWidget {
  final SpotlightItem item;
  final String lang;
  final AppStrings s;
  final bool active;

  const _SpotlightSlide({
    required this.item,
    required this.lang,
    required this.s,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final title = item.titleForLang(lang) ?? '';
    final subtitle = item.subtitleForLang(lang);
    final badge = item.badgeForLang(lang);
    final cta = item.ctaForLang(lang) ?? s.spotlightDefaultCta;
    final imageUrl = item.imageUrl;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (imageUrl.isNotEmpty)
          AppNetworkImage(
            url: imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        else
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppColors.offerHeroGradient,
            ),
            child: Center(
              child: Icon(Icons.auto_awesome, size: 72, color: Colors.white.withValues(alpha: 0.25)),
            ),
          ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.35),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.08),
                Colors.black.withValues(alpha: 0.82),
              ],
              stops: const [0.0, 0.22, 0.62, 1.0],
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 56,
          bottom: Responsive.shellBottomReserve(context) + 28,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 320),
            opacity: active ? 1 : 0.72,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (badge != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(99),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.45),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      badge,
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                Text(
                  title,
                  style: GoogleFonts.elMessiri(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                    shadows: const [
                      Shadow(color: Colors.black54, blurRadius: 12, offset: Offset(0, 2)),
                    ],
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: GoogleFonts.cairo(
                      color: Colors.white.withValues(alpha: 0.88),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.45,
                    ),
                  ),
                ],
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Material(
                      color: Colors.white.withValues(alpha: 0.14),
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          openSectionLink(
                            context,
                            linkType: item.linkType,
                            linkValue: item.linkValue,
                            legacyLink: item.link,
                            resolvedLink: item.link,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                cta,
                                style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Directionality.of(context) == TextDirection.rtl
                                    ? Icons.arrow_back_rounded
                                    : Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SpotlightChrome extends StatelessWidget {
  final AppStrings s;
  final int count;
  final int index;
  final double bottomPad;

  const _SpotlightChrome({
    required this.s,
    required this.count,
    required this.index,
    required this.bottomPad,
  });

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    return IgnorePointer(
      child: Column(
        children: [
          SizedBox(height: top + 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
                    color: Colors.black.withValues(alpha: 0.25),
                  ),
                  child: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.spotlightTitle,
                      style: GoogleFonts.elMessiri(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${index + 1} / $count',
                      style: GoogleFonts.cairo(
                        color: Colors.white.withValues(alpha: 0.72),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          if (index == 0)
            Padding(
              padding: EdgeInsets.only(bottom: bottomPad + 8),
              child: Column(
                children: [
                  Icon(Icons.keyboard_arrow_up_rounded, color: Colors.white.withValues(alpha: 0.55), size: 28),
                  Text(
                    s.spotlightSwipeHint,
                    style: GoogleFonts.cairo(
                      color: Colors.white.withValues(alpha: 0.55),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ReelProgress extends StatelessWidget {
  final int count;
  final int index;
  final ValueChanged<int> onTap;

  const _ReelProgress({
    required this.count,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count.clamp(0, 12), (i) {
        final active = i == index;
        return GestureDetector(
          onTap: () => onTap(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            margin: const EdgeInsets.symmetric(vertical: 3),
            width: 4,
            height: active ? 34 : 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              gradient: active ? AppColors.primaryGradient : null,
              color: active ? null : Colors.white.withValues(alpha: 0.28),
              boxShadow: active
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.55),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }
}

class _SpotlightEmpty extends StatelessWidget {
  final AppStrings s;

  const _SpotlightEmpty({required this.s});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.photo_filter_outlined, size: 56, color: Colors.white.withValues(alpha: 0.35)),
            const SizedBox(height: 16),
            Text(
              s.spotlightEmpty,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
