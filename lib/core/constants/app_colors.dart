import 'package:flutter/material.dart';

/// Centralized color palette for the Deen-Step application.
/// Provides rich emerald, warm gold, and neutral slate tones.
abstract final class AppColors {
  // Verified Figma Palette
  static const Color splashBackground = Color(0xFF0B120E);
  static const Color authBackground = Color(0xFF111311);
  static const Color brandLime = Color(0xFFC6F432);
  static const Color brandLimeDark = Color(0xFFA5D11E);
  static const Color buttonDisabledBg = Color(0xFF334311);
  static const Color buttonDisabledText = Color(0xFF6A7F36);
  static const Color inputBackground = Color(0xFF181C19);
  static const Color inputBorder = Color(0xFF232B25);
  static const Color inputHint = Color(0xFF5D6861);
  static const Color darkButtonBg = Color(0xFF16211A);
  static const Color darkButtonBorder = Color(0xFF223127);
  static const Color mosqueSilhouette = Color(0xFF132219);
  static const Color textMuted = Color(0xFF8E9B93);

  // Primary Emerald Greens
  static const Color primary = Color(0xFF0D5C3A);
  static const Color primaryDark = Color(0xFF083C25);
  static const Color primaryLight = Color(0xFF1B8A5A);
  static const Color primaryContainer = Color(0xFFE2F4EB);

  // Accent Brand Lime
  static const Color accent = Color(0xFFC6F432);
  static const Color accentLight = Color(0xFFE4F98E);
  static const Color accentDark = Color(0xFFA5D11E);

  // Neutral Backgrounds & Surfaces (Light)
  static const Color backgroundLight = Color(0xFFF9FBF9);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE5EBE6);

  // Neutral Backgrounds & Surfaces (Dark)
  static const Color backgroundDark = Color(0xFF0F1512);
  static const Color surfaceDark = Color(0xFF17201C);
  static const Color cardDark = Color(0xFF1E2823);
  static const Color borderDark = Color(0xFF28362F);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF111814);
  static const Color textSecondaryLight = Color(0xFF5A6660);
  static const Color textTertiaryLight = Color(0xFF8E9B94);

  static const Color textPrimaryDark = Color(0xFFF0F4F2);
  static const Color textSecondaryDark = Color(0xFFA5B2AC);
  static const Color textTertiaryDark = Color(0xFF6F7E77);

  // Status & Feedback Colors
  static const Color success = Color(0xFF1E8E3E);
  static const Color warning = Color(0xFFF9AB00);
  static const Color error = Color(0xFFD93025);
  static const Color info = Color(0xFF1A73E8);
}
