import 'package:flutter/material.dart';

class PayNowPage extends StatefulWidget {
  const PayNowPage({Key? key}) : super(key: key);

  @override
  State<PayNowPage> createState() => _PayNowPageState();
}

class _PayNowPageState extends State<PayNowPage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color pinkBg = const Color(0xFFF9E6ED);
    final Color pinkText = const Color(0xFFB05A6F);
    final Color accentPink = const Color(0xFFFF407A);

    return Scaffold(
      backgroundColor: const Color(0xFFFCF7F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF7F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Ubuntu',
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Debit Card',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 28),
            // Card Number
            TextField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: pinkText, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: 'Card Number',
                hintStyle: TextStyle(
                  color: pinkText,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: pinkBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 18,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: expiryController,
                    keyboardType: TextInputType.datetime,
                    style: TextStyle(
                      color: pinkText,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'MM/YY',
                      hintStyle: TextStyle(
                        color: pinkText,
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      fillColor: pinkBg,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    style: TextStyle(
                      color: pinkText,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'CVV',
                      hintStyle: TextStyle(
                        color: pinkText,
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      fillColor: pinkBg,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            TextField(
              controller: nameController,
              style: TextStyle(color: pinkText, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: 'Name on Card',
                hintStyle: TextStyle(
                  color: pinkText,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: pinkBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 18,
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: pinkBg,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle payment logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentPink,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
