import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/itsolutionpage.dart';
import 'package:lipslay_flutter_frontend/marketingpage.dart';
import 'package:lipslay_flutter_frontend/staff_detailpage.dart';
import 'package:lipslay_flutter_frontend/subscriptionspage.dart';

class ConsultantPage extends StatefulWidget {
  const ConsultantPage({super.key});

  @override
  State<ConsultantPage> createState() => _ConsultantPageState();
}

class _ConsultantPageState extends State<ConsultantPage> {
  final List<Map<String, dynamic>> consultants = [
    {
      'imageUrl': 'assets/images/consultant.png',
      'name': 'Lose Weight at Home',
      'specialty': 'Skin Specialist',
      'rating': 4.9,
      'fee': 120,
    },
    {
      'imageUrl': 'assets/images/consultant.png',
      'name': 'Import & Export Consultant',
      'specialty': 'Hair Expert',
      'rating': 4.7,
      'fee': 100,
    },
    {
      'imageUrl': 'assets/images/consultant.png',
      'name': 'Marriage Consultant',
      'specialty': 'Hair Expert',
      'rating': 4.7,
      'fee': 100,
    },
    {
      'imageUrl': 'assets/images/consultant.png',
      'name': 'Accounting Services',
      'specialty': 'Hair Expert',
      'rating': 4.7,
      'fee': 100,
    },
    // Add more consultants as needed
  ];

  final Set<int> _wishlist = {};
  String _searchText = '';

  final List<Map<String, dynamic>> subCategories = [
    {'image': 'assets/images/it_solution.png', 'title': 'IT Solution'},
    {'image': 'assets/images/marketing.png', 'title': 'Marketing'},
    {'image': 'assets/images/subscriptions.png', 'title': 'Subscriptions'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredConsultants =
        consultants.where((consultant) {
          return consultant['name'].toString().toLowerCase().contains(
                _searchText.toLowerCase(),
              ) ||
              consultant['specialty'].toString().toLowerCase().contains(
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
          "Staff",
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
                        hintText: 'Search Staff',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  subCategories.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final sub = entry.value;
                    // Replace these with your actual page widgets
                    Widget? targetPage;
                    if (sub['title'] == 'IT Solution') {
                      targetPage =
                          ITSolutionPage(); // Replace with your actual page
                    } else if (sub['title'] == 'Marketing') {
                      targetPage =
                          MarketingPage(); // Replace with your actual page
                    } else if (sub['title'] == 'Subscriptions') {
                      targetPage =
                          SubscriptionsPage(); // Replace with your actual page
                    }
                    return GestureDetector(
                      onTap:
                          targetPage != null
                              ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => targetPage!,
                                  ),
                                );
                              }
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
                  }).toList(),
            ),
          ),
          // ...existing code...
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: filteredConsultants.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final consultant = filteredConsultants[index];
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
                          consultant['imageUrl'],
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
                              consultant['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.black,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              consultant['specialty'],
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
                                  consultant['rating'].toString(),
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
                              'AED ${consultant['fee']}',
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
                                        staffName: consultant['name'],
                                        staffPhotoUrl: consultant['imageUrl'],
                                        description: consultant['specialty'],
                                        rating: consultant['rating'],
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
