import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/BusinessCoursesPage.dart';
import 'package:lipslay_flutter_frontend/BusinessLawPage.dart';
import 'package:lipslay_flutter_frontend/BusinessStrategyPage.dart';
import 'package:lipslay_flutter_frontend/CertificationPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/CommunicationPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/DataSciencePage.dart';
import 'package:lipslay_flutter_frontend/not-needed/ECommercePage.dart';
import 'package:lipslay_flutter_frontend/not-needed/EarnAtHomePage.dart';
import 'package:lipslay_flutter_frontend/not-needed/EarningCoursesPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/HumanResourcesPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/ITServicesPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/IndustryCoursesPage.dart';
import 'package:lipslay_flutter_frontend/ItemView.dart';
import 'package:lipslay_flutter_frontend/not-needed/LeaderShipPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/LifeSkillsPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/ManagementPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/MediaCoursesPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/OnlineTuitionPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/OperationsPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/PersonalTrainerPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/ProjectManagementPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/SalesPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/WebDevelopmentPage.dart';
import 'package:lipslay_flutter_frontend/cart_service.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/not-needed/itsolutionpage.dart';
import 'package:lipslay_flutter_frontend/not-needed/marketingpage.dart';
import 'package:lipslay_flutter_frontend/staff_detailpage.dart';
import 'package:lipslay_flutter_frontend/not-needed/subscriptionspage.dart';
import 'package:lipslay_flutter_frontend/not-needed/pestcontrolpage.dart';
import 'package:lipslay_flutter_frontend/not-needed/homeappliancespage.dart';
import 'package:lipslay_flutter_frontend/cleaningpage.dart';
import 'package:lipslay_flutter_frontend/maintenancepage.dart';
import 'package:lipslay_flutter_frontend/wishlist_service.dart';
import 'package:lipslay_flutter_frontend/book_nowPage.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final List<Map<String, dynamic>> Services = [
    {
      'imageUrl': 'assets/images/house_maid.png',
      'title': 'AC Maintenance',
      'specialty': 'AC Repair Specialist',
      'rating': 4.9,
      'price': 120,
      'duration': 60, // Duration in minutes
    },
    {
      'imageUrl': 'assets/images/services.png',
      'title': 'House Maid',
      'specialty': 'Cleaning Expert',
      'rating': 4.7,
      'price': 100,
      'duration': 60, // Duration in minutes
    },

    // Add more Services as needed
  ];

  final Set<int> _wishlist = {};
  String _searchText = '';

  final List<Map<String, dynamic>> subCategories = [
    {
      'image': 'assets/images/onlinetuition.png',
      'title': 'Online tuition',
      'page': OnlineTuitionPage(),
    },
    {
      'image': 'assets/images/personaltrainer.png',
      'title': 'Personal Trainer',
      'page': PersonalTrainerPage(),
    },
    {
      'image': 'assets/images/businesscourses.png',
      'title': 'Business Courses',
      'page': BusinessCoursesPage(),
    },
    {
      'image': 'assets/images/certifications.png',
      'title': 'Certifications by Skill',
      'page': CertificationPage(),
    },
    {
      'image': 'assets/images/datascience.png',
      'title': 'Data Science',
      'page': DataSciencePage(),
    },
    {
      'image': 'assets/images/leadership.png',
      'title': 'Leadership',
      'page': LeaderShipPage(),
    },
    {
      'image': 'assets/images/webdevelopment.png',
      'title': 'Web Development',
      'page': WebDevelopmentPage(),
    },
    {
      'image': 'assets/images/communication.png',
      'title': 'Communication',
      'page': CommunicationPage(),
    },
    {
      'image': 'assets/images/management.png',
      'title': 'Management',
      'page': ManagementPage(),
    },
    {
      'image': 'assets/images/ecommerce.png',
      'title': 'E-Commerce',
      'page': ECommercePage(),
    },
    {
      'image': 'assets/images/operations.png',
      'title': 'Operations',
      'page': OperationsPage(),
    },
    {
      'image': 'assets/images/businessstrategy.png',
      'title': 'Business Strategy',
      'page': BusinessStrategyPage(),
    },
    {'image': 'assets/images/sales.png', 'title': 'Sales', 'page': SalesPage()},
    {
      'image': 'assets/images/projectmanagement.png',
      'title': 'Project Management',
      'page': ProjectManagementPage(),
    },
    {
      'image': 'assets/images/businesslaw.png',
      'title': 'Business Law',
      'page': BusinessLawPage(),
    },
    {
      'image': 'assets/images/lifeskills.png',
      'title': 'Life Skills',
      'page': LifeSkillsPage(),
    },
    {
      'image': 'assets/images/humanresources.png',
      'title': 'Human Resources',
      'page': HumanResourcesPage(),
    },
    {
      'image': 'assets/images/mediacourses.png',
      'title': 'Media Courses',
      'page': MediaCoursesPage(),
    },
    {
      'image': 'assets/images/industrycourses.png',
      'title': 'Industry Courses',
      'page': IndustryCoursesPage(),
    },
    {
      'image': 'assets/images/earningcourses.png',
      'title': 'Earning Courses',
      'page': EarningCoursesPage(),
    },
    {
      'image': 'assets/images/earnathomefree.png',
      'title': 'Earn At Home-Free',
      'page': EarnAtHomePage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredServices =
        Services.where((Services) {
          return Services['title'].toString().toLowerCase().contains(
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Education",
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
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              itemCount: filteredServices.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final service = filteredServices[index];
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
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ItemView(
                                      slug: service['slug'], // Pass the slug or unique identifier
                                    ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  service['imageUrl'],
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
                                      service['title'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.black,
                                        fontFamily: 'Ubuntu',
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          service['rating'].toString(),
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
                                        const SizedBox(width: 8),
                                        Text(
                                          '${service['duration']} mins',
                                          style: const TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 12,
                                            fontFamily: 'Ubuntu',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'AED ${service['price']}',
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
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              wishlistService.isItemInWishlist(service['title'])
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: AppColors.accentColor,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                final itemId = service['title'];
                                if (wishlistService.isItemInWishlist(itemId)) {
                                  wishlistService.removeItem(itemId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${service['title']} removed from wishlist',
                                      ),
                                    ),
                                  );
                                } else {
                                  wishlistService.addItem(
                                    WishlistItem(
                                      id: itemId,
                                      imagePath: service['imageUrl'],
                                      title: service['title'],
                                      price: 'AED ${service['price']}',
                                      rating: service['rating'].toDouble(),
                                      slug: service['slug'] ?? '',
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${service['title']} added to wishlist',
                                      ),
                                    ),
                                  );
                                }
                              });
                            },
                            tooltip:
                                wishlistService.isItemInWishlist(
                                      service['title'],
                                    )
                                    ? 'Remove from Wishlist'
                                    : 'Add to Wishlist',
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BookNowPage(
                                        // Pass item info to BookNowPage using named parameters
                                        serviceTitle: service['title'],
                                        serviceImage: service['imageUrl'],
                                        servicePrice:
                                            service['price'].toString(),
                                        serviceRating:
                                            service['rating'].toString(),
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
