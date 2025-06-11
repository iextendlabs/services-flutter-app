import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

// Color Scheme 4: Warm & Inviting
class WarmInvitingColors {
  static const Color primaryRose = Color(0xFFF08080); // Light Coral
  static const Color secondaryPeach = Color(0xFFFFDAB9); // Peach Puff
  static const Color accentGold = Color(0xFFDAA520); // Goldenrod
  static const Color backgroundOffWhite = Color(0xFFFFF5EE); // Seashell
  static const Color textMediumBrown = Color(0xFF8B4513); // Saddle Brown
}

// Example Usage in a Flutter ThemeData
ThemeData warmInvitingTheme() {
  return ThemeData(
    primaryColor: WarmInvitingColors.primaryRose,
    hintColor: WarmInvitingColors.secondaryPeach,
    scaffoldBackgroundColor: WarmInvitingColors.backgroundOffWhite,
    appBarTheme: const AppBarTheme(
      backgroundColor: WarmInvitingColors.primaryRose,
      foregroundColor: WarmInvitingColors.textMediumBrown,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: WarmInvitingColors.textMediumBrown),
      bodyMedium: TextStyle(color: WarmInvitingColors.textMediumBrown),
      titleLarge: TextStyle(color: WarmInvitingColors.textMediumBrown),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: WarmInvitingColors.secondaryPeach,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: WarmInvitingColors.accentGold,
    ),
  );
}
