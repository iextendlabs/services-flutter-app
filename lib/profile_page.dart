import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/booking_tab.dart';
import 'constants/appColors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarypageWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primarypageWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            CircleAvatar(
              radius: 54,
              backgroundColor: AppColors.primaryDark,
              backgroundImage: AssetImage(
                'assets/images/profile_pic.webp',
              ), // Replace with your asset
            ),
            const SizedBox(height: 18),
            // Name
            const Text(
              'Admin',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColors.black,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 4),
            // Email
            const Text(
              'admin@gmail.com',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 15,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 28),

            // Section: Personal Information
            _sectionTitle('Personal Information'),
            _profileListTile(
              icon: Icons.person_outline,
              title: 'Personal Information',
              subtitle: 'Edit your personal information',
              onTap: () {},
            ),

            // Section: My Address
            _sectionTitle('My Address'),
            _profileListTile(
              icon: Icons.location_on_outlined,
              title: 'My Address',
              subtitle: 'Add or edit your address',
              onTap: () {},
            ),

            // Section: My Bookings
            _sectionTitle('My Bookings'),
            _profileListTile(
              icon: Icons.calendar_today_outlined,
              title: 'My Bookings',
              subtitle: 'View your past and upcoming bookings',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => Scaffold(
                          appBar: AppBar(
                            backgroundColor: AppColors.primarypageWhite,
                            elevation: 0,
                            iconTheme: const IconThemeData(
                              color: AppColors.black,
                            ),
                            title: const Text(
                              'My Bookings',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu',
                                fontSize: 20,
                              ),
                            ),
                            centerTitle: true,
                          ),
                          body: const BookingTabContent(),
                        ),
                  ),
                );
              },
            ),

            // Section: My Vouchers
            _sectionTitle('My Vouchers'),
            _profileListTile(
              icon: Icons.confirmation_num_outlined,
              title: 'My Vouchers',
              subtitle: 'View your available vouchers',
              onTap: () {},
            ),

            // Section: Join Freelancer Program
            _sectionTitle('Join Freelancer Program'),
            _profileListTile(
              icon: Icons.work_outline,
              title: 'Join Freelancer Program',
              subtitle: 'Become a freelancer and earn',
              onTap: () {},
            ),

            // Section: Join Affiliate
            _sectionTitle('Join Affiliate'),
            _profileListTile(
              icon: Icons.groups_outlined,
              title: 'Join Affiliate',
              subtitle: 'Become an affiliate and earn',
              onTap: () {},
            ),

            // Section: Customer Support
            _sectionTitle('Customer Support'),
            _profileListTile(
              icon: Icons.headset_mic_outlined,
              title: 'Customer Support',
              subtitle: 'Contact customer support',
              onTap: () {},
            ),

            const SizedBox(height: 24),

            // Delete Account Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Delete Account',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor.withOpacity(0.12),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: AppColors.primaryPink,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _sectionTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 22, bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: AppColors.black,
          fontFamily: 'Ubuntu',
        ),
      ),
    );
  }

  // Profile ListTile Widget
  Widget _profileListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.primaryPink, size: 26),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.black,
          fontSize: 15,
          fontFamily: 'Ubuntu',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.black,
          fontSize: 14,
          fontFamily: 'Ubuntu',
        ),
      ),
      onTap: onTap,
      horizontalTitleGap: 16,
      minLeadingWidth: 0,
    );
  }
}
