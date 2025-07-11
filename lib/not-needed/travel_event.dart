import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/not-needed/enterainment.dart';

import 'package:lipslay_flutter_frontend/not-needed/holidays.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching WhatsApp
import 'package:lipslay_flutter_frontend/ItemView.dart';
import 'package:lipslay_flutter_frontend/wishlist_service.dart';
import 'package:lipslay_flutter_frontend/cart_service.dart';

class TravelEventPage extends StatefulWidget {
  const TravelEventPage({super.key});

  @override
  State<TravelEventPage> createState() => _TravelEventPageState();
}

class _TravelEventPageState extends State<TravelEventPage> {
  String _searchText = '';

  final List<Map<String, dynamic>> subCategories = [
    {
      'name': 'Holidays',
      'image': 'assets/images/holidays.png',
      'page': Holidays(),
    },
    {
      'name': 'Entertainment',
      'image': 'assets/images/entertainment1.png',
      'page': Entertainment(),
    },
  ];

  @override
  Widget build(BuildContext context) {
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
          "Travel Events",
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
                  hintText: 'Search Events',
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
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: subCategories.map((category) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => category['page'],
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          category['image'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        category['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}