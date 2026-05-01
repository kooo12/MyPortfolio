import 'package:flutter/material.dart';

class AppColors {
  // Surfaces
  static const Color background = Color(0xFF131313);
  static const Color backgroundBottom = Color(0xFF0E0E0E);
  static const Color surface = Color(0xFF1C1B1B);
  static const Color surfaceLight = Color(0xFF2A2A2A);
  static const Color surfaceContainer = Color(0xFF201F1F);
  static const Color surfaceContainerHigh = Color(0xFF2A2A2A);
  static const Color surfaceContainerHighest = Color(0xFF353534);

  // Primary / Accent — Electric Blue
  static const Color accent = Color(0xFF4B8EFF);
  static const Color primary = Color(0xFFADC6FF);
  static const Color primaryContainer = Color(0xFF4B8EFF);
  static const Color secondary = Color(0xFF39485A);
  static const Color highlight = Color(0xFF8B90A0);
  static const Color warmTeal = Color(0xFF2F4F4F);

  // Text
  static const Color textPrimary = Color(0xFFE5E2E1);
  static const Color textSecondary = Color(0xFFC1C6D7);
  static const Color textDim = Color(0xFF8B90A0);

  // Outline
  static const Color outline = Color(0xFF8B90A0);
  static const Color outlineVariant = Color(0xFF414755);

  // Gradients
  static const LinearGradient bgGradient = LinearGradient(
    colors: [background, backgroundBottom],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0x1AFFFFFF), Color(0x0DFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
