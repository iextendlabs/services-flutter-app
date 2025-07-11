import 'package:flutter/foundation.dart'; // For ValueNotifier

class WishlistItem {
  final String id; // Unique identifier for the item
  final String imagePath;
  final String title;
  final String price;
  final double rating; // Add this line
  final String slug; // <-- Add this line

  WishlistItem({required this.id, required this.imagePath, required this.title, required this.price, required this.rating, required this.slug});

  // Override equals and hashCode for proper comparison in lists
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  // If you have fromJson or similar, add slug there too
  factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
    id: json['id'],
    title: json['title'],
    imagePath: json['imagePath'],
    price: json['price'],
    rating: (json['rating'] ?? 0).toDouble(),
    slug: json['slug'], // <-- Add this line
  );
}

class WishlistService {
  final ValueNotifier<List<WishlistItem>> _wishlistItems = ValueNotifier([]);

  ValueListenable<List<WishlistItem>> get items => _wishlistItems;

  int get itemCount => _wishlistItems.value.length;

  void addItem(WishlistItem item) {
    if (!isItemInWishlist(item.id)) { // Use id for checking
      _wishlistItems.value = List.from(_wishlistItems.value)..add(item);
    }
  }

  void removeItem(String itemId) { // Remove by id
    _wishlistItems.value = List.from(_wishlistItems.value)..removeWhere((element) => element.id == itemId);
  }

  bool isItemInWishlist(String itemId) { // Check by id
    return _wishlistItems.value.any((item) => item.id == itemId);
  }
}

// Global instance of WishlistService for easy access
final WishlistService wishlistService = WishlistService();