import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class GentsSalon extends StatefulWidget {
  const GentsSalon({super.key});

  @override
  State<GentsSalon> createState() => _GentsSalonState();
}

class _GentsSalonState extends State<GentsSalon> {
  final List<Map<String, dynamic>> gentsServices = const [
    {
      'imageUrl': 'assets/images/image4.png',
      'title': 'Haircut',
      'rating': 4.5,
      'price': 15,
    },
    {
      'imageUrl': 'assets/images/image4.png',
      'title': 'Beard Trim',
      'rating': 4.2,
      'price': 20,
    },
    {
      'imageUrl': 'assets/images/image4.png',
      'title': 'Haircut & Beard Trim',
      'rating': 4.8,
      'price': 25,
    },
    {
      'imageUrl': 'assets/images/image4.png',
      'title': 'Hot Towel Shave',
      'rating': 4.6,
      'price': 10,
    },
    {
      'imageUrl': 'assets/images/image4.png',
      'title': 'Facial',
      'rating': 4.3,
      'price': 30,
    },
    {
      'imageUrl': 'assets/images/image4.png',
      'title': 'Eyebrow Shaping',
      'rating': 4.7,
      'price': 12,
    },
  ];

  // Track wishlisted items by index
  final Set<int> _wishlist = {};

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
          "Gents' Salon",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        itemCount: gentsServices.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final service = gentsServices[index];
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '\$${service['price']}',
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
                // Wishlist and Add to Cart column
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                        color: AppColors.accentColor,
                        size: 20, // Smaller size
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
                      onPressed: () {},
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
    );
  }
}
