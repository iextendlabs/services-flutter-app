import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/cleaningpage.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/not-needed/itsolutionpage.dart';
import 'package:lipslay_flutter_frontend/not-needed/marketingpage.dart';
import 'package:lipslay_flutter_frontend/staff_detailpage.dart';
import 'package:lipslay_flutter_frontend/not-needed/subscriptionspage.dart';
import 'package:lipslay_flutter_frontend/not-needed/pestcontrolpage.dart';
import 'package:lipslay_flutter_frontend/not-needed/homeappliancespage.dart';
// import 'package:lipslay_flutter_frontend/not-needed/CleaningPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/maintenancepage.dart';
import 'package:lipslay_flutter_frontend/itservicespage.dart';
import 'package:lipslay_flutter_frontend/book_nowPage.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final List<Map<String, dynamic>> Services = [
    {
      'imageUrl': 'assets/images/house_maid.png',
      'name': 'AC Maintenance',
      'specialty': 'AC Repair Specialist',
      'rating': 4.9,
      'fee': 120,
    },
    {
      'imageUrl': 'assets/images/services.png',
      'name': 'House Maid',
      'specialty': 'Cleaning Expert',
      'rating': 4.7,
      'fee': 100,
    },

    // Add more Services as needed
  ];

  final Set<int> _wishlist = {};
  String _searchText = '';

  final List<Map<String, dynamic>> subCategories = [
    {
      'image': 'assets/images/it_solution.png',
      'title': 'Pest Control',
      'page': Pestcontrolpage(),
    },
    {
      'image': 'assets/images/marketing.png',
      'title': 'Home Appliances',
      'page': Homeappliancespage(),
    },
    {
      'image': 'assets/images/services.png',
      'title': 'Maintenance',
      'page': Maintenancepage(),
    },
    {
      'image': 'assets/images/house_maid.png',
      'title': 'Cleaning',
      'page': Cleaningpage(),
    },
    {
      'image': 'assets/images/subscriptions.png',
      'title': 'IT Services',
      'page': ITServicesPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredServices =
        Services.where((Services) {
          return Services['name'].toString().toLowerCase().contains(
                _searchText.toLowerCase(),
              ) ||
              Services['specialty'].toString().toLowerCase().contains(
                _searchText.toLowerCase(),
              );
        }).toList();

    return Scaffold(
      backgroundColor: AppColors.primarypageWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primarypageWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Services",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                Expanded(
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
                        hintText: 'Search Services',
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
                const SizedBox(width: 10),
              ],
            ),
          ),
          // Subcategory buttons
          // ...existing code...
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SizedBox(
              height: 100, // Adjust height as needed
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: subCategories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 18),
                itemBuilder: (context, idx) {
                  final sub = subCategories[idx];
                  // Widget? targetPage;
                  // Add navigation logic if needed
                  return GestureDetector(
                    onTap:
                        sub['page'] != null
                            ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => sub['page'],
                                ),
                              );
                            }
                            // targetPage != null
                            //     ? () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => targetPage!,
                            //         ),
                            //       );
                            //     }
                            : null,
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(sub['image']),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          sub['title'],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Ubuntu',
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // ...existing code...
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: filteredServices.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final Services = filteredServices[index];
                final isWishlisted = _wishlist.contains(index);
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.primarypageWhite,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          Services['imageUrl'],
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Services['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.black,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              Services['specialty'],
                              style: const TextStyle(
                                color: AppColors.grey,
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  Services['rating'].toString(),
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 13,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                                const SizedBox(width: 2),
                                const Icon(
                                  Icons.star,
                                  color: AppColors.red,
                                  size: 16,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'AED ${Services['fee']}',
                              style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              isWishlisted
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: AppColors.accentColor,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isWishlisted) {
                                  _wishlist.remove(index);
                                } else {
                                  _wishlist.add(index);
                                }
                              });
                            },
                            tooltip:
                                isWishlisted
                                    ? 'Remove from Wishlist'
                                    : 'Add to Wishlist',
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => StaffDetailPage(
                                        staffName: Services['name'],
                                        staffPhotoUrl: Services['imageUrl'],
                                        description: Services['specialty'],
                                        rating: Services['rating'],
                                        services: const [],
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
                                horizontal: 18,
                                vertical: 0,
                              ),
                            ),
                            child: const Text(
                              'View',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BookNowPage(
                                        // Pass item info to BookNowPage using named parameters
                                        serviceTitle: Services['name'],
                                        serviceImage: Services['imageUrl'],
                                        servicePrice:
                                            Services['fee'].toString(),
                                        serviceRating:
                                            Services['rating'].toString(),
                                      ),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 0,
                              ),
                            ),
                            child: const Text(
                              'Add to Cart',
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
