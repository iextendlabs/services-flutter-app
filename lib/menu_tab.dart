import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/booking_tab.dart';
import 'package:lipslay_flutter_frontend/button_page.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/about_us.dart';
import 'package:lipslay_flutter_frontend/enterainment.dart';
import 'package:lipslay_flutter_frontend/go_to_home.dart';
import 'package:lipslay_flutter_frontend/login2page.dart';

import 'package:lipslay_flutter_frontend/chatbot_page.dart';
import 'package:lipslay_flutter_frontend/notificationpage.dart';
import 'package:lipslay_flutter_frontend/privacy_policy.dart';
import 'package:lipslay_flutter_frontend/profile_page.dart';
import 'package:lipslay_flutter_frontend/quotes_tab.dart';
import 'package:lipslay_flutter_frontend/request_quote_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lipslay_flutter_frontend/terms_conditions_page.dart';
import 'package:lipslay_flutter_frontend/ladies_salon2.dart';
import 'package:lipslay_flutter_frontend/gents_salon.dart';
import 'package:lipslay_flutter_frontend/spa.dart';
import 'package:lipslay_flutter_frontend/consultant.dart';
import 'package:lipslay_flutter_frontend/services.dart';

import 'package:lipslay_flutter_frontend/freelancerspage.dart';
import 'package:lipslay_flutter_frontend/EarningCoursesPage.dart';
// import 'package:lipslay_flutter_frontend/automotive.dart';
// import 'package:lipslay_flutter_frontend/b2b.dart';
// import 'package:lipslay_flutter_frontend/shop.dart';

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
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
                // Navigate to Profile page
              }),
              _buildMenuItem(context, 'My Bookings', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingTabContent(),
                  ),
                );
              }),
              _buildMenuItem(context, 'My Quotes', () {
                // Pop all routes until HomePage
                Navigator.of(context).popUntil((route) => route.isFirst);
                // Then, switch to the Quotes tab
                final homeState =
                    context.findAncestorStateOfType<HomePageState>();
                homeState?.setState(() {
                  homeState.selectedBottomNavIndex = 4; // Quotes tab index
                  homeState.quotesTabKey++; // Force QuotesTabContent to rebuild
                });
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyPage(),
                  ),
                );
              }),
              const SizedBox(height: 20),
              // const Text(
              //   'Categories',
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: AppColors.black,
              //     fontFamily: 'Ubuntu',
              //   ),
              // ),
              // const SizedBox(height: 10),
              // _buildMenuItem(context, 'Ladies Salon', () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => LadiesSalon2Page()),
              //   );
              // }),
              // _buildMenuItem(context, 'Gents Salon', () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => GentsSalon()),
              //   );
              // }),
              // _buildMenuItem(context, 'SPA', () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => SpaPage()),
              //   );
              // }),
              // _buildMenuItem(context, 'Consultant', () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => ConsultantPage()),
              //   );
              // }),
              // _buildMenuItem(context, 'Services', () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => ServicesPage()),
              //   );
              // }),
              // _buildMenuItem(context, 'Entertainment', () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => Entertainment()),
              //   );
              // }),
              // _buildMenuItem(context, 'Freelancers', () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => FreelancersPage()),
              //   );
              // }),
              // _buildMenuItem(context, 'Earning Courses', () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => EarningCoursesPage()),
              //   );
              // }),
              // // _buildMenuItem(context, 'Automotive', () {
              // //   Navigator.push(
              // //     context,
              // //     MaterialPageRoute(builder: (context) => AutomotivePage()),
              // //   );
              // // }),
              // // _buildMenuItem(context, 'B2B', () {
              // //   Navigator.push(
              // //     context,
              // //     MaterialPageRoute(builder: (context) => B2BPage()),
              // //   );
              // // }),
              // // _buildMenuItem(context, 'Shop', () {
              // //   Navigator.push(
              // //     context,
              // //     MaterialPageRoute(builder: (context) => ShopPage()),
              // //   );
              // // }),
              // const SizedBox(height: 20),
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
                    backgroundColor: AppColors.accentColor,
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
