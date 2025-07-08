import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class StaffProfilePage extends StatefulWidget {
  final int staffId;
  const StaffProfilePage({super.key, required this.staffId});

  @override
  State<StaffProfilePage> createState() => _StaffProfilePageState();
}

class _StaffProfilePageState extends State<StaffProfilePage> {
  Map<String, dynamic>? staffData;
  bool isLoading = true;
  List<dynamic> countries = [];

  @override
  void initState() {
    super.initState();
    loadCountriesAndStaff();
  }

  Future<void> loadCountriesAndStaff() async {
    final countriesJson = await rootBundle.loadString('assets/data/countries.json');
    countries = json.decode(countriesJson);
    await loadStaff();
  }

  Future<void> loadStaff() async {
    final box = await Hive.openBox('staffProfiles');
    final cacheKey = 'staff_${widget.staffId}';
    final cached = box.get(cacheKey);

    if (cached != null) {
      setState(() {
        staffData = Map<String, dynamic>.from(json.decode(cached));
        isLoading = false;
      });
    }

    try {
      final response = await http.get(Uri.parse('https://wishlist.lipslay.com/api/staff?staff=${widget.staffId}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          staffData = data;
          isLoading = false;
        });
        box.put(cacheKey, json.encode(data));
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildSocialIcon(String? url, IconData icon, {Color? color}) {
    if (url == null || url.isEmpty) return const SizedBox.shrink();
    return IconButton(
      icon: Icon(icon, color: color ?? AppColors.accentColor),
      onPressed: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        }
      },
    );
  }

  String? getFlagForPhone(String? phone) {
    if (phone == null || phone.isEmpty || countries.isEmpty) return null;
    String normalized = phone.replaceAll(RegExp(r'[\s\-]'), '');
    countries.sort((a, b) => (b['dial_code'] as String).length.compareTo((a['dial_code'] as String).length));
    for (final country in countries) {
      final dialCode = country['dial_code'] as String;
      if (normalized.startsWith(dialCode.replaceAll(RegExp(r'[\s\-]'), ''))) {
        return country['flag'] as String?;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (staffData == null) {
      return const Scaffold(
        body: Center(child: Text('Failed to load staff profile')),
      );
    }

    final imageUrl = staffData!['image'] != null && staffData!['image'].toString().isNotEmpty
        ? (staffData!['image'].toString().startsWith('http')
            ? staffData!['image']
            : 'https://test.lipslay.com/img/staff-images/${staffData!['image']}')
        : null;

    final reviews = staffData!['reviews'] as List<dynamic>? ?? [];
    final phoneFlag = getFlagForPhone(staffData!['phone']);
    final whatsappFlag = getFlagForPhone(staffData!['whatsapp']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primaryDark,
        foregroundColor:AppColors.black,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor:AppColors.primarypageWhite,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                // Avatar
                Center(
                  child: CircleAvatar(
                    radius: 56,
                    backgroundColor:AppColors.secondaryDark,
                    backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
                    child: imageUrl == null
                        ? const Icon(Icons.person, size: 56, color:AppColors.grey)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                // Name
                Text(
                  staffData!['name'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color:AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Subtitle
                if (staffData!['sub_title'] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      staffData!['sub_title'],
                      style: const TextStyle(
                        fontSize: 16,
                        color:AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 24),
                // Contact Section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contact',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color:AppColors.grey800,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Phone
                if (staffData!['phone'] != null && staffData!['phone'].toString().isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryDark, // <-- changed here
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.phone, color:AppColors.black87),
                        const SizedBox(width: 10),
                        if (phoneFlag != null)
                          Text(phoneFlag, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            staffData!['phone'],
                            style: const TextStyle(fontSize: 16, color:AppColors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                // WhatsApp
                if (staffData!['whatsapp'] != null && staffData!['whatsapp'].toString().isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color:AppColors.secondaryDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.whatsapp, color:AppColors.green),
                        const SizedBox(width: 10),
                        if (whatsappFlag != null)
                          Text(whatsappFlag, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            staffData!['whatsapp'],
                            style: const TextStyle(fontSize: 16, color:AppColors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                // Social Media Section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Social Media',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      // color:AppColors.grey800,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    if (staffData!['facebook'] != null && staffData!['facebook'].toString().isNotEmpty)
                      _socialRow(
                        icon: FontAwesomeIcons.facebook,
                        label: 'Facebook',
                        url: staffData!['facebook'],
                        color:AppColors.blueGrey,
                      ),
                    if (staffData!['youtube'] != null && staffData!['youtube'].toString().isNotEmpty)
                      _socialRow(
                        icon: FontAwesomeIcons.youtube,
                        label: 'YouTube',
                        url: staffData!['youtube'],
                        color:AppColors.red,
                      ),
                    if (staffData!['snapchat'] != null && staffData!['snapchat'].toString().isNotEmpty)
                      _socialRow(
                        icon: FontAwesomeIcons.snapchat,
                        label: 'Snapchat',
                        url: staffData!['snapchat'],
                        color:AppColors.gold,
                      ),
                    if (staffData!['tiktok'] != null && staffData!['tiktok'].toString().isNotEmpty)
                      _socialRow(
                        icon: FontAwesomeIcons.tiktok,
                        label: 'TikTok',
                        url: staffData!['tiktok'],
                        color:AppColors.black,
                      ),
                    if (staffData!['instagram'] != null && staffData!['instagram'].toString().isNotEmpty)
                      _socialRow(
                        icon: FontAwesomeIcons.instagram,
                        label: 'Instagram',
                        url: staffData!['instagram'],
                        color:AppColors.primaryColor,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                // Location Section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color:AppColors.grey800,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                if (staffData!['location'] != null && staffData!['location'].toString().isNotEmpty)
                  GestureDetector(
                    onTap: () async {
                      final query = Uri.encodeComponent(staffData!['location']);
                      final googleUrl = 'https://www.google.com/maps/search/?api=1&query=$query';
                      if (await canLaunchUrl(Uri.parse(googleUrl))) {
                        await launchUrl(Uri.parse(googleUrl), mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color:AppColors.secondaryDark,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, color:AppColors.accentColor),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              staffData!['location'],
                              style: const TextStyle(
                                fontSize: 16,
                                color:AppColors.black87,
                                decoration: TextDecoration.underline,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                // About Section
                if (staffData!['about'] != null && staffData!['about'].toString().isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color:AppColors.grey800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        staffData!['about'],
                        style: const TextStyle(fontSize: 15, color:AppColors.black87),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                // Reviews Section
                if (reviews.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reviews',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color:AppColors.grey800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...reviews.map((review) => _reviewCard(review)).toList(),
                    ],
                  ),
              ],
            ),
          ),
          // Bottom Buttons
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color:AppColors.primarypageWhite,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement Book Now action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:AppColors.accentColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Implement Message action
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color:AppColors.blueGrey),
                      ),
                      child: const Text(
                        'Message',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color:AppColors.blueGrey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialRow({required IconData icon, required String label, required String url, Color? color}) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color:AppColors.secondaryDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color ??AppColors.black, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 16, color:AppColors.black87),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color:AppColors.grey),
          ],
        ),
      ),
    );
  }

  Widget _reviewCard(Map review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor:AppColors.accentColor,
              child: const Icon(Icons.person, color:AppColors.white, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review['user_name'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: List.generate(
                      (review['rating'] ?? 0),
                      (i) => const Icon(Icons.star, color:AppColors.amber, size: 16),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    review['content'] ?? '',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}