import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF6D5DF6);
  static const ink = Color(0xFF17151F);
  static const muted = Color(0xFF766F82);
  static const line = Color(0xFFE8E2DC);
  static const background = Color(0xFFF7F4EF);
  static const field = Color(0xFFF8F7FB);
  static const green = Color(0xFF22A06B);
  static const amber = Color(0xFFE9A23B);
  static const red = Color(0xFFE25563);
  static const blue = Color(0xFF2F80ED);
}

ThemeData buildSalonTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: Colors.white,
    ),
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.ink,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.field,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        side: const BorderSide(color: Color(0xFFE4DFEE)),
        foregroundColor: AppColors.ink,
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    ),
  );
}
