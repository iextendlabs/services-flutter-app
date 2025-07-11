import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/book_nowPage.dart';
import 'package:lipslay_flutter_frontend/constants/api_constants.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ItemView extends StatefulWidget {
  final String? slug;
  const ItemView({Key? key, this.slug}) : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  Map<String, dynamic>? serviceData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchService();
  }

  Future<void> fetchService() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/service?query=${widget.slug ?? ""}'),
    );
    if (response.statusCode == 200) {
      setState(() {
        serviceData = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  String? get title => serviceData?['title'];
  String? get description => serviceData?['description'];
  String? get imageUrl => serviceData?['image_url'];
  String? get price => serviceData?['price'];
  String? get whatsappNumber => serviceData?['whatsapp_number'];
  String? get duration => serviceData?['duration'];
  List? get features => serviceData?['features'];

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
      MaterialPageRoute(
        builder: (context) => BookNowPage(
          serviceTitle: serviceData?['name'],
          serviceImage: serviceData?['image'],
          servicePrice: serviceData?['price'],
          serviceRating: serviceData?['rating']?.toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (serviceData == null) {
      return const Scaffold(
        body: Center(child: Text('Failed to load service')),
      );
    }

    final staffMembers = serviceData?['staffMembers'] as List<dynamic>? ?? [];
    final faqs = serviceData?['faqs'] as List<dynamic>? ?? [];
    final gallery = serviceData?['gallery'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(serviceData!['name'] ?? 'Details')),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            child:
                (serviceData!['image'] != null &&
                        serviceData!['image'].toString().isNotEmpty)
                    ? Image.network(
                      serviceData!['image'],
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
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
                Text(
                  serviceData!['name'] ?? 'No Name',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.black,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                if ((serviceData!['price'] ?? '').toString().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    serviceData!['price'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                if ((serviceData!['duration'] ?? '').toString().isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    serviceData!['duration'] ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
                if ((serviceData!['description'] ?? '')
                    .toString()
                    .isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    serviceData!['description'] ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.grey800,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
                // Staff Members Section
                if (staffMembers.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Staff Members',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...staffMembers.map(
                    (staff) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(staff['image'] ?? ''),
                      ),
                      title: Text(staff['name'] ?? ''),
                      subtitle: Text(
                        (staff['specialties'] as List<dynamic>?)?.join(', ') ??
                            '',
                      ),
                    ),
                  ),
                ],
                // FAQs Section
                if (faqs.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'FAQs',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...faqs.map(
                    (faq) => ExpansionTile(
                      title: Text(faq['question'] ?? ''),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(faq['answer'] ?? ''),
                        ),
                      ],
                    ),
                  ),
                ],
                // Gallery Section
                if (gallery.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Gallery',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: gallery
                          .map(
                            (img) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.network(img, height: 100),
                            ),
                          )
                          .toList(),
                    ),
                  ),
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
                        onPressed:
                            (whatsappNumber != null &&
                                    whatsappNumber!.isNotEmpty)
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
