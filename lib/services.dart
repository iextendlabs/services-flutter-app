// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching WhatsApp

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  // Offset for the draggable FABs
  Offset _fabPosition = const Offset(0, 0);

  @override
  void initState() {
    super.initState();
    // Initialize FAB position after layout is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateFabPosition();
    });
  }

  void _updateFabPosition() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Approximate size of the FAB group (adjust if needed)
    final fabGroupHeight =
        56.0 + 10.0 + 50.0; // FAB + SizedBox + WhatsApp FAB height
    final fabGroupWidth = 60.0; // Approximate width of a FAB

    // ignore: unused_local_variable
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    // Assuming a standard bottom navigation bar height for the offset
    final bottomNavBarHeight =
        kBottomNavigationBarHeight; // Use default if no custom one is in this view

    // Initial position for the FABs (bottom right, above a potential bottom nav bar)
    final initialFabX = screenWidth - fabGroupWidth - 20; // 20px from right
    final initialFabY =
        screenHeight -
        safeAreaBottom -
        bottomNavBarHeight -
        fabGroupHeight -
        20; // 20px above bottom nav bar

    setState(() {
      _fabPosition = Offset(initialFabX, initialFabY);
    });
  }

  // Function to launch WhatsApp
  Future<void> _launchWhatsApp() async {
    const String phoneNumber = '923250500849'; // Your WhatsApp number
    const String message =
        'Hello, I would like to inquire about your services.';

    final Uri url = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );

    if (!mounted) return;

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not launch WhatsApp. Please install WhatsApp or check the number.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE), // Consistent background color
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEBEE),
        elevation: 0,
        titleSpacing: 0, // Remove default title spacing
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(
                        255,
                        255,
                        182,
                        193,
                      ), // Light pink border
                    ),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Services',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border:
                          InputBorder.none, // Remove default TextField border
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Handle search action
                  },
                  icon: const Icon(Icons.search, color: AppColors.white),
                  label: const Text(
                    'Search',
                    style: TextStyle(color: AppColors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                      255,
                      255,
                      182,
                      193,
                    ), // Light pink button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Sub Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 15),
                // Sub Category items using Wrap for flexible layout
                Wrap(
                  spacing: 15.0, // horizontal spacing between items
                  runSpacing: 20.0, // vertical spacing between rows
                  alignment:
                      WrapAlignment
                          .center, // center items if they don't fill the row
                  children: [
                    _buildSubCategoryItem(
                      'assets/images/house_maid.png', // Replace with your image
                      'Pest Control',
                    ),
                    _buildSubCategoryItem(
                      'assets/images/house_maid.png', // Replace with your image
                      'HOME APPLIANCES',
                    ),
                    _buildSubCategoryItem(
                      'assets/images/house_maid.png', // Replace with your image
                      'Maintenance',
                    ),
                    _buildSubCategoryItem(
                      'assets/images/house_maid.png', // Replace with your image
                      'Cleaning',
                    ),
                    _buildSubCategoryItem(
                      'assets/images/house_maid.png', // Replace with your image
                      'IT Services',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Bottom section cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildServiceOverviewCard(
                      context,
                      imagePath:
                          'assets/images/ac_service.png', // Replace with your image
                      title: 'AC Maintenance Services', // Example title
                    ),
                    _buildServiceOverviewCard(
                      context,
                      imagePath:
                          'assets/images/house_maid.png', // Replace with your image
                      title: 'House Maid', // Example title
                      // Note: chat/whatsapp icons are assumed to be part of the image asset here
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ), // Add some space at the bottom for the FABs
              ],
            ),
          ),
          // Draggable Floating Action Buttons
          Positioned(
            left: _fabPosition.dx,
            top: _fabPosition.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final screenHeight = MediaQuery.of(context).size.height;
                  final safeAreaTop = MediaQuery.of(context).padding.top;
                  final safeAreaBottom = MediaQuery.of(context).padding.bottom;

                  final fabGroupHeight = 56.0 + 10.0 + 50.0;
                  final fabGroupWidth = 60.0;

                  final minX = 0.0;
                  final maxX = screenWidth - fabGroupWidth;

                  final minAppbarY =
                      AppBar().preferredSize.height + safeAreaTop;
                  final maxBottomNavY =
                      screenHeight -
                      safeAreaBottom -
                      fabGroupHeight -
                      kBottomNavigationBarHeight -
                      10; // Account for system nav bar and bottom nav bar

                  double newDx = _fabPosition.dx + details.delta.dx;
                  double newDy = _fabPosition.dy + details.delta.dy;

                  newDx = newDx.clamp(minX, maxX);
                  newDy = newDy.clamp(minAppbarY, maxBottomNavY);

                  _fabPosition = Offset(newDx, newDy);
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    heroTag: 'chat_fab_services', // Unique heroTag
                    onPressed: () {
                      // Navigate to chatbot page if you have one
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatbotPage()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Chat with us!')),
                      );
                    },
                    backgroundColor: const Color.fromARGB(255, 190, 47, 94),
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    heroTag: 'whatsapp_fab_services', // Unique heroTag
                    onPressed: _launchWhatsApp,
                    backgroundColor: AppColors.white,
                    elevation: 0,
                    child: Image.asset(
                      'assets/images/whatsapp_icon.png', // Ensure this path is correct
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubCategoryItem(String imagePath, String title) {
    return SizedBox(
      // Wrap in SizedBox to give fixed size to each item for consistent wrapping
      width:
          MediaQuery.of(context).size.width / 3 -
          25, // Approximately 3 items per row with spacing
      child: Column(
        children: [
          Container(
            width: 90, // Adjusted size for sub-category images
            height: 90, // Adjusted size
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover, // Use cover to fill the circle
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14, // Slightly smaller font for sub-categories
              fontWeight: FontWeight.w600,
              fontFamily: 'Ubuntu',
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceOverviewCard(
    BuildContext context, {
    required String imagePath,
    required String title,
  }) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                height: 180, // Adjusted height for these cards
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // No price, duration, stars, or buttons based on the provided image for these cards
            // If you want to add a button, you would include it here.
          ],
        ),
      ),
    );
  }
}
