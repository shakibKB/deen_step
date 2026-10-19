import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Renders the vector-precise mosque silhouette rising from the bottom of the screen.
class MosqueSilhouettePainter extends CustomPainter {
  final Color color;

  MosqueSilhouettePainter({this.color = AppColors.mosqueSilhouette});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Start bottom-left
    path.moveTo(0, h);

    // Far Left Minaret
    path.lineTo(w * 0.04, h);
    path.lineTo(w * 0.04, h * 0.15);
    // Left minaret balcony and spire
    path.lineTo(w * 0.03, h * 0.14);
    path.lineTo(w * 0.05, h * 0.03); // spire tip
    path.lineTo(w * 0.07, h * 0.14);
    path.lineTo(w * 0.06, h * 0.15);
    path.lineTo(w * 0.06, h * 0.55);

    // Left Inner Minaret
    path.lineTo(w * 0.16, h * 0.55);
    path.lineTo(w * 0.16, h * 0.28);
    path.lineTo(w * 0.15, h * 0.27);
    path.lineTo(w * 0.175, h * 0.18); // spire tip
    path.lineTo(w * 0.20, h * 0.27);
    path.lineTo(w * 0.19, h * 0.28);
    path.lineTo(w * 0.19, h * 0.62);

    // Left Small Dome
    path.lineTo(w * 0.22, h * 0.62);
    // Draw dome arc
    path.quadraticBezierTo(w * 0.22, h * 0.48, w * 0.31, h * 0.42);
    // Dome pointed tip
    path.lineTo(w * 0.32, h * 0.38);
    path.lineTo(w * 0.33, h * 0.42);
    path.quadraticBezierTo(w * 0.42, h * 0.48, w * 0.42, h * 0.62);

    // Central Grand Dome
    path.lineTo(w * 0.36, h * 0.60);
    path.quadraticBezierTo(w * 0.36, h * 0.25, w * 0.49, h * 0.10);
    // Grand Dome Spire / Finial
    path.lineTo(w * 0.50, h * 0.05); // Central top tip
    path.lineTo(w * 0.51, h * 0.10);
    path.quadraticBezierTo(w * 0.64, h * 0.25, w * 0.64, h * 0.60);

    // Right Small Dome
    path.lineTo(w * 0.58, h * 0.62);
    path.quadraticBezierTo(w * 0.58, h * 0.48, w * 0.67, h * 0.42);
    // Dome pointed tip
    path.lineTo(w * 0.68, h * 0.38);
    path.lineTo(w * 0.69, h * 0.42);
    path.quadraticBezierTo(w * 0.78, h * 0.48, w * 0.78, h * 0.62);

    // Right Inner Minaret
    path.lineTo(w * 0.81, h * 0.62);
    path.lineTo(w * 0.81, h * 0.28);
    path.lineTo(w * 0.80, h * 0.27);
    path.lineTo(w * 0.825, h * 0.18); // spire tip
    path.lineTo(w * 0.85, h * 0.27);
    path.lineTo(w * 0.84, h * 0.28);
    path.lineTo(w * 0.84, h * 0.55);

    // Far Right Minaret
    path.lineTo(w * 0.94, h * 0.55);
    path.lineTo(w * 0.94, h * 0.15);
    path.lineTo(w * 0.93, h * 0.14);
    path.lineTo(w * 0.95, h * 0.03); // spire tip
    path.lineTo(w * 0.97, h * 0.14);
    path.lineTo(w * 0.96, h * 0.15);
    path.lineTo(w * 0.96, h);

    // Close at bottom-right
    path.lineTo(w, h);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
