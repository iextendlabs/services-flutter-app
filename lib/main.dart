import 'package:lipslay_flutter_frontend/button_page.dart';
import 'package:lipslay_flutter_frontend/login2page.dart';
import 'package:lipslay_flutter_frontend/myprofilescreen.dart';
import 'package:lipslay_flutter_frontend/schedule_appointment.dart';

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:http/http.dart' as http;
import 'package:lipslay_flutter_frontend/constants/api_constants.dart'; // For making HTTP requests
import 'package:lipslay_flutter_frontend/go_to_home.dart';
import 'package:lipslay_flutter_frontend/newui.dart';
import 'package:lipslay_flutter_frontend/schedule_screen.dart';
import 'dart:convert'; // For encoding/decoding JSON
import 'package:shared_preferences/shared_preferences.dart'; // For storing authentication token
import 'package:hive_flutter/hive_flutter.dart';
import 'models/category_hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryHiveModelAdapter());
  await Hive.openBox<CategoryHiveModel>('categories');
  await Hive.openBox('packageServices');
  await Hive.openBox('userBox'); // <-- Add this line
  await Hive.openBox('beautyAddons');
  await Hive.openBox('hennaServices');
  await Hive.openBox('gentsSalonServices');
  runApp(const MyApp());
}

// MyApp is the root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the primary color from the design (the pink/salmon color).
    final Color primaryDesignColor = Color(0xFFFCB8A2);
    // Define a dark text color for primary headings and important text.
    final Color darkTextColor = Color(0xFF333333);
    // Define a lighter text color for secondary information.
    final Color lightTextColor = AppColors.grey600;
    // Define the light off-white background color.
    final Color scaffoldBgColor = Color(0xFFF9F9F9);

    return MaterialApp(
      title: 'Lipslay Driver App',
      theme: ThemeData(
        // Define the primary color scheme for the app based on the design.
        primaryColor: primaryDesignColor,
        // Using `colorScheme` is the modern way to define a full color scheme.
        colorScheme: ColorScheme.light(
          primary: primaryDesignColor,
          onPrimary: AppColors.white, // Text/icons on primary background
          secondary:
              primaryDesignColor, // Often used for floating action buttons, etc.
          onSecondary: AppColors.white,
          surface: AppColors.white, // Card, dialog, menu backgrounds
          onSurface: darkTextColor, // Text/icons on surface backgrounds
          // background: scaffoldBgColor, // Scaffold background
          // onBackground: darkTextColor, // Text/icons on background
          error: AppColors.red,
          onError: AppColors.white,
        ),
        // Set the default scaffold background color.
        scaffoldBackgroundColor: scaffoldBgColor,
        // Adjust visual density for adaptive layouts across devices.
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // Define AppBarTheme to match the design's clean, light AppBar.
        appBarTheme: AppBarTheme(
          color: scaffoldBgColor, // Match the scaffold background
          elevation: 0, // No shadow under the app bar
          iconTheme: IconThemeData(
            color: darkTextColor,
          ), // Dark icons (back arrow, etc.)
          titleTextStyle: TextStyle(
            color: darkTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // If using GoogleFonts, you'd add fontFamily here:
            // fontFamily: GoogleFonts.montserrat().fontFamily,
          ),
        ),

        // Define TextTheme for consistent typography.
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 57, color: darkTextColor),
          displayMedium: TextStyle(fontSize: 45, color: darkTextColor),
          displaySmall: TextStyle(fontSize: 36, color: darkTextColor),
          headlineLarge: TextStyle(fontSize: 32, color: darkTextColor),
          headlineMedium: TextStyle(fontSize: 28, color: darkTextColor),
          headlineSmall: TextStyle(
            fontSize: 24,
            color: darkTextColor,
            fontWeight: FontWeight.bold,
          ), // Like "Retro Salons"
          titleLarge: TextStyle(
            fontSize: 22,
            color: darkTextColor,
          ), // Like "Select a day"
          titleMedium: TextStyle(
            fontSize: 16,
            color: darkTextColor,
            fontWeight: FontWeight.bold,
          ), // Time slot text
          titleSmall: TextStyle(fontSize: 14, color: lightTextColor),
          bodyLarge: TextStyle(fontSize: 16, color: darkTextColor),
          bodySmall: TextStyle(fontSize: 16, color: darkTextColor),

          bodyMedium: TextStyle(fontSize: 14, color: darkTextColor),
          // bodySmall: TextStyle(fontSize: 12, color: lightTextColor), // Small secondary text
          labelLarge: TextStyle(
            fontSize: 14,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ), // Button text
          labelMedium: TextStyle(fontSize: 12, color: lightTextColor),
          labelSmall: TextStyle(fontSize: 11, color: lightTextColor),
        ),

        // Define ElevatedButton theme for the "Book Now" button.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryDesignColor, // Background color
            foregroundColor: AppColors.white, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Highly rounded corners
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ), // Default padding
            elevation: 5, // Subtle shadow
          ),
        ),
      ),

      home: Login2Page(),
      debugShowCheckedModeBanner: false,
    );
  }
}
