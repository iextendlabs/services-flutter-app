import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/button_page.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/about_us.dart';
import 'package:lipslay_flutter_frontend/login2page.dart';

import 'package:lipslay_flutter_frontend/chatbot_page.dart';
import 'package:lipslay_flutter_frontend/notificationpage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lipslay_flutter_frontend/terms_conditions_page.dart';

class MenuTabContent extends StatelessWidget {
  const MenuTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarypageWhite, // Match background color

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenuItem(context, 'Profile', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login2Page()),
                );
                // Navigate to Profile page
              }),
              _buildMenuItem(context, 'My Bookings', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login2Page()),
                );
              }),
              _buildMenuItem(context, 'My Quotes', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyButtonScreen(),
                  ),
                );
              }),
              _buildMenuItem(context, 'Terms & Condition', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TermsConditionsPage(),
                  ),
                );
              }),
              _buildMenuItem(context, 'About Us', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUsPage()),
                );
              }),
              _buildMenuItem(context, 'Privacy Policy', () {
                // Navigate to Privacy Policy page
              }),
              const SizedBox(height: 20),
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontFamily: 'Ubuntu',
                ),
              ),
              const SizedBox(height: 10),
              _buildMenuItem(context, 'Ladies Salon', () {}),
              _buildMenuItem(context, 'Gents Salon', () {}),
              _buildMenuItem(context, 'SPA', () {}),
              _buildMenuItem(context, 'Consultant', () {}),
              _buildMenuItem(context, 'Services', () {}),
              _buildMenuItem(context, 'Entertainment', () {}),
              _buildMenuItem(context, 'Freelancers', () {}),
              _buildMenuItem(context, 'Earning Courses', () {}),
              _buildMenuItem(context, 'Automotive', () {}),
              _buildMenuItem(context, 'B2B', () {}),
              _buildMenuItem(context, 'Shop', () {}),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login2Page(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE91E63),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.white,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.black,
              fontFamily: 'Ubuntu',
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.grey,
          ),
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
        ),
        const Divider(height: 1, thickness: 0.5, color: AppColors.grey),
      ],
    );
  }
}
