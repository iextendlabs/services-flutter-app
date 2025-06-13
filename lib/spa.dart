import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class SpaPage extends StatefulWidget {
  const SpaPage({super.key});

  @override
  State<SpaPage> createState() => _SpaPageState();
}

class _SpaPageState extends State<SpaPage> {
  final List<Map<String, dynamic>> spaServices = [
    {
      'imageUrl': 'assets/images/full_body_massage.png',
      'title': 'Full Body Massage',
      'rating': 4,
      'price': 150,
      'duration': 70,
    },
    {
      'imageUrl': 'assets/images/postpartum_massage.png',
      'title': 'Postpartum Massage',
      'rating': 3,
      'price': 149,
      'duration': 60,
    },
    // Add more services as needed
  ];

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
          "Spa",
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
        itemCount: spaServices.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final service = spaServices[index];
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
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Booked ${service['title']}!'),
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
                        'Book Now',
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
