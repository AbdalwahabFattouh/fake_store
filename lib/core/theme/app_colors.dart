import 'package:flutter/material.dart';
class AppColors {
  static const Color primary = Color(0xFF4361EE);
  static const Color secondary = Color(0xFF3F37C9);
  static const Color accent = Color(0xFFFFC300);
  static const Color success = Color(0xFF4CC9F0);
  static const Color error = Color(0xFFE63946);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textLight = Color(0xFF212529);
  static const Color textDark = Color(0xFFF8F9FA);

  static const Color navBarBackgroundLight = Colors.white;
  static const Color navBarBackgroundDark = Color(0xFF1A1A1A);
  static const Color navBarSelectedLight = Color(0xFF667EEA);
  static const Color navBarSelectedDark = Color(0xFF7B8FFE);
  static const Color navBarUnselectedLight = Color(0xFF9E9E9E);
  static const Color navBarUnselectedDark = Color(0xFF757575);
  static const Color navBarShadowLight = Color(0x1A000000);
  static const Color navBarShadowDark = Color(0x4D000000);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
