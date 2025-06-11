import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching WhatsApp

class FreelancersPage extends StatefulWidget {
  const FreelancersPage({super.key});

  @override
  State<FreelancersPage> createState() => _FreelancersPageState();
}

class _FreelancersPageState extends State<FreelancersPage> {
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
        'Hello, I would like to inquire about freelancer services.';

    final Uri url = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );

    if (!mounted) return;

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // ignore: use_build_context_synchronously
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
                // First Row of Freelancer Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFreelancerServiceCard(
                      context,
                      imagePath:
                          'assets/images/driver.png', // Replace with your image
                      title: 'Driver',
                      price: 0, // AED 0 from image
                      rating: 4, // From image
                      buttonText: 'Login to Quote',
                      showFavorite: true,
                    ),
                    _buildFreelancerServiceCard(
                      context,
                      imagePath:
                          'assets/images/graphic_designer.png', // Replace with your image
                      title: 'Graphic Designer',
                      price: 0, // AED 0 from image
                      rating: 3, // From image
                      buttonText: 'Login to Quote',
                      showFavorite: true,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Second Row of Freelancer Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFreelancerServiceCard(
                      context,
                      imagePath:
                          'assets/images/car_recovery.png', // Replace with your image
                      title: 'Car Recovery',
                      price: 0, // No price visible, assuming 'Login to Quote'
                      rating: 0, // No rating visible
                      buttonText: 'Login to Quote', // Assuming same button
                      showFavorite: true,
                    ),
                    _buildFreelancerServiceCard(
                      context,
                      imagePath:
                          'assets/images/car_mechanic.png', // Replace with your image
                      title: 'Car Mechanic',
                      price: 0, // No price visible
                      rating: 0, // No rating visible
                      buttonText: 'Login to Quote', // Assuming same button
                      showFavorite: true,
                      // Note: chat/whatsapp icons on this specific card image are assumed to be part of the image asset.
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
                    heroTag: 'chat_fab_freelancer', // Unique heroTag
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
                    heroTag: 'whatsapp_fab_freelancer', // Unique heroTag
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

  Widget _buildFreelancerServiceCard(
    BuildContext context, {
    required String imagePath,
    required String title,
    required int price,
    required int rating,
    required String buttonText,
    bool showFavorite = false,
  }) {
    return Expanded(
      // Use Expanded to make cards take equal width in a Row
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ), // Add horizontal margin
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Start of Column's children list
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  height: 150, // Adjusted height for these smaller cards
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16, // Slightly smaller font for tighter layout
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  color: Colors.black,
                ),
                maxLines: 2, // Allow title to wrap
                overflow: TextOverflow.ellipsis, // Add ellipsis if it overflows
              ),
              const SizedBox(height: 5),
              if (rating > 0) // Only show stars if rating is provided
                Row(
                  children:
                      List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 18, // Slightly smaller stars
                        );
                      }).toList(), // Ensure .toList() is here
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Start of inner Row's children list
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Start of inner Column's children list
                      if (price == 0) // Show AED 0 or actual price
                        const Text(
                          'AED 0',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 214, 107, 107),
                            fontFamily: 'Ubuntu',
                          ),
                        )
                      else if (price > 0)
                        Text(
                          'AED $price',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 214, 107, 107),
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      // No explicit duration text visible in the cards in the image
                    ], // End of inner Column's children list
                  ),
                  Row(
                    children: [
                      // Start of button Row's children list
                      ElevatedButton(
                        onPressed: () {
                          // Handle button action
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$buttonText for $title!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            255,
                            182,
                            193,
                          ), // Light pink button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ), // Smaller padding
                        ),
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 14, // Smaller font for button text
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (showFavorite) const SizedBox(width: 5), // Smaller gap
                      if (showFavorite)
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              // Start of boxShadow list
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ], // End of boxShadow list
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Handle wishlist/favorite action
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Added $title to wishlist!'),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.favorite_outline,
                              color: Colors.grey,
                            ),
                            iconSize: 20, // Smaller icon size
                            padding: EdgeInsets.zero, // Remove default padding
                            constraints: BoxConstraints.tightFor(
                              width: 36,
                              height: 36,
                            ), // Control button size
                          ),
                        ),
                    ], // End of button Row's children list
                  ),
                ], // End of inner Row's children list
              ),
            ], // End of outer Column's children list
          ),
        ),
      ),
    );
  }
}
