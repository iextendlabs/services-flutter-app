import 'package:flutter/foundation.dart';
import 'package:lipslay_flutter_frontend/search_tab.dart'; // For ValueNotifier

// We can reuse the Product model from search_page for cart items,
// or create a new CartItem model if more specific properties are needed (e.g., quantity).
// For simplicity, let's assume CartItem is a Product for now, but we'll add quantity.
class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  int quantity; // Quantity of this item in the cart

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.quantity = 1, // Default quantity is 1
  });

  // Method to convert a Product to a CartItem
  factory CartItem.fromProduct(Product product) {
    return CartItem(
      id: product.id,
      name: product.name,
      imageUrl: product.imageUrl,
      price: product.price,
      quantity: 1, // When first added from product, quantity is 1
    );
  }

  // Override equals and hashCode for proper comparison in lists
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}


class CartService {
  final ValueNotifier<List<CartItem>> _cartItems = ValueNotifier([]);

  ValueListenable<List<CartItem>> get items => _cartItems;

  int get itemCount {
    // Sum of quantities for the total count displayed on the badge
    return _cartItems.value.fold(0, (sum, item) => sum + item.quantity);
  }

  // Add item to cart or increase quantity if it already exists
  void addToCart(CartItem newItem) {
    final List<CartItem> currentItems = List.from(_cartItems.value);
    int existingIndex = currentItems.indexWhere((item) => item.id == newItem.id);

    if (existingIndex != -1) {
      // Item already in cart, increase quantity
      currentItems[existingIndex].quantity += 1;
    } else {
      // Item not in cart, add new item
      currentItems.add(newItem);
    }
    _cartItems.value = currentItems;
  }

  // Remove item from cart or decrease quantity
  void removeFromCart(String itemId) {
    final List<CartItem> currentItems = List.from(_cartItems.value);
    int existingIndex = currentItems.indexWhere((item) => item.id == itemId);

    if (existingIndex != -1) {
      if (currentItems[existingIndex].quantity > 1) {
        // Decrease quantity if more than 1
        currentItems[existingIndex].quantity -= 1;
      } else {
        // Remove item completely if quantity is 1
        currentItems.removeAt(existingIndex);
      }
    }
    _cartItems.value = currentItems;
  }

  // Remove all instances of an item from the cart
  void removeAllOfItem(String itemId) {
    _cartItems.value = List.from(_cartItems.value)..removeWhere((element) => element.id == itemId);
  }

  // Clear all items from the cart
  void clearCart() {
    _cartItems.value = [];
  }
}

// Global instance of CartService for easy access
final CartService cartService = CartService();