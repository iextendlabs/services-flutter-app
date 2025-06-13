import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:http/http.dart' as http;
import 'package:lipslay_flutter_frontend/create_new_account.dart';
import 'package:lipslay_flutter_frontend/forget_password.dart';
import 'package:lipslay_flutter_frontend/go_to_home.dart';
import 'package:lipslay_flutter_frontend/newui.dart';
import 'package:lipslay_flutter_frontend/orderlistpage.dart';
import 'dart:convert'; // For encoding/decoding JSON
import 'package:shared_preferences/shared_preferences.dart'; // For making HTTP requests

class Login2Page extends StatefulWidget {
  const Login2Page({super.key});

  @override
  State<Login2Page> createState() => _Login2PageState();
}

class _Login2PageState extends State<Login2Page> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  // - For iOS simulator/web connecting to localhost Laravel: 'http://localhost:8000/api'
  // - For the deployed test server: 'https://test.lipslay.com/api' (note 'https' that;s imp for me)
  final String _baseUrl = 'https://test.lipslay.com/api';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginDriver() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    // Basic client-side validation.
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password.';
        _isLoading = false;
      });
      return;
    }

    try {
      // Make a POST request to the driver login API endpoint.
      final response = await http.post(
        Uri.parse(
          '$_baseUrl/driverLogin',
        ), // Your Laravel API route for driver login
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username':
              email, // Laravel's DriverAppController expects 'username' for email
          'password': password,
        }),
      );

      // Check the HTTP status code of the response.
      if (response.statusCode == 200) {
        // Parse the JSON response body.
        final Map<String, dynamic> data = json.decode(response.body);

        // Extract token and user information from the response.
        final String token =
            data['access_token']; // Laravel returns 'access_token'
        final int driverId = data['user']['id']; // Assuming user ID is returned
        final String driverEmail =
            data['user']['email']; // Assuming user email is returned

        // Store the token and driver ID/email using shared_preferences for persistence.
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('driver_token', token);
        await prefs.setInt('driver_id', driverId);
        await prefs.setString('driver_email', driverEmail);

        // Navigate to the OrderListPage on successful login.
        // `pushReplacement` prevents going back to the login page with the back button.
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => OrderListPage(
                    driverId: driverId.toString(), // Pass the actual driver ID
                    driverEmail: driverEmail,
                  ),
            ),
          );
        }
      } else {
        // Handle API errors (e.g., invalid credentials, server errors).
        final Map<String, dynamic> errorData = json.decode(response.body);
        setState(() {
          // Laravel returns 'error' key for messages
          _errorMessage =
              errorData['error'] ?? 'Login failed. Please try again.';
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle network errors or other exceptions.
      setState(() {
        _errorMessage =
            'An error occurred. Check your network connection or API URL.';
        _isLoading = false;
      });
      // Print the error to the console for debugging.
      debugPrint('Login error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // const Color primaryDark = Color.fromARGB(
    //   255,
    //   117,
    //   141,
    //   168,
    // ); // Deep dark blue
    // const Color secondaryDark = Color.fromARGB(
    //   255,
    //   38,
    //   55,
    //   70,
    // ); // Slightly lighter for elements
    // const Color AppColors.accentColor = Color.fromARGB(255, 233, 159, 30); // Vibrant Pink
    // final Color primaryTextColor = AppColors.white.withOpacity(0.87);
    // final Color secondaryTextColor = AppColors.white.withOpacity(0.6);
    // final Color errorTextColor =AppColors.redAccent[100]!;

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 28.0,
            vertical: 48.0,
          ), // Slightly more horizontal padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // App Logo - ensure it's visible on dark background
              // Image.asset('assets/images/logodesign.png', height: 80, width: 80),
              const SizedBox(height: 78.0),

              Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                'Login to access your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.secondaryTextColor,
                ),
              ),
              const SizedBox(height: 48.0),

              // Email Input Field
              TextField(
                controller: _emailController,
                style: TextStyle(color: AppColors.primaryTextColor),
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: AppColors.secondaryTextColor,
                  ),
                  filled: true,
                  fillColor: AppColors.secondaryDark,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 20.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppColors.white.withOpacity(0.1),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppColors.white.withOpacity(0.15),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: AppColors.accentColor,
                      width: 1.5,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20.0),

              // Password Input Field
              TextField(
                controller: _passwordController,
                style: TextStyle(color: AppColors.primaryTextColor),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.secondaryTextColor,
                  ),
                  filled: true,
                  fillColor: AppColors.secondaryDark,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 20.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppColors.white.withOpacity(0.1),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppColors.white.withOpacity(0.15),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: AppColors.accentColor,
                      width: 1.5,
                    ),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12.0),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage(),
                      ),
                    );
                    debugPrint('Forgot Your Password? pressed');
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: AppColors.accentColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),

              // Display Error Message
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: AppColors.errorTextColor,
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Login Button
              _isLoading
                  ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.accentColor,
                      ),
                    ),
                  )
                  : ElevatedButton(
                    onPressed: _loginDriver,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      backgroundColor: AppColors.accentColor,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation:
                          5, // Slightly more pronounced shadow for a "cool" effect
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight:
                            FontWeight.bold, // Bolder for primary action
                      ),
                    ),
                  ),
              const SizedBox(height: 32.0),

              // Create New Account link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: 15.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateAccountPage(),
                        ),
                      );
                      debugPrint('Create New Account pressed');
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 6.0),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppColors.accentColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              // Go To Home Button / Continue as Guest
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                  debugPrint('Go To Home pressed');
                },
                child: Text(
                  'Continue as Guest',
                  style: TextStyle(
                    color: AppColors.secondaryTextColor.withOpacity(0.8),
                    fontSize: 15.0,
                    // decoration: TextDecoration.underline, // Optional
                  ),
                ),
              ),
              const SizedBox(height: 48.0),

              // App Version Text
              Text(
                'Lipslay App v1.3.6',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  color: AppColors.white.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
