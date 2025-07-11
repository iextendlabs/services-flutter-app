import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

// Color Scheme 1: Tranquil Oasis
class TranquilOasisColors {
  static const Color primaryBlue = Color(0xFF87CEEB); // Sky Blue
  static const Color secondaryGreen = Color(0xFF90EE90); // Light Green
  static const Color accentGray = Color(0xFFD3D3D3); // Light Gray
  static const Color backgroundBlue = Color(0xFFF0F8FF); // Alice Blue
  static const Color textDarkGray = Color(0xFF36454F); // Charcoal
}

// Example Usage in a Flutter ThemeData
ThemeData tranquilOasisTheme() {
  return ThemeData(
    primaryColor: TranquilOasisColors.primaryBlue,
    hintColor: TranquilOasisColors.secondaryGreen, // Often used for accents
    scaffoldBackgroundColor: TranquilOasisColors.backgroundBlue,
    appBarTheme: const AppBarTheme(
      backgroundColor: TranquilOasisColors.primaryBlue,
      foregroundColor: AppColors.white, // Text on app bar
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: TranquilOasisColors.textDarkGray),
      bodyMedium: TextStyle(color: TranquilOasisColors.textDarkGray),
      titleLarge: TextStyle(color: TranquilOasisColors.textDarkGray),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: TranquilOasisColors.secondaryGreen,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: TranquilOasisColors.accentGray,
    ),
  );
}
