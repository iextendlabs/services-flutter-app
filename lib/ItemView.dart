import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemView extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String whatsappNumber; // Add this for WhatsApp

  const ItemView({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.whatsappNumber = '', // Optional, default empty
  }) : super(key: key);

  void _bookOnWhatsApp(BuildContext context) async {
    if (whatsappNumber.isEmpty) return;
    final url = 'https://wa.me/$whatsappNumber?text=I%20want%20to%20book%20$title';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open WhatsApp')),
      );
    }
  }

  void _bookNow(BuildContext context) {
    // Implement your booking logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Book Now pressed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          imageUrl.isNotEmpty
             ? (imageUrl.startsWith('http')
        ? Image.network(
                  imageUrl,
                  height: 250,
                  fit: BoxFit.cover,
                )
                 : Image.asset(
            imageUrl,
            height: 250,
            fit: BoxFit.cover,
          ))
              : Container(
                  height: 250,
                  color: AppColors.grey200,
                  child: Icon(Icons.image, size: 100, color: AppColors.grey600),
                ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _bookNow(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentColor, // <-- Your desired color
                        ),
      child: const Text('Book Now'),
      
                  
                  ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: whatsappNumber.isNotEmpty
                          ? () => _bookOnWhatsApp(context)
                          : null,
                      label: const Text('Book on WhatsApp'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}