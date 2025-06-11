import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

// Color Scheme 3: Modern Minimalist
class ModernMinimalistColors {
  static const Color primaryLightGray = Color(0xFFDCDCDC); // Gainsboro
  static const Color secondaryWhite = AppColors.white;
  static const Color accentLavender = Color(0xFFE6E6FA); // Lavender
  static const Color backgroundOffWhite = Color(0xFFF8F8F8); // White Smoke
  static const Color textDarkGray = Color(0xFF2F4F4F); // Dark Slate Gray
}

// Example Usage in a Flutter ThemeData
ThemeData modernMinimalistTheme() {
  return ThemeData(
    primaryColor: ModernMinimalistColors.primaryLightGray,
    hintColor: ModernMinimalistColors.accentLavender,
    scaffoldBackgroundColor: ModernMinimalistColors.backgroundOffWhite,
    appBarTheme: const AppBarTheme(
      backgroundColor: ModernMinimalistColors.primaryLightGray,
      foregroundColor: ModernMinimalistColors.textDarkGray,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: ModernMinimalistColors.textDarkGray),
      bodyMedium: TextStyle(color: ModernMinimalistColors.textDarkGray),
      titleLarge: TextStyle(color: ModernMinimalistColors.textDarkGray),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: ModernMinimalistColors.accentLavender,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ModernMinimalistColors.secondaryWhite,
    ),
  );
}
