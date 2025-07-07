import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lipslay_flutter_frontend/ItemView.dart'; // <-- Import your ItemView page
import 'package:lipslay_flutter_frontend/book_nowPage.dart';

class NewOfferPage extends StatefulWidget {
  const NewOfferPage({super.key});

  @override
  State<NewOfferPage> createState() => _NewOfferPageState();
}

class _NewOfferPageState extends State<NewOfferPage> {
  String _searchText = '';
  Offset _fabPosition = const Offset(0, 0);

  final List<Map<String, dynamic>> NewOffer = [
    {
      'image': 'assets/images/22 Beauty Services.png',
      'title': 'Driver',
      'price': 0,
      'rating': 4,
      'description': 'Professional driver for your daily commute or events.',
      'whatsapp': '971501234567',
    },
    {
      'image': 'assets/images/17 Beauty Services in 200 AED.png',
      'title': 'Graphic Designer',
      'price': 0,
      'rating': 3,
      'description': 'Creative graphic designer for all your branding needs.',
      'whatsapp': '971501234567',
    },
    {
      'image': 'assets/images/18 Services In 250 AED.png',
      'title': 'Car Recovery',
      'price': 0,
      'rating': 0,
      'description': 'Fast and reliable car recovery service.',
      'whatsapp': '971501234567',
    },
    // Add more as needed
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateFabPosition();
    });
  }

  void _updateFabPosition() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fabGroupHeight = 56.0 + 10.0 + 50.0;
    final fabGroupWidth = 60.0;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final bottomNavBarHeight = kBottomNavigationBarHeight;
    final initialFabX = screenWidth - fabGroupWidth - 20;
    final initialFabY =
        screenHeight -
        safeAreaBottom -
        bottomNavBarHeight -
        fabGroupHeight -
        20;
    setState(() {
      _fabPosition = Offset(initialFabX, initialFabY);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredNewOffer =
        NewOffer.where(
          (f) => f['title'].toString().toLowerCase().contains(
            _searchText.toLowerCase(),
          ),
        ).toList();

    return Scaffold(
      backgroundColor: AppColors.primarypageWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primarypageWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "NewOffer",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.accentColor.withOpacity(0.2),
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search NewOffer',
                      hintStyle: TextStyle(
                        color: AppColors.black,
                        fontFamily: 'Ubuntu',
                      ),
                      prefixIcon: Icon(Icons.search, color: AppColors.black),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    style: const TextStyle(
                      color: AppColors.black,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: filteredNewOffer.length,
                  itemBuilder: (context, index) {
                    final freelancer = filteredNewOffer[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ItemView(
                                  title: freelancer['title'],
                                  description:
                                      freelancer['description'] ??
                                      'No description available.',
                                  imageUrl: freelancer['image'],
                                  whatsappNumber: freelancer['whatsapp'] ?? '',
                                ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey.withOpacity(0.10),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.asset(
                                  freelancer['image'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      freelancer['title'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.black,
                                        fontFamily: 'Ubuntu',
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    if (freelancer['rating'] > 0)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2.0,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              freelancer['rating'].toString(),
                                              style: const TextStyle(
                                                color: AppColors.black,
                                                fontSize: 13,
                                                fontFamily: 'Ubuntu',
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            const Icon(
                                              Icons.star,
                                              color: AppColors.amber,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Text(
                                        'AED ${freelancer['price']}',
                                        style: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Ubuntu',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: AppColors.accentColor,
                                      size: 22,
                                    ),
                                    onPressed: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Added ${freelancer['title']} to wishlist!',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => BookNowPage(
                                                // Pass item info to BookNowPage using named parameters
                                                serviceTitle:
                                                    freelancer['title'],
                                                serviceImage:
                                                    freelancer['image'],
                                                servicePrice:
                                                    freelancer['price']
                                                        .toString(),
                                                serviceRating:
                                                    freelancer['rating']
                                                        .toString(),
                                              ),
                                        ),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: AppColors.grey.withOpacity(0.4),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 0,
                                      ),
                                      minimumSize: const Size(0, 32),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(
                                      'Login to Quote',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: 'Ubuntu',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
                      10;
                  double newDx = _fabPosition.dx + details.delta.dx;
                  double newDy = _fabPosition.dy + details.delta.dy;
                  newDx = newDx.clamp(minX, maxX);
                  newDy = newDy.clamp(minAppbarY, maxBottomNavY);
                  _fabPosition = Offset(newDx, newDy);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
