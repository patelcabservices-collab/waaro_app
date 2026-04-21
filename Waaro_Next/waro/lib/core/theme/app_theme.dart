import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primaryDark,
      surface: AppColors.white,
      background: AppColors.background,
      error: AppColors.error,
    ),
    textTheme: GoogleFonts.outfitTextTheme().copyWith(
      displayLarge: GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.foreground,
        letterSpacing: -1.0,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.foreground,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.foreground,
      ),
      bodyLarge: GoogleFonts.outfit(
        fontSize: 16,
        color: AppColors.foreground,
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: 14,
        color: AppColors.foreground,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        elevation: 0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primaryDark,
      surface: const Color(0xFF1F2937),
      background: AppColors.darkBackground,
      error: AppColors.error,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.darkForeground,
        letterSpacing: -1.0,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.darkForeground,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.darkForeground,
      ),
      bodyLarge: GoogleFonts.outfit(
        fontSize: 16,
        color: AppColors.darkForeground,
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: 14,
        color: AppColors.darkForeground,
      ),
    ),
    // ... similar to light theme with dark colors
  );
}
