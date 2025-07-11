import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/ItemView.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/notificationpage.dart';
import 'package:lipslay_flutter_frontend/wishlist_service.dart'; // Import the service
import 'package:lipslay_flutter_frontend/cart_service.dart'; // Import the CartService
import 'package:lipslay_flutter_frontend/book_nowPage.dart';

class WishlistTabContent extends StatefulWidget {
  const WishlistTabContent({super.key});

  @override
  State<WishlistTabContent> createState() => _WishlistTabContentState();
}

class _WishlistTabContentState extends State<WishlistTabContent> {
  // Initialize dummy data when the widget is created
  @override
  void initState() {
    super.initState();
    // wishlistService.initializeDummyData(); // Add some initial items for testing
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<WishlistItem>>(
      valueListenable:
          wishlistService.items, // Listen to changes in wishlistService.items
      builder: (context, wishlistItems, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header Section with a white background/border
              //
              // Main content area, separated from the header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ), // Padding for the content below the header
                child:
                    wishlistItems.isEmpty
                        ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.favorite_border,
                                  size: 80,
                                  color: AppColors.grey,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Your Wishlist is Empty!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.grey,
                                  ),
                                ),
                                Text(
                                  'Add some items you love.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        : Column(
                          children:
                              wishlistItems.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 20.0,
                                  ), // Space between cards
                                  child: _buildWishlistItemCard(
                                    context,
                                    item: item,
                                    onRemove: () {
                                      setState(() {
                                        wishlistService.removeItem(item.id);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '${item.title} removed from wishlist.',
                                            ),
                                            duration: const Duration(
                                              seconds: 2,
                                            ), // Added duration
                                          ),
                                        );
                                      });
                                    },
                                    onAddToCart: () {
                                      // New callback for Add to Cart
                                      final cartItem = CartItem(
                                        id: item.id,
                                        name: item.title,
                                        imageUrl: item.imagePath,
                                        price: item.price,
                                        quantity: 1,
                                        staffName: '',  
                                        bookingDate: '',
                                        bookingTime: '',
                                      );
                                      cartService.addToCart(cartItem);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${item.title} added to cart!',
                                          ),
                                          duration: const Duration(
                                            seconds: 2,
                                          ), // Added duration
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                        ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper method to build a single wishlist item card
  Widget _buildWishlistItemCard(
    BuildContext context, {
    required WishlistItem item,
    required VoidCallback onRemove,
    required VoidCallback onAddToCart,
  }) {
    return GestureDetector(
      onTap: () {
        final fullSlug = item.slug;
  final apiSlug = fullSlug.split('/').last;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemView(
              slug: apiSlug, // <-- Universal, dynamic loading
            ),
          ),
        );
      },
      child: Card(
        margin:
            EdgeInsets.zero, // Remove default card margin, use parent padding
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          // Use Stack to overlay the heart icon on the image
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: item.imagePath.startsWith('http')
                      ? Image.network(
                          item.imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 180,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.grey200,
                            height: 180,
                            child: const Center(child: Icon(Icons.broken_image)),
                          ),
                        )
                      : Image.asset(
                          item.imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 180,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.grey200,
                            height: 180,
                            child: const Center(child: Icon(Icons.broken_image)),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.price,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.black,
                              fontFamily: 'Ubuntu',
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
                                        serviceTitle: item.title,
                                        serviceImage: item.imagePath,
                                        servicePrice: item.price,
                                        serviceRating: item.rating.toString(),
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
                ),
              ],
            ),
            // Heart icon (like on the image) - now a remove button
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: onRemove, // Call the onRemove callback
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete,
                    color: AppColors.grey,
                    size: 20,
                  ), // Changed to delete icon
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
