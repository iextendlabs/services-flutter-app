import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/wishlist_service.dart'; // Import the wishlist service
import 'package:lipslay_flutter_frontend/cart_service.dart'; // Import the cart service
import 'package:lipslay_flutter_frontend/book_nowPage.dart';
import 'package:http/http.dart' as http;
import 'package:lipslay_flutter_frontend/constants/api_constants.dart';
import 'dart:convert';
import 'package:lipslay_flutter_frontend/ItemView.dart';

// A simple data model for a product - kept here for SearchPage
class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final String rating;
  final String duration;
  final String slug;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    this.duration = '',
    required this.slug,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    String imageUrl = '';
    if (json['image'] != null && json['image'].toString().isNotEmpty) {
      final imageName = json['image'].toString();
      if (imageName.contains('/')) {
        imageUrl = '$baseUrl/$imageName';
      } else {
        imageUrl = '$baseUrl/service-images/$imageName';
      }
    }
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      imageUrl: imageUrl,
      price: json['price'].toString(),
      rating: json['rating']?.toString() ?? '0',
      duration: json['duration']?.toString() ?? '',
      slug: json['slug'] ?? '',
    );
  }
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAllProducts();
    _searchController.addListener(_filterProducts);
  }

  // Updated API call
  Future<void> _fetchAllProducts() async {
    setState(() => _isLoading = true);
    final response = await http.get(Uri.parse('$baseUrl/api/search'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> data = body['services'] ?? [];
      setState(() {
        _allProducts = data.map((item) => Product.fromJson(item)).toList();
        _filteredProducts = _allProducts;
        _isLoading = false;
      });
    } else {
      setState(() {
        _allProducts = [];
        _filteredProducts = [];
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchProductsByQuery(String query) async {
    setState(() => _isLoading = true);
    final response = await http.get(Uri.parse('$baseUrl/api/search?q=$query'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> data = body['services'] ?? [];
      setState(() {
        _filteredProducts = data.map((item) => Product.fromJson(item)).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _filteredProducts = [];
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _filteredProducts = [];
      });
      return;
    }
    _fetchProductsByQuery(query);
  }

  void _openItemView(BuildContext context, Product product) {
    final fullSlug = product.slug;
    final apiSlug = fullSlug.split('/').last;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemView(slug: apiSlug)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
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
                filled: false,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
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
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredProducts.isEmpty
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
                    ),
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
          GestureDetector(
            onTap: () {
              _openItemView(context, product);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child:
                      product.imageUrl.startsWith('http')
                          ? Image.network(
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
                          )
                          : Image.asset(
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
                            'AED ${product.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.black,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BookNowPage(
                                        serviceTitle: product.name,
                                        serviceImage: product.imageUrl,
                                        servicePrice: product.price,
                                      ),
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
                              'Book Now',
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
                          rating: double.parse(product.rating),
                          slug:
                              (product.slug)
                                  .split('/')
                                  .last, // <-- Use only last part of slug
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
