import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// The official Deen-Step crescent moon brand mark in neon lime.
class DeenStepLogo extends StatelessWidget {
  final double size;

  const DeenStepLogo({super.key, this.size = 56.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.brandLime,
        borderRadius: BorderRadius.circular(size * 0.32),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandLime.withValues(alpha: 0.25),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: CustomPaint(
          size: Size(size * 0.52, size * 0.52),
          painter: _CrescentMoonPainter(color: AppColors.splashBackground),
        ),
      ),
    );
  }
}

class _CrescentMoonPainter extends CustomPainter {
  final Color color;

  _CrescentMoonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final outerPath = Path();
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final outerRadius = size.width * 0.5;

    outerPath.addOval(Rect.fromCircle(center: center, radius: outerRadius));

    // Inner cutout creating the crescent
    final innerPath = Path();
    final innerCenter = Offset(size.width * 0.64, size.height * 0.42);
    final innerRadius = size.width * 0.42;
    innerPath.addOval(Rect.fromCircle(center: innerCenter, radius: innerRadius));

    // Subtract inner from outer
    final crescentPath = Path.combine(PathOperation.difference, outerPath, innerPath);

    // Rotate slightly to match Islamic crescent aesthetic
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-math.pi / 8);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawPath(crescentPath, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
