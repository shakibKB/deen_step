import 'package:flutter/material.dart';

/// Centralized spacing, border radii, and edge insets.
abstract final class AppSpacing {
  // Spacing Units
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 48.0;

  // Corner Radii
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // Common Paddings
  static const EdgeInsets paddingPage = EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);
  static const EdgeInsets paddingCard = EdgeInsets.all(16.0);
  static const EdgeInsets paddingButton = EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0);
}
