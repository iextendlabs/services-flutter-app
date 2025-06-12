import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class MarketingPage extends StatefulWidget {
  const MarketingPage({super.key});

  @override
  State<MarketingPage> createState() => _MarketingPageState();
}

class _MarketingPageState extends State<MarketingPage> {
  String _searchText = '';
  final List<Map<String, dynamic>> subCategories = [


 {
      'image': 'assets/images/nails.png',
      'title': 'Telegram Marketing',
    },
    {
      'image': 'assets/images/makeup.png',
      'title': 'Spotify Marketing',
    },
{
      'image': 'assets/images/consultant.png',
      'title': 'SoundCloud Marketing',
    },
    {
      'image': 'assets/images/default.png',
      'title': 'YouTube Marketing',
    },
    {
      'image': 'assets/images/default.png',
      'title': 'Instagram Marketing',
    },
    {
      'image': 'assets/images/default.png',
      'title': 'Twitter Marketing',
    },
    
    
  ];
   @override
  Widget build(BuildContext context) {
    final filteredSubCategories = subCategories.where((sub) {
      return sub['title']
          .toString()
          .toLowerCase()
          .contains(_searchText.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.primarypageWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primarypageWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Marketing",
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
                        hintText: 'Search Marketing Category',
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: filteredSubCategories
                  .take(3)
                  .map((sub) => _buildSubCategoryItem(sub))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: filteredSubCategories
                  .skip(3)
                  .take(3)
                  .map((sub) => _buildSubCategoryItem(sub))
                  .toList(),
            ),
          ),
          // You can add more rows if you have more categories
        ],
      ),
    );
  }

  Widget _buildSubCategoryItem(Map<String, dynamic> sub) {
    return Column(
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
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            sub['title'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Ubuntu',
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}