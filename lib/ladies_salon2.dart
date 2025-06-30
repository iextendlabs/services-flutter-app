// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/home_tab.dart'; // Make sure this path is correct
import 'package:lipslay_flutter_frontend/BeautyAddonPage.dart';
import 'package:lipslay_flutter_frontend/PackagePage.dart';
import 'package:lipslay_flutter_frontend/BleachThreadingPage.dart';
import 'package:lipslay_flutter_frontend/FacialPage.dart';
import 'package:lipslay_flutter_frontend/HennaPage.dart';
import 'package:lipslay_flutter_frontend/MakeupPage.dart';
import 'package:lipslay_flutter_frontend/ManicurePedicurePage.dart';
import 'package:lipslay_flutter_frontend/LadiesMassagePage.dart';
import 'package:lipslay_flutter_frontend/NailsPage.dart';
import 'package:lipslay_flutter_frontend/WaxingPage.dart';

// --- Data Model for Service Categories ---
class ServiceCategory {
  final String title;
  final String imageUrl; // Path to the icon/image for the category

  ServiceCategory({required this.title, required this.imageUrl});
}

class LadiesSalon2Page extends StatefulWidget {
  LadiesSalon2Page({super.key});

  @override
  State<LadiesSalon2Page> createState() => _LadiesSalon2PageState();
}

class _LadiesSalon2PageState extends State<LadiesSalon2Page> {
  String _searchText = '';

  // Dummy data for service categories
  final List<ServiceCategory> categories = [
    ServiceCategory(
      title: 'Beauty Add-ons',
      imageUrl: 'assets/images/beauty_addons.png',
    ),
    ServiceCategory(title: 'Packages', imageUrl: 'assets/images/packages.png'),
    ServiceCategory(
      title: 'Bleach & Threading',
      imageUrl: 'assets/images/bleach_threading.png',
    ),
    ServiceCategory(title: 'Facials', imageUrl: 'assets/images/facials.png'),
    ServiceCategory(title: 'Henna', imageUrl: 'assets/images/henna.png'),
    ServiceCategory(title: 'Makeup', imageUrl: 'assets/images/makeup.png'),
    ServiceCategory(
      title: 'Manicure & Pedicure',
      imageUrl: 'assets/images/manicure_pedicure.png',
    ),
    ServiceCategory(
      title: 'Ladies Massage',
      imageUrl: 'assets/images/ladies_massage.png',
    ),
    ServiceCategory(title: 'Nails', imageUrl: 'assets/images/nails.png'),
    ServiceCategory(title: 'Waxing', imageUrl: 'assets/images/waxing.png'),
  ];

  final Map<String, Widget Function()> categoryPages = {
    'Beauty Add-ons': () => const BeautyAddonPage(),
    'Packages': () => const PackagePage(),
    'Bleach & Threading': () => const BleachThreadingPage(),
    'Facials': () => const FacialPage(),
    'Henna': () => const HennaPage(),
    'Makeup': () => const MakeupPage(),
    'Manicure & Pedicure': () => const ManicurePedicurePage(),
    'Ladies Massage': () => const LadiesMassagePage(),
    'Nails': () => const NailsPage(),
    'Waxing': () => const WaxingPage(),
  };

  @override
  Widget build(BuildContext context) {
    final filteredCategories = categories
        .where((cat) => cat.title.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();


    return Scaffold(
      backgroundColor:
          AppColors
              .primarypageWhite, // Changed to primaryPageWhite as defined in AppColors.dart
      appBar: AppBar(
        // toolbarHeight: 0, // <--- REMOVE OR COMMENT OUT THIS LINE
        centerTitle: true,
        elevation: 0, // Keep elevation 0 for a flat look
        backgroundColor:
            AppColors.primarypageWhite, // Match scaffold background
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ), // Assuming AppColors.black is defined
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Ladies Salon",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Ubuntu',
          ),
        ),
        // iconTheme: IconThemeData(color: AppColors.black), // Assuming AppColors.black is defined
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color:
                          AppColors.white,
                               // Assuming AppColors.white is defined
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                       onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for services',
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.accentColor,
                        ), // Assuming AppColors.accentColor is defined
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                        isDense: true,
                      ),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Ladies Salon Title
                  const Text(
                    'Ladies Salon',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:
                          AppColors
                              .black87, // Assuming AppColors.black87 is defined
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // Service Categories Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns
                crossAxisSpacing: 16.0, // Spacing between columns
                mainAxisSpacing: 16.0, // Spacing between rows
                childAspectRatio:
                    1.8, // Adjust as needed to match card proportions
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final category = filteredCategories[index];
                return _buildCategoryCard(context, category);
              }, childCount: filteredCategories.length),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 24), // Add some padding at the bottom
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, ServiceCategory category) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.calenderblueGrey.withOpacity(
              0.1,
            ), // Assuming AppColors.calenderBlueGrey is defined
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color:
            AppColors
                .transparent, // Make Material transparent to show Container's decoration
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            if (categoryPages.containsKey(category.title)) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => categoryPages[category.title]!(),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Icon/Image
                Container(
                  width: 50, // Fixed width for the image
                  height: 50, // Fixed height for the image
                  decoration: BoxDecoration(
                    color:
                        AppColors
                            .grey100, // Light background for icons, assuming AppColors.grey100
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      category.imageUrl,
                      fit:
                          BoxFit
                              .cover, // Cover the box while maintaining aspect ratio
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          color:
                              AppColors
                                  .red, // Assuming AppColors.red is defined
                        ); // Placeholder for errors
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Category Title
                Expanded(
                  child: Text(
                    category.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600, // Semi-bold
                      fontSize: 15,
                      color: AppColors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
