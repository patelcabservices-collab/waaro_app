import 'package:flutter/material.dart';

/// Brand palette aligned with the waaro.in web platform.
class AppColors {
  // Brand yellows
  static const Color primary = Color(0xFFFFD53D); // signature waaro yellow
  static const Color primaryDark = Color(0xFFFFC107);
  static const Color primarySoft = Color(0xFFFFF3C2);

  // Surface
  static const Color background = Color(0xFFFAFAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF4F5F7);

  // Text / dark
  static const Color foreground = Color(0xFF0F172A); // near-black navy
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textMuted = Color(0xFF9CA3AF);

  // Dark mode
  static const Color darkBackground = Color(0xFF0B1020);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkForeground = Color(0xFFF9FAFB);

  // Common
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderSoft = Color(0xFFF1F2F4);
  static const Color grey = Color(0xFF9CA3AF);
  static const Color lightGrey = Color(0xFFF3F4F6);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color successSoft = Color(0xFFE7FBEF);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningSoft = Color(0xFFFFF6E0);
  static const Color error = Color(0xFFEF4444);
  static const Color errorSoft = Color(0xFFFEEAEA);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoSoft = Color(0xFFE6F0FF);

  // Gradients
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFE072), Color(0xFFFFC107)],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF111827), Color(0xFF1F2937)],
  );

  static const LinearGradient softYellowGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFF8DA), Color(0xFFFFFFFF)],
  );

  // Legacy alias kept for any existing references
  static const Color accent = primary;
  static const List<Color> primaryGradient = [Color(0xFFFFE072), Color(0xFFFFC107)];
}
