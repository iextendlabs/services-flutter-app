// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class LadiesSalon extends StatelessWidget {
  const LadiesSalon({super.key});

  @override
  Widget build(BuildContext context) {
    // Media query for responsive sizing and safe area
    final screenWidth = MediaQuery.of(context).size.width;
    final safeAreaTop = MediaQuery.of(context).padding.top;

    // Define category data (using placeholder icons for now)
    final List<Map<String, dynamic>> subCategories = const [
      {'name': 'Beauty-add-on', 'icon': Icons.add_circle_outline},
      {'name': 'Package', 'icon': Icons.card_giftcard},
      {'name': 'Bleach & Threading', 'icon': Icons.face},
      {'name': 'Facial', 'icon': Icons.spa},
      {'name': 'Henna', 'icon': Icons.brush},
      {'name': 'Makeup', 'icon': Icons.palette},
      {'name': 'Manicure-Pedicure', 'icon': Icons.content_cut},
      {'name': 'Ladies Massage', 'icon': Icons.self_improvement},
      {'name': 'Nails', 'icon': Icons.fingerprint},
      {'name': 'Waxing', 'icon': Icons.clean_hands},
      {'name': 'New Offer', 'icon': Icons.local_offer},
      {'name': 'Hair', 'icon': Icons.content_cut_outlined},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE), // Light pink background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEBEE), // Match background color
        elevation: 0, // No shadow
        toolbarHeight: 90.0, // Increased AppBar height for title and tagline
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/lotus_flower.png', // Lotus flower logo
            fit: BoxFit.contain,
          ),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Search', // Main title
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Ubuntu',
              ),
            ),
            Text(
              'Live your best life', // Tagline
              style: TextStyle(
                color: Color.fromARGB(255, 107, 107, 107),
                fontSize: 14,
                fontFamily: 'Ubuntu',
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Navigate to Notification Page
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage()));
                },
              ),
              const Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    '0', // Notification count
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input Field and Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Services',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontFamily: 'Ubuntu',
                        ),
                        border:
                            InputBorder.none, // Remove default TextField border
                        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Ubuntu',
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 50, // Match height of the text field for alignment
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle search button press
                        debugPrint('Search button pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE91E63), // Pink button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        elevation:
                            0, // No extra shadow, container already has one
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      child: const Text(
                        'Search',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0), // Space after search bar
            // Sub Category Title
            const Text(
              'Sub Category',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 20.0), // Space after title
            // Category Grid
            GridView.builder(
              shrinkWrap:
                  true, // Important: makes GridView take only needed space
              physics:
                  const NeverScrollableScrollPhysics(), // Important: disables GridView's own scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 items per row
                crossAxisSpacing: 15.0, // Horizontal spacing
                mainAxisSpacing: 25.0, // Vertical spacing
                childAspectRatio: 0.8, // Adjust as needed to fit content
              ),
              itemCount: subCategories.length,
              itemBuilder: (context, index) {
                final category = subCategories[index];
                return GestureDetector(
                  onTap: () {
                    debugPrint('${category['name']} category tapped');
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 80, // Fixed width for the circular background
                        height: 80, // Fixed height for the circular background
                        padding: const EdgeInsets.all(
                          15,
                        ), // Padding inside the circle
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFFCE4EC,
                          ), // Very light pink/rose color
                          borderRadius: BorderRadius.circular(
                            40,
                          ), // Makes it a circle (half of width/height)
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          // Using Icon for placeholders, replace with Image.asset if you have images
                          category['icon'] as IconData, // Cast to IconData
                          size: 50, // Icon size
                          color: const Color(
                            0xFFE91E63,
                          ), // Pink color for icons
                        ),
                        // If you have image assets for categories, use Image.asset here:
                        // child: Image.asset(
                        //   'assets/images/${category['image_file_name']}', // e.g., 'beauty_add_on.png'
                        //   width: 50,
                        //   height: 50,
                        //   fit: BoxFit.contain,
                        //   errorBuilder: (context, error, stackTrace) => const Icon(
                        //     Icons.error,
                        //     size: 50,
                        //     color: Colors.red,
                        //   ),
                        // ),
                      ),
                      const SizedBox(height: 8), // Space between icon and text
                      Text(
                        category['name']!,
                        textAlign: TextAlign.center,
                        maxLines: 2, // Allow text to wrap
                        overflow:
                            TextOverflow
                                .ellipsis, // Add ellipsis if text overflows
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20), // Padding at the bottom
          ],
        ),
      ),
    );
  }
}
