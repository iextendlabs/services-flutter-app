import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/book_nowPage.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemView extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? price;
  final String? whatsappNumber;
  final String? duration;
  final List? features;
  final String? slug;

  const ItemView({
    Key? key,
    this.title,
    this.description,
    this.imageUrl,
    this.price,
    this.whatsappNumber = '',
    this.duration,
    this.features,
    this.slug,
  }) : super(key: key);

  void _bookOnWhatsApp(BuildContext context) async {
    if (whatsappNumber == null || whatsappNumber!.isEmpty) return;
    final url =
        'https://wa.me/$whatsappNumber?text=I%20want%20to%20book%20${Uri.encodeComponent(title ?? '')}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open WhatsApp')));
    }
  }

  void _bookNow(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookNowPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title ?? 'Details')),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            child: (imageUrl != null && imageUrl!.isNotEmpty)
                ? (imageUrl!.startsWith('http')
                    ? Image.network(
                        imageUrl!,
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: double.infinity,
                          height: 180,
                          color: AppColors.grey200,
                          child: const Icon(
                            Icons.broken_image,
                            size: 100,
                            color: AppColors.grey600,
                          ),
                        ),
                      )
                    : Image.asset(
                        imageUrl!,
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                      ))
                : Container(
                    width: double.infinity,
                    height: 180,
                    color: AppColors.grey200,
                    child: const Icon(
                      Icons.image,
                      size: 100,
                      color: AppColors.grey600,
                    ),
                  ),
          ),
          Container(
            width: double.infinity,
            color: AppColors.grey100,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null && title!.isNotEmpty)
                  Text(
                    title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.black,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                if (price != null && price!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    price!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                if (duration != null && duration!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    duration!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
                if (description != null && description!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    description!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.grey800,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
                if (features != null && features!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Features',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...features!.map((f) => Row(
                        children: [
                          const Icon(Icons.check, color: AppColors.accentColor, size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              f.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
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
                        onPressed: (whatsappNumber != null && whatsappNumber!.isNotEmpty)
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