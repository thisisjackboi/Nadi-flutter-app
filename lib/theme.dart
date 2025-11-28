import 'package:flutter/material.dart';
import 'types.dart';

class AppColors {
  static const Color orange = Color(0xFFFF9933);
  static const Color orangeDark = Color(0xFFD97706);
  static const Color green = Color(0xFF138808);
  static const Color greenLight = Color(0xFF4ADE80);
  static const Color blue = Color(0xFF2563EB);
  static const Color bg = Color(0xFFFFF7ED);
  static const Color text = Color(0xFF1E293B);
  static const Color lightText = Color(0xFF64748B);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.orange,
      scaffoldBackgroundColor: AppColors.bg,
      fontFamily: 'Outfit', // Make sure to add this to pubspec and assets if local, or use google_fonts
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.orange,
        primary: AppColors.orange,
        secondary: AppColors.green,
        surface: Colors.white,
        background: AppColors.bg,
      ),
      useMaterial3: true,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.text),
        bodyMedium: TextStyle(color: AppColors.text),
        titleLarge: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
      ),
    );
  }
}
