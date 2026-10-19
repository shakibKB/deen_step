import 'package:flutter/material.dart';

/// Renders the subtle celestial star specks visible in the Figma background.
class StarFieldPainter extends CustomPainter {
  const StarFieldPainter();

  // Normalized (x, y, radius, opacity) coordinates matching the Figma starry sky
  static const List<List<double>> stars = [
    [0.12, 0.08, 1.2, 0.6],
    [0.28, 0.14, 1.0, 0.5],
    [0.72, 0.11, 1.4, 0.7],
    [0.85, 0.18, 1.0, 0.4],
    [0.18, 0.25, 0.8, 0.5],
    [0.48, 0.22, 1.1, 0.6],
    [0.91, 0.29, 0.9, 0.4],
    [0.08, 0.42, 1.3, 0.7],
    [0.22, 0.55, 0.9, 0.4],
    [0.82, 0.48, 1.2, 0.5],
    [0.34, 0.68, 1.0, 0.6],
    [0.76, 0.62, 0.8, 0.4],
    [0.15, 0.78, 1.1, 0.5],
    [0.88, 0.82, 1.0, 0.4],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      final x = star[0] * size.width;
      final y = star[1] * size.height;
      final radius = star[2];
      final opacity = star[3];

      final paint = Paint()
        ..color = Colors.white.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
