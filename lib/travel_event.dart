import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching WhatsApp

class TravelEventPage extends StatefulWidget {
  const TravelEventPage({super.key});

  @override
  State<TravelEventPage> createState() => _TravelEventPageState();
}

class _TravelEventPageState extends State<TravelEventPage> {
  // Offset for the draggable FABs
  // Offset _fabPosition = const Offset(0, 0);
  String _searchText = '';
  final List<Map<String, dynamic>> travelEvents = [
    {
      'image': 'assets/images/yas_waterworld.png',
      'title': 'Yas Waterworld Ticket',
      'price': 230,
      'duration': '4 Hour',
      'rating': 4,
    },
    {
      'image': 'assets/images/desert_safari.png',
      'title': 'Desert Safari',
      'price': 70,
      'duration': '4 Hour',
      'rating': 3,
    },
    {
      'image': 'assets/images/city_tour.png',
      'title': 'City Tour',
      'price': 70,
      'duration': '4 Hour',
      'rating': 3,
    },
    {
      'image': 'assets/images/city_tour.png',
      'title': 'Travel',
      'price': 70,
      'duration': '4 Hour',
      'rating': 3,
    },
    // Add more as needed
  ];

  @override
  void initState() {
    super.initState();
    // Initialize FAB position after layout is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _updateFabPosition();
    });
  }

  // Function to launch WhatsApp

  @override
  Widget build(BuildContext context) {
    final filteredEvents =
        travelEvents
            .where(
              (event) => event['title'].toString().toLowerCase().contains(
                _searchText.toLowerCase(),
              ),
            )
            .toList();

    return Scaffold(
      backgroundColor: AppColors.primarypageWhite,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryDark,
        elevation: 0,
        // titleSpacing: 0, // Remove default title spacing
        centerTitle: true,
        title: const Text(
          'Travel & Events',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.accentColor),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search for Travel & Events',
                  hintStyle: const TextStyle(
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
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filteredEvents.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return Container(
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
                            event['image'],
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
                                event['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.black,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                              const SizedBox(height: 6),
                              if (event['rating'] > 0)
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        event['rating'].toString(),
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
                                  'AED ${event['price']}',
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  event['duration'],
                                  style: const TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12,
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Added ${event['title']} to wishlist!',
                                    ),
                                  ),
                                );
                              },
                            ),
                            OutlinedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Login to Quote for ${event['title']}!',
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
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
