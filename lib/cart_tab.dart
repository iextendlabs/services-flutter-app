import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/cart_service.dart';
import 'package:lipslay_flutter_frontend/checkout.dart'; // Import the CheckoutPage

class CartTabContent extends StatefulWidget {
  const CartTabContent({super.key});

  @override
  State<CartTabContent> createState() => _CartTabContentState();
}

class _CartTabContentState extends State<CartTabContent> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<CartItem>>(
      valueListenable: cartService.items,
      builder: (context, cartItems, child) {
        if (cartItems.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: AppColors.grey,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your Cart is Empty!',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.grey,
                      fontFamily: 'Ubuntu',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add some amazing services or products to your cart.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.grey,
                      fontFamily: 'Ubuntu',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return _buildCartItemCard(context, item);
                },
              ),
            ),
            _buildCartSummary(context, cartItems),
          ],
        );
      },
    );
  }

  Widget _buildCartItemCard(BuildContext context, CartItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      color: AppColors.grey200,
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: AppColors.grey,
                      ),
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.price,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: AppColors.accentColor,
                        ),
                        onPressed: () {
                          cartService.removeFromCart(item.id);
                        },
                      ),
                      Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: AppColors.accentColor,
                        ),
                        onPressed: () {
                          cartService.addToCart(
                            item,
                          ); // Add the same item again
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: AppColors.red,
                        ),
                        onPressed: () {
                          cartService.removeAllOfItem(item.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${item.name} removed from cart.'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, List<CartItem> cartItems) {
    double subtotal = 0;
    for (var item in cartItems) {
      // Assuming price is like "AED 110"
      final priceString = item.price.replaceAll('AED ', '');
      subtotal += (double.tryParse(priceString) ?? 0.0) * item.quantity;
    }
    double deliveryFee =
        subtotal > 0
            ? 15.0
            : 0.0; // Example: AED 15 delivery fee if there are items
    double total = subtotal + deliveryFee;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, -3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow('Subtotal', 'AED ${subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Delivery Fee',
            'AED ${deliveryFee.toStringAsFixed(2)}',
          ),
          const Divider(height: 20, thickness: 1),
          _buildSummaryRow(
            'Total',
            'AED ${total.toStringAsFixed(2)}',
            isTotal: true,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(cartItems: cartItems),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentColor, // Pink button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            color: isTotal ? AppColors.black : AppColors.grey600,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Ubuntu',
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            color: isTotal ? AppColors.black : AppColors.grey600,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Ubuntu',
          ),
        ),
      ],
    );
  }
}
