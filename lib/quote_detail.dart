import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants/appColors.dart';
import 'package:url_launcher/url_launcher.dart';

class QuoteDetailPage extends StatelessWidget {
  final String fromName;
  final String contactNumber;
  final String whatsappNumber;
  final String address;
  final String serviceName;
  final String serviceImage;
  final int quantity;
  final String status;
  final String message;
  final String phoneCountryCode;
  final String phoneCountryFlag;
  final String whatsappCountryCode;
  final String whatsappCountryFlag;

  const QuoteDetailPage({
    super.key,
    required this.fromName,
    required this.contactNumber,
    required this.whatsappNumber,
    required this.address,
    required this.serviceName,
    required this.serviceImage,
    required this.quantity,
    required this.status,
    required this.message,
    required this.phoneCountryCode,
    required this.phoneCountryFlag,
    required this.whatsappCountryCode,
    required this.whatsappCountryFlag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Quote',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Ubuntu',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Quote Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Ubuntu',
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Send by: $fromName',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.black,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 24),
            // Phone and WhatsApp on separate lines
            Row(
              children: [
                const Icon(Icons.phone, color: AppColors.black87, size: 20),
                const SizedBox(width: 8),
                Text(
                  '$phoneCountryFlag $phoneCountryCode $contactNumber',
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: AppColors.green,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '$whatsappCountryFlag $whatsappCountryCode $whatsappNumber',
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Address row with icon, blue color, and tap to open maps
            GestureDetector(
              onTap: () async {
                final query = Uri.encodeComponent(address);
                final googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=$query';
                if (await canLaunchUrl(Uri.parse(googleUrl))) {
                  await launchUrl(Uri.parse(googleUrl));
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.accentColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      address,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontFamily: 'Ubuntu',
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 32,
              thickness: 1.2,
              color: AppColors.secondaryDark,
            ),
            const Text(
              'Service',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Ubuntu',
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    serviceImage,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.black,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                    Text(
                      'Quantity: $quantity',
                      style: const TextStyle(
                        color: AppColors.accentColor,
                        fontSize: 15,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Status',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Ubuntu',
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              status,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.black,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Message',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Ubuntu',
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.black,
                fontFamily: 'Ubuntu',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.accentColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
      ],
    );
  }
}
