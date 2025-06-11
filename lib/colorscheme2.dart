import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

// Color Scheme 2: Earthy Serenity
class EarthySerenityColors {
  static const Color primaryTaupe = Color(0xFFBDB76B); // Dark Khaki
  static const Color secondaryOlive = Color(0xFF808000); // Olive
  static const Color accentCream = Color(0xFFFFFDD0); // Cream
  static const Color backgroundBeige = Color(0xFFF5F5DC); // Beige
  static const Color textDarkBrown = Color(0xFF5C4033); // Coffee
}

// Example Usage in a Flutter ThemeData
ThemeData earthySerenityTheme() {
  return ThemeData(
    primaryColor: EarthySerenityColors.primaryTaupe,
    hintColor: EarthySerenityColors.secondaryOlive,
    scaffoldBackgroundColor: EarthySerenityColors.backgroundBeige,
    appBarTheme: const AppBarTheme(
      backgroundColor: EarthySerenityColors.primaryTaupe,
      foregroundColor: EarthySerenityColors.textDarkBrown,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: EarthySerenityColors.textDarkBrown),
      bodyMedium: TextStyle(color: EarthySerenityColors.textDarkBrown),
      titleLarge: TextStyle(color: EarthySerenityColors.textDarkBrown),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: EarthySerenityColors.secondaryOlive,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: EarthySerenityColors.accentCream,
    ),
  );
}
