import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/payNow.dart'; // Make sure this is your payment page
import 'package:lipslay_flutter_frontend/booking_service.dart'; // Import your booking service
import 'package:lipslay_flutter_frontend/booking_tab.dart'; // Import your booking model
import 'package:lipslay_flutter_frontend/cart_service.dart'; // Add this import

class CheckoutPage extends StatefulWidget {
  final List<CartItem>? cartItems;

  final String? serviceTitle;
  final String? serviceImage;
  final String? serviceCategory;
  final String? bookingDate;
  final String? bookingTime;
  final String? servicePrice;
  final String? staffName;

  const CheckoutPage({
    Key? key,
    this.cartItems,
    this.serviceTitle,
    this.serviceImage,
    this.serviceCategory,
    this.bookingDate,
    this.bookingTime,
    this.servicePrice,
    this.staffName,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController couponController = TextEditingController();
  final TextEditingController affiliateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String selectedGender = 'Female';
  String selectedPayment = 'Cash on Delivery';
  String address = '123 Main Street, Anytown, USA';

  @override
  Widget build(BuildContext context) {
    // Calculate price for cart or single service
    double servicePrice = 0.0;
    if (widget.cartItems != null && widget.cartItems!.isNotEmpty) {
      for (final item in widget.cartItems!) {
        final price =
            double.tryParse(item.price.replaceAll(RegExp(r'[^0-9.]'), '')) ??
            0.0;
        servicePrice += price * (item.quantity ?? 1);
      }
    } else {
      servicePrice =
          double.tryParse(
            widget.servicePrice?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '0',
          ) ??
          0.0;
    }
    double discounts = 10.0;
    double staffCharges = 20.0;
    double transportCharges = 5.0;
    double total = servicePrice - discounts + staffCharges + transportCharges;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show cart items if present
            if (widget.cartItems != null && widget.cartItems!.isNotEmpty) ...[
              const Text(
                'Cart Items',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  fontFamily: 'Ubuntu',
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.cartItems!.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems![index];
                  return Card(
                    child: ListTile(
                      leading: Image.asset(
                        item.imageUrl,
                        width: 40,
                        height: 40,
                      ),
                      title: Text(item.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.price),
                          Text('Staff: ${item.staffName}'),
                          Text('Date: ${item.bookingDate}'),
                          Text('Time: ${item.bookingTime}'),
                        ],
                      ),
                      trailing: Text('x${item.quantity}'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 18),
            ] else ...[
              // Service Details for single service
              const Text(
                'Service Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  fontFamily: 'Ubuntu',
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  if (widget.serviceImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.serviceImage!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.serviceTitle ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.serviceCategory ?? '',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F1F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.calendar_today,
                      color: Colors.black54,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${widget.bookingDate ?? ''}, Time: ${widget.bookingTime ?? ''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Booking Details',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
            ],
            // Coupon Code
            const Text(
              'Coupon Code',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: couponController,
                    decoration: InputDecoration(
                      hintText: 'Enter coupon code',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3F1F6),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Apply'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Affiliate Code
            const Text(
              'Affiliate Code',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: affiliateController,
                    decoration: InputDecoration(
                      hintText: 'Enter affiliate code',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3F1F6),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Apply'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            // User Login Data
            const Text(
              'User Login Data',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 14,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 14,
                ),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: InputDecoration(
                hintText: 'Gender',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 14,
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: 'Phone',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 14,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: whatsappController,
              decoration: InputDecoration(
                hintText: 'WhatsApp',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 14,
                ),
              ),
            ),
            const SizedBox(height: 18),
            // Address
            const Text(
              'Address',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F1F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.black54,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Home Address',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        address,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _changeAddressDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3F1F6),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Change'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            // Order Summary
            const Text(
              'Order Summary',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 10),
            _buildSummaryRow(
              'Service Charges',
              '\$${servicePrice.toStringAsFixed(2)}',
            ),
            _buildSummaryRow('Discounts', '-\$${discounts.toStringAsFixed(2)}'),
            _buildSummaryRow(
              'Staff Charges',
              '\$${staffCharges.toStringAsFixed(2)}',
            ),
            _buildSummaryRow(
              'Transport Charges',
              '\$${transportCharges.toStringAsFixed(2)}',
            ),
            const Divider(height: 24, thickness: 1),
            _buildSummaryRow(
              'Total',
              '\$${total.toStringAsFixed(2)}',
              isTotal: true,
            ),
            const SizedBox(height: 18),
            // Note
            const Text(
              'Note',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: noteController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Add a note (optional)',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 14,
                ),
              ),
            ),
            const SizedBox(height: 18),
            // Attachments
            const Text(
              'Attachments',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF3F1F6),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Upload Image'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF3F1F6),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Upload File'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            // Payment Method
            const Text(
              'Payment Method',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 8),
            RadioListTile<String>(
              value: 'Cash on Delivery',
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
              title: const Text('Cash on Delivery'),
              activeColor: Colors.pink,
              contentPadding: EdgeInsets.zero,
            ),
            RadioListTile<String>(
              value: 'Debit Card',
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
                // Navigate to PayNow page as a full page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PayNowPage()),
                );
              },
              title: const Text('Debit Card'),
              activeColor: Colors.pink,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 18),
            // Place Order Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String orderId =
                      DateTime.now().millisecondsSinceEpoch.toString();

                  // Add booking to bookingService (your existing logic)
                  bookingService.addBooking(
                    Booking(
                      orderId: orderId,
                      total: total.toStringAsFixed(2),
                      status: 'Pending',
                      date: widget.bookingDate ?? '',
                      staff: widget.staffName ?? '', // <-- This must be set!
                      timeSlot: widget.bookingTime ?? '',
                    ),
                  );

                  // Remove checked out items from cart if coming from cart
                  if (widget.cartItems != null &&
                      widget.cartItems!.isNotEmpty) {
                    for (final item in widget.cartItems!) {
                      cartService.removeAllOfItem(item.id);
                    }
                  } else {
                    // Add to cart logic for single service
                    cartService.addToCart(
                      CartItem(
                        id:
                            'booking_${widget.serviceTitle}_${widget.staffName}_${widget.serviceCategory}_${widget.bookingDate}_${widget.bookingTime}',
                        name: widget.serviceTitle ?? '',
                        imageUrl: widget.serviceImage ?? '',
                        price: widget.servicePrice ?? '',
                        quantity: 1,
                        staffName: widget.staffName ?? '',
                        bookingDate: widget.bookingDate ?? '',
                        bookingTime: widget.bookingTime ?? '',
                      ),
                    );
                  }

                  // ...show dialog or navigate as before...
                  await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (context) => Dialog(
                          backgroundColor: Colors.white.withOpacity(0.95),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 24,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Close button and title
                                Row(
                                  children: [
                                    // You can add a close button here if needed
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Order Confirmation',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Ubuntu',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 48),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Order Placed',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Your order has been successfully placed. You will receive a confirmation email shortly.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontFamily: 'Ubuntu',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 18),
                                // Order details with actual values
                                _orderRow('Order ID', orderId),
                                _orderRow(
                                  'Subtotal',
                                  '\$${servicePrice.toStringAsFixed(2)}',
                                ),
                                _orderRow(
                                  'Discounts',
                                  '-\$${discounts.toStringAsFixed(2)}',
                                ),
                                _orderRow(
                                  'Staff Charges',
                                  '\$${staffCharges.toStringAsFixed(2)}',
                                ),
                                _orderRow(
                                  'Transport Charges',
                                  '\$${transportCharges.toStringAsFixed(2)}',
                                ),
                                _orderRow(
                                  'Total Amount',
                                  '\$${total.toStringAsFixed(2)}',
                                  isTotal: true,
                                ),
                                const SizedBox(height: 18),
                                // Buttons
                                ElevatedButton(
                                  onPressed: () {
                                    // Share logic here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF3E6EB),
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    minimumSize: const Size.fromHeight(44),
                                  ),
                                  child: const Text('Share'),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigator.of(context).pop();
                                    // Navigate to BookingTabContent page
                                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => Scaffold(
                          appBar: AppBar(
                            backgroundColor: AppColors.primarypageWhite,
                            elevation: 0,
                            iconTheme: const IconThemeData(
                              color: AppColors.black,
                            ),
                            title: const Text(
                              'My Bookings',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu',
                                fontSize: 20,
                              ),
                            ),
                            centerTitle: true,
                          ),
                          body: const BookingTabContent(),
                        ),
                  ),
                );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF3E6EB),
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    minimumSize: const Size.fromHeight(44),
                                  ),
                                  child: const Text('Check Booking Details'),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                    ).popUntil((route) => route.isFirst);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF3E6EB),
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    minimumSize: const Size.fromHeight(44),
                                  ),
                                  child: const Text('Return to Homepage'),
                                ),
                              ],
                            ),
                          ),
                        ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9C7D5),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _changeAddressDialog() async {
    final controller = TextEditingController(text: address);
    final result = await showDialog<String>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Change Address'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Enter new address'),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, controller.text),
                child: const Text('Save'),
              ),
            ],
          ),
    );
    if (result != null && result.trim().isNotEmpty) {
      setState(() {
        address = result.trim();
      });
    }
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 15,
              fontFamily: 'Ubuntu',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 15,
              fontFamily: 'Ubuntu',
            ),
          ),
        ],
      ),
    );
  }

  // Helper for order row
  Widget _orderRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 15,
              fontFamily: 'Ubuntu',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 15,
              fontFamily: 'Ubuntu',
            ),
          ),
        ],
      ),
    );
  }
}
