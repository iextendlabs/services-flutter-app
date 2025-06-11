import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _selectedAccountType = 'Customer'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC), // A light beige background
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            // Handle close button tap
            Navigator.pop(context); // Example: navigate back
          },
        ),
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Create your account',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildAccountTypeButton('Customer'),
                _buildAccountTypeButton('Staff'),
                _buildAccountTypeButton('Driver'),
              ],
            ),
            const SizedBox(height: 30),
            _buildTextField('Full Name', Icons.person),
            const SizedBox(height: 15),
            _buildTextField('Email', Icons.email),
            const SizedBox(height: 15),
            _buildTextField('Password', Icons.lock, obscureText: true),
            const SizedBox(height: 15),
            _buildTextField('Phone Number', Icons.phone),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Sign Up button tap
                  print('Sign Up button tapped');
                  // Add your sign-up logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFFC79A52,
                  ), // A warm gold/brown color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle Log In button tap
                      print('Log In button tapped');
                      // Navigate to login page
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: Color(
                          0xFFC79A52,
                        ), // Matching the sign-up button color
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountTypeButton(String type) {
    bool isSelected = _selectedAccountType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAccountType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC79A52) : AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFFC79A52) : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: Text(
          type,
          style: TextStyle(
            color: isSelected ? AppColors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hintText,
    IconData icon, {
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          border: InputBorder.none, // Removes the default underline
          prefixIcon: Icon(icon, color: Colors.grey[600]), // Optional icon
        ),
      ),
    );
  }
}
