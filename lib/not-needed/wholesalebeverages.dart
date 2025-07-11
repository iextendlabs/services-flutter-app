import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/ItemView.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/wishlist_service.dart';
import 'package:lipslay_flutter_frontend/cart_service.dart';
import 'package:lipslay_flutter_frontend/book_nowPage.dart';

class WholesaleBeverages extends StatefulWidget {
  const WholesaleBeverages({super.key});

  @override
  State<WholesaleBeverages> createState() => _WholesaleBeveragesState();
}

class _WholesaleBeveragesState extends State<WholesaleBeverages> {
  final List<Map<String, dynamic>> gentsServices = const [
    {
      'imageUrl': 'assets/images/image2.png',
      'title': 'Haircut',
      'rating': 4.5,
      'price': 15,
    },
    {
      'imageUrl': 'assets/images/image4.png',
      'title': 'Beautyaddonrd Trim',
      'rating': 4.2,
      'price': 20,
    },
    {
      'imageUrl': 'assets/images/henna.png',
      'title': 'Haircut & Beautyaddonrd Trim',
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
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredServices =
        gentsServices
            .where(
              (service) => service['title'].toString().toLowerCase().contains(
                _searchText.toLowerCase(),
              ),
            )
            .toList();

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
          "wholesale Beverages",
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
                  hintText: 'Search services',
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

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              itemCount: filteredServices.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final service = filteredServices[index];
                final isWishlisted = _wishlist.contains(
                  gentsServices.indexOf(service),
                );
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
                      // Wrap image + text area in GestureDetector
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        ItemView(slug: service['title']),
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
                              // Text area
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
                      // Wishlist and Add to Cart column
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
