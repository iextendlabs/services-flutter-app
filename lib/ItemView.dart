import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/book_nowPage.dart';
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
    this.whatsappNumber = '03250599849', // Optional, default empty
  }) : super(key: key);

  void _bookOnWhatsApp(BuildContext context) async {
    if (whatsappNumber.isEmpty) return;
    final url =
        'https://wa.me/$whatsappNumber?text=I%20want%20to%20book%20$title';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open WhatsApp')));
    }
  }

  void _bookNow(BuildContext context) {
    // Implement your booking logic here
     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BookNowPage()),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: 
      ListView(
        padding: EdgeInsets.zero,
        children: [
      // SingleChildScrollView(
      //   child: Column(
      //     children: [
            // Center(
              // child:
               ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                child:
                    imageUrl.isNotEmpty
                        ? (imageUrl.startsWith('http')
                            ? Image.network(
                              imageUrl,
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            )
                            : Image.asset(
                              imageUrl,
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ))
                        : Container(
                          width: double.infinity,
                          height: 180,
                          color: AppColors.grey200,
                          child: Icon(
                            Icons.image,
                            size: 100,
                            color: AppColors.grey600,
                          ),
                        ),
              ),
            // ),
              Container(
            width: double.infinity,
            color: AppColors.grey100,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.black,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description +   '\n\n'
  //        "Enjoy professional care and attention to detail with every service.\n"
  // "Our experienced team ensures your comfort and satisfaction.\n"
  // "We use premium products for outstanding results every time.\n"
  // "Book now and treat yourself to a truly refreshing experience!"
  ,
                 style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.grey800,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _bookNow(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: whatsappNumber.isNotEmpty
                            ? () => _bookOnWhatsApp(context)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.grey200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Book on WhatsApp',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }
}