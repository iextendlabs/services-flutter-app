import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/wishlist_service.dart'; // Import the wishlist service
import 'package:lipslay_flutter_frontend/cart_service.dart'; // Import the cart service

// A simple data model for a product - kept here for SearchPage
class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String price;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _loadDummyProducts();
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    super.dispose();
  }

  // Dummy products with unique IDs and image paths
  void _loadDummyProducts() {
    _allProducts = [
      Product(
        id: '101',
        name: 'Luxury Manicure',
        imageUrl: 'assets/images/image2.png',
        price: 'AED 80',
      ),
      Product(
        id: '102',
        name: 'Pedicure Deluxe',
        imageUrl: 'assets/images/image4.png',
        price: 'AED 95',
      ),
      Product(
        id: '103',
        name: 'Full Body Massage',
        imageUrl: 'assets/images/image4.png',
        price: 'AED 250',
      ),
      Product(
        id: '104',
        name: 'Hair Coloring',
        imageUrl: 'assets/images/image2.png',
        price: 'AED 300',
      ),
      Product(
        id: '105',
        name: 'Facial Cleansing',
        imageUrl: 'assets/images/image4.png',
        price: 'AED 120',
      ),
      Product(
        id: '106',
        name: 'Beard Trim',
        imageUrl: 'assets/images/image2.png',
        price: 'AED 40',
      ),
      Product(
        id: '107',
        name: 'Kids Haircut',
        imageUrl: 'assets/images/image4.png',
        price: 'AED 50',
      ),
      Product(
        id: '108',
        name: 'Bridal Makeup',
        imageUrl: 'assets/images/image2.png',
        price: 'AED 800',
      ),
      Product(
        id: '109',
        name: 'Deep Conditioning',
        imageUrl: 'assets/images/image4.png',
        price: 'AED 100',
      ),
      Product(
        id: '110',
        name: 'Waxing Full Legs',
        imageUrl: 'assets/images/image2.png',
        price: 'AED 180',
      ),
      Product(
        id: '111',
        name: 'Acne Treatment',
        imageUrl: 'assets/images/image4.png',
        price: 'AED 220',
      ),
      Product(
        id: '112',
        name: 'Sports Massage',
        imageUrl: 'assets/images/image4.png',
        price: 'AED 280',
      ),
    ];
    _filteredProducts = _allProducts; // Initially show all products
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts =
          _allProducts.where((product) {
            return product.name.toLowerCase().contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // REMOVED THE SCAFFOLD AND APPBAR from here!
    // The HomePage now provides the Scaffold and the main AppBar.
    return Column(
      children: [
        // The search bar is now part of the tab's body content
        // and its background color needs to be adjusted since it's no longer in an AppBar
        Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the search bar
          child: Container(
            decoration: BoxDecoration(
              color:
                  AppColors
                      .white, // White background for the search bar container
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search services or products...',
                hintStyle: const TextStyle(
                  color: AppColors.grey,
                  fontFamily: 'Ubuntu',
                ),
                prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                filled:
                    false, // Not filled, as the container provides the background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      BorderSide.none, // No border for the TextField itself
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
              style: const TextStyle(
                color: AppColors.black,
                fontFamily: 'Ubuntu',
              ),
              cursorColor: AppColors.black,
            ),
          ),
        ),
        Expanded(
          child:
              _filteredProducts.isEmpty
                  ? const Center(
                    child: Text(
                      'No items found matching your search.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.grey,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  )
                  : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 0.0,
                    ), // Adjust padding
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return _buildProductCard(context, product);
                    },
                  ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        color: AppColors.grey200,
                        height: 180,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 80,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
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
                          product.price,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            cartService.addToCart(
                              CartItem.fromProduct(product),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.name} added to cart!'),
                                duration: const Duration(milliseconds: 500),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: ValueListenableBuilder<List<WishlistItem>>(
              valueListenable: wishlistService.items,
              builder: (context, wishlistItems, child) {
                final bool isInWishlist = wishlistService.isItemInWishlist(
                  product.id,
                );
                return GestureDetector(
                  onTap: () {
                    if (isInWishlist) {
                      wishlistService.removeItem(product.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${product.name} removed from wishlist.',
                          ),
                        ),
                      );
                    } else {
                      wishlistService.addItem(
                        WishlistItem(
                          id: product.id,
                          imagePath: product.imageUrl,
                          title: product.name,
                          price: product.price,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} added to wishlist!'),
                          duration: const Duration(milliseconds: 500),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isInWishlist ? Icons.favorite : Icons.favorite_border,
                      color:
                          isInWishlist ? AppColors.accentColor : AppColors.grey,
                      size: 24,
                    ),
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
