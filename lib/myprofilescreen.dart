// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access themeAppColors and text styles for consistency
    final Color darkTextColor = Theme.of(context).colorScheme.onBackground;
    final Color lightTextColor = Theme.of(context).textTheme.bodySmall!.color!;
    // Note: The design uses a reddish icon color for "Change Photo" and items.
    // We'll use the primary color for this, as it matches the theme.
    final Color iconColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // Back arrow icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'My Profile',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true, // Center the title as seen in the design
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section with Profile Image and "Change Photo"
            Container(
              width: double.infinity, // Take full width
              // height: 280, // Adjust height as needed, or let content define it
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 40,
              ), // More padding at bottom
              alignment: Alignment.center,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ), // Rounded corners for the image
                    child: Image.asset(
                      'assets/images/profile_pic.webp', // Replace with your asset image path
                      width:
                          MediaQuery.of(context).size.width *
                          0.8, // Adjust width based on screen size
                      height:
                          MediaQuery.of(context).size.width *
                          0.6, // Adjust height
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // "Change Photo" text with icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: iconColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Change Photo',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: iconColor,
                          fontWeight: FontWeight.w600, // Slightly bold
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.edit_outlined,
                        color: iconColor,
                        size: 20,
                      ), // Edit icon on the right
                    ],
                  ),
                ],
              ),
            ),
            // Information Fields
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                children: [
                  // Full Name
                  _buildProfileListItem(
                    context,
                    icon: Icons.person_outline,
                    label: 'Full Name',
                    value: 'Samantha Smith',
                    iconColor: iconColor,
                    darkTextColor: darkTextColor,
                  ),
                  const SizedBox(height: 20),
                  // Email Address
                  _buildProfileListItem(
                    context,
                    icon: Icons.email_outlined,
                    label: 'Email Address',
                    value: 'samanthasmith@mail.com',
                    iconColor: iconColor,
                    darkTextColor: darkTextColor,
                  ),
                  const SizedBox(height: 20),
                  // Phone Number
                  _buildProfileListItem(
                    context,
                    icon: Icons.phone_outlined,
                    label: 'Phone Number',
                    value: '+1 987 654 3210',
                    iconColor: iconColor,
                    darkTextColor: darkTextColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a single profile list item
  Widget _buildProfileListItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    required Color darkTextColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: 24), // Icon for the field
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color:
                    Theme.of(
                      context,
                    ).textTheme.bodySmall?.color, // Use light text color
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: darkTextColor, // Use dark text color
                fontWeight: FontWeight.w600, // Make value bold
              ),
            ),
          ],
        ),
      ],
    );
  }
}
