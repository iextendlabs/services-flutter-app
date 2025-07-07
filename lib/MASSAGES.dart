import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/female_massage.dart';
import 'package:lipslay_flutter_frontend/mens_massage.dart';
import 'package:lipslay_flutter_frontend/wishlist_service.dart';
import 'package:lipslay_flutter_frontend/cart_service.dart';
import 'package:lipslay_flutter_frontend/ItemView.dart';
import 'package:lipslay_flutter_frontend/book_nowPage.dart';

class MASSAGESPage extends StatefulWidget {
  const MASSAGESPage({super.key});

  @override
  State<MASSAGESPage> createState() => _MASSAGESPageState();
}

class _MASSAGESPageState extends State<MASSAGESPage> {
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
  String _searchText = '';
  final Set<int> _wishlist = {};
  final List<Map<String, dynamic>> subCategories = [
    {
      'name': 'Men\'s Massages',
      'image': 'assets/images/circle_spa_mens_massage.png',
      'page': MensMassage(),
    },
    {
      'name': 'Female Massages',
      'image': 'assets/images/circle_spa_womens_massage.png',
      'page': FemaleMassage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredServices = spaServices
    .where((service) {
      return service['title'].toString().toLowerCase().contains(
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
          "Massages",
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
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  subCategories.map((category) {
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
                          // CircleAvatar(
                          //   radius: 40,
                          //   backgroundImage: AssetImage(category['image']),
                          // ),
                          ClipOval(
                            child: Image.asset(
                              category['image'],
                              width: 80,
                              height: 80,
                              fit:
                                  BoxFit
                                      .fill, // Ensures the image fills the circle
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
                    color: AppColors.white,
                    // color: AppColors.primarypageWhite,
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
                                      title: service['title'],
                                      description:
                                          "Enjoy professional care and attention to detail with every service.\n"
                                          "Our experienced team ensures your comfort and satisfaction.\n"
                                          "We use premium products for outstanding results every time.\n"
                                          "Book now and treat yourself to a truly refreshing experience!",
                                      imageUrl: service['imageUrl'],
                                      // price: 'AED ${service['price']}',
                                      // rating: service['rating'].toDouble(),
                                      // duration: service['duration'].toString(),
                                      whatsappNumber: service['whatsappNumber'] ?? '',
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
                                      // whatsappNumber: service['whatsappNumber'] ?? '',
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
                                  builder: (context) => BookNowPage(
                                    // Pass item info to BookNowPage using named parameters
                                    serviceTitle: service['title'],
                                    serviceImage: service['imageUrl'],
                                    servicePrice: service['price'].toString(),
                                    serviceRating: service['rating'].toString(),
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
