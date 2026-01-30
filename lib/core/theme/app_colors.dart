import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF161617);
  static const Color backgroundBottom = Color(0xFF0F0F10);
  static const Color surface = Color(0xFF1C1C1E);
  static const Color surfaceLight = Color(0xFF2C2C2E);

  static const Color accent = Color(0xFFD4AF37);
  static const Color primary = Color(0xFFB4975A);
  static const Color secondary = Color(0xFF454B4F);
  static const Color highlight = Color(0xFF708090);
  static const Color warmTeal = Color(0xFF2F4F4F);

  static const Color textPrimary = Color(0xFFE5E5E7);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textDim = Color(0xFF71717A);

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
