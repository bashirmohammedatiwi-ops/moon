import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/widgets/brand_art.dart';

abstract final class SplashTheme {
  static const background = AppColors.scaffold;
  static const teal = AppColors.primary;
  static const tealDark = AppColors.primaryDark;
  static const charcoal = AppColors.ink;
}

/// شاشة افتتاح بهوية قمر الزمان — ضباب فيروزي + شعار كبير.
class SplashScreen extends StatefulWidget {
  final String lang;

  const SplashScreen({super.key, this.lang = 'ar'});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<double> _rise;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _scale = Tween<double>(begin: 0.86, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.7, curve: Curves.easeOutBack)),
    );
    _rise = Tween<double>(begin: 18, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.15, 1, curve: Curves.easeOutCubic)),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeName = AppConfig.displayStoreName(widget.lang);
    final tagline = widget.lang == 'ar' ? 'جمالك… على ضوء القمر' : 'beauty under the moon light';

    return Scaffold(
      backgroundColor: SplashTheme.background,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.homeBackgroundGradient,
        ),
        child: AmbientBackground(
          baseColor: SplashTheme.background,
          child: SafeArea(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fade.value,
                    child: Transform.translate(
                      offset: Offset(0, _rise.value),
                      child: Transform.scale(
                        scale: _scale.value,
                        child: child,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 148,
                        height: 148,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: AppColors.accent.withValues(alpha: 0.45), width: 1.4),
                          boxShadow: AppColors.floatShadow,
                        ),
                        child: Image.asset(
                          'assets/images/qamar_logo.png',
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        storeName,
                        textAlign: TextAlign.center,
                        style: brandTitleStyle(
                          lang: widget.lang,
                          size: 36,
                          color: SplashTheme.charcoal,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const WaveDivider(color: AppColors.primary, height: 12),
                      const SizedBox(height: 14),
                      Text(
                        tagline,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: SplashTheme.tealDark.withValues(alpha: 0.85),
                          height: 1.45,
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
    );
  }
}
