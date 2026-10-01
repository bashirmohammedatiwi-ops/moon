import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// ورقة/زخرفة هوية قمر الزمان — تستخدم في الحالات الفارغة والسبلاش.
class LeafArt extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const LeafArt({
    super.key,
    this.size = 120,
    this.color = AppColors.primary,
    this.strokeWidth = 2.2,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _LeafPainter(color: color, strokeWidth: strokeWidth),
    );
  }
}

/// توافق خلفي مع الاسم القديم.
typedef ButterflyArt = LeafArt;

class _LeafPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _LeafPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fill = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    final c = Offset(size.width / 2, size.height * 0.58);
    final w = size.width * 0.22;
    final h = size.height * 0.28;

    Path leaf(double dx, double dy, double scale, double tilt) {
      final path = Path();
      final tip = Offset(c.dx + dx, c.dy + dy - h * scale);
      final left = Offset(c.dx + dx - w * scale, c.dy + dy);
      final right = Offset(c.dx + dx + w * scale * 0.55, c.dy + dy + h * 0.15 * scale);
      path.moveTo(tip.dx, tip.dy);
      path.quadraticBezierTo(left.dx, left.dy - h * 0.2 * scale, left.dx, left.dy);
      path.quadraticBezierTo(
        c.dx + dx,
        c.dy + dy + h * 0.35 * scale,
        right.dx,
        right.dy,
      );
      path.quadraticBezierTo(
        tip.dx + w * 0.15 * scale,
        tip.dy + h * 0.25 * scale,
        tip.dx,
        tip.dy,
      );
      // mild rotation around tip base
      final matrix = Matrix4.identity()
        ..translateByDouble(c.dx + dx, c.dy + dy, 0, 1)
        ..rotateZ(tilt)
        ..translateByDouble(-(c.dx + dx), -(c.dy + dy), 0, 1);
      return path.transform(matrix.storage);
    }

    final leaves = [
      leaf(-w * 0.35, -h * 0.1, 1.05, -0.35),
      leaf(w * 0.05, -h * 0.35, 1.2, 0.05),
      leaf(w * 0.55, -h * 0.05, 0.95, 0.42),
      leaf(w * 0.95, h * 0.15, 0.7, 0.75),
    ];

    for (final path in leaves) {
      canvas.drawPath(path, fill);
      canvas.drawPath(path, paint);
    }

    // منحنى سفلي كالخط السائل تحت الشعار.
    final wave = Path()
      ..moveTo(size.width * 0.12, size.height * 0.78)
      ..cubicTo(
        size.width * 0.35,
        size.height * 0.92,
        size.width * 0.65,
        size.height * 0.62,
        size.width * 0.88,
        size.height * 0.82,
      );
    canvas.drawPath(wave, paint);
  }

  @override
  bool shouldRepaint(covariant _LeafPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}

/// خلفية محيطية متحركة — بقع ضوء فيروزية ناعمة خلف محتوى الشاشة.
class AmbientBackground extends StatefulWidget {
  final Widget child;
  final Color baseColor;

  const AmbientBackground({
    super.key,
    required this.child,
    this.baseColor = AppColors.scaffold,
  });

  @override
  State<AmbientBackground> createState() => _AmbientBackgroundState();
}

class _AmbientBackgroundState extends State<AmbientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        foregroundPainter: _AmbientPainter(animation: _controller),
        child: widget.child,
      ),
    );
  }
}

class _AmbientPainter extends CustomPainter {
  final Animation<double> animation;

  _AmbientPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value * 2 * math.pi;
    final blob = (Offset center, double radius, Color color) => Paint()
          ..shader = RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ).createShader(
            Rect.fromCircle(center: center, radius: radius),
          );

    final spots = [
      (
        center: Offset(
          size.width * (0.22 + 0.05 * math.sin(t)),
          size.height * (0.12 + 0.04 * math.cos(t * 0.8)),
        ),
        radius: size.width * 0.55,
        color: AppColors.primaryLight,
      ),
      (
        center: Offset(
          size.width * (0.85 + 0.04 * math.cos(t * 0.6)),
          size.height * (0.30 + 0.05 * math.sin(t * 0.9)),
        ),
        radius: size.width * 0.5,
        color: AppColors.accentSoft,
      ),
      (
        center: Offset(
          size.width * (0.5 + 0.06 * math.sin(t * 0.7)),
          size.height * (0.62 + 0.04 * math.cos(t)),
        ),
        radius: size.width * 0.6,
        color: const Color(0xFFEAF7F9),
      ),
    ];
    for (final spot in spots) {
      canvas.drawCircle(spot.center, spot.radius, blob(spot.center, spot.radius, spot.color));
    }
  }

  @override
  bool shouldRepaint(covariant _AmbientPainter oldDelegate) => true;
}

/// فاصل موجي زخرفي بين أقسام الصفحة — موجة واحدة بمنحنى ناعم.
class WaveDivider extends StatelessWidget {
  final Color color;
  final bool flip;
  final double height;

  const WaveDivider({
    super.key,
    this.color = AppColors.divider,
    this.flip = false,
    this.height = 10,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height),
      painter: _WavePainter(color: color, flip: flip),
    );
  }
}

class _WavePainter extends CustomPainter {
  final Color color;
  final bool flip;

  _WavePainter({required this.color, required this.flip});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, flip ? 0 : size.height)
      ..quadraticBezierTo(
        size.width * 0.28,
        flip ? size.height * 1.1 : size.height * 0.05,
        size.width * 0.55,
        flip ? size.height * 0.45 : size.height * 0.62,
      )
      ..quadraticBezierTo(
        size.width * 0.8,
        flip ? size.height * 0.05 : size.height,
        size.width,
        flip ? size.height * 0.5 : size.height * 0.35,
      );
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.flip != flip;
}
