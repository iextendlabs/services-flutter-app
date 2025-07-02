// ignore_for_file: deprecated_member_use

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/ECommercePage.dart';
import 'package:lipslay_flutter_frontend/Facebook.dart';
import 'package:lipslay_flutter_frontend/Tiktok.dart';
import 'package:lipslay_flutter_frontend/applemusic.dart';
import 'package:lipslay_flutter_frontend/club.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/discord.dart';
import 'package:lipslay_flutter_frontend/female_massage.dart';
import 'package:lipslay_flutter_frontend/instagram.dart';
import 'package:lipslay_flutter_frontend/itsolutionpage.dart';
import 'package:lipslay_flutter_frontend/kick.dart';
import 'package:lipslay_flutter_frontend/linkedin.dart';
import 'package:lipslay_flutter_frontend/male_packages.dart';
import 'package:lipslay_flutter_frontend/marketingpage.dart';
import 'package:lipslay_flutter_frontend/mens_massage.dart';
import 'package:lipslay_flutter_frontend/reddit.dart';
import 'package:lipslay_flutter_frontend/rumble.dart';
import 'package:lipslay_flutter_frontend/snapchat.dart';
import 'package:lipslay_flutter_frontend/soundcloud.dart';
import 'package:lipslay_flutter_frontend/spotify.dart';
import 'package:lipslay_flutter_frontend/subscriptionspage.dart';
import 'package:lipslay_flutter_frontend/telegrammarketing.dart';
import 'package:lipslay_flutter_frontend/trovo.dart';
import 'package:lipslay_flutter_frontend/twitch.dart';
import 'package:lipslay_flutter_frontend/websitetraffic.dart';
import 'package:lipslay_flutter_frontend/wholesale_salon_products.dart';
import 'package:lipslay_flutter_frontend/wholesalebeverages.dart';
import 'package:lipslay_flutter_frontend/youtube.dart';
import 'home_tab.dart'; // Import where your ServiceCategory and lists are defined
import 'package:lipslay_flutter_frontend/Beautyaddonpage.dart';
import 'package:lipslay_flutter_frontend/PackagePage.dart';
import 'package:lipslay_flutter_frontend/BleachThreadingPage.dart';
import 'package:lipslay_flutter_frontend/FacialPage.dart';
import 'package:lipslay_flutter_frontend/HennaPage.dart';
import 'package:lipslay_flutter_frontend/MakeupPage.dart';
import 'package:lipslay_flutter_frontend/ManicurePedicurePage.dart';
import 'package:lipslay_flutter_frontend/LadiesMassagePage.dart';
import 'package:lipslay_flutter_frontend/NailsPage.dart';
import 'package:lipslay_flutter_frontend/WaxingPage.dart';
import 'package:lipslay_flutter_frontend/pestcontrolpage.dart';
import 'package:lipslay_flutter_frontend/homeappliancespage.dart';
import 'package:lipslay_flutter_frontend/maintenancepage.dart';
import 'package:lipslay_flutter_frontend/cleaningpage.dart';
import 'package:lipslay_flutter_frontend/itservicespage.dart';
import 'package:lipslay_flutter_frontend/holidays.dart';
import 'package:lipslay_flutter_frontend/enterainment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CategoryModel.dart' as catmodel;
import 'models/category_hive_model.dart';
import 'package:hive/hive.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
        backgroundColor: AppColors.primarypageWhite,
        foregroundColor: AppColors.black,
      ),
      backgroundColor: AppColors.primarypageWhite,
      body: FutureBuilder<List<catmodel.ServiceCategory>>(
        future: fetchCategoriesAsServiceCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories found.'));
          }
          final categories = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 2.8,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return _buildCategoryCard(context, category);
            },
          );
        },
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<catmodel.ServiceCategory> categories,
  ) {
    if (categories.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.black87,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 2.8,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(context, category);
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    catmodel.ServiceCategory category,
  ) {
    return InkWell(
      onTap: () {
        final normalizedTitle = normalize(category.title);
        final routeEntry = categoryPageBuilders.entries.firstWhere(
          (entry) => normalize(entry.key) == normalizedTitle,
          orElse:
              () => MapEntry(
                '',
                () => Scaffold(
                  appBar: AppBar(title: const Text('Error')),
                  body: const Center(
                    child: Text('Page not available for this category.'),
                  ),
                ),
              ),
        );
        if (routeEntry.key.isNotEmpty) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => routeEntry.value()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Page not available for this category.'),
            ),
          );
        }
      },
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.calenderblueGrey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                color: AppColors.transparent,
                width: 50,
                height: 50,
                child:
                    category.imageUrl.startsWith('http')
                        ? Image.network(category.imageUrl, fit: BoxFit.cover)
                        : Image.asset(category.imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                category.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final Map<String, Widget Function()> categoryPageBuilders = {
  'Beautyaddon': () => const BeautyaddonPage(),
  'Packages': () => const PackagePage(),
  'Bleach & Threading': () => const BleachThreadingPage(),
  'Facials': () => const FacialPage(),
  'Henna': () => const HennaPage(),
  'Makeup': () => const MakeupPage(),
  'Manicure & Pedicure': () => const ManicurePedicurePage(),
  'Ladies Massage': () => const LadiesMassagePage(),
  'Nails': () => const NailsPage(),
  'Waxing': () => const WaxingPage(),
  'Male Packages': () => const MalePackages(),
  'Men\'s Massage': () => const MensMassage(),
  'Female Massage': () => const FemaleMassage(),
  'IT Solution': () => ITSolutionPage(),
  'Marketing': () => const MarketingPage(),
  'Subscriptions': () => const SubscriptionsPage(),
  'Pest Control': () => Pestcontrolpage(),
  'Home Appliances': () => Homeappliancespage(),
  'Maintenance': () => Maintenancepage(),
  'Cleaning': () => Cleaningpage(),
  'IT Services': () => ITServicesPage(),
  'Holidays': () => Holidays(),
  'Entertainment': () => Entertainment(),
  'Wholesale Beverage': () => WholesaleBeverages(),
  'Wholesale Salon\n Products': () => WholesaleSalonProductsPage(),
  'E-Commerce Stock': () => ECommercePage(),
  'Telegram Marketing': () => TelegramMarketing(),
  'Spotify Marketing': () => SpotifyMarketing(),
  'SoundCloud Marketing': () => SoundCloudMarketing(),
  'LinkedIn Marketing': () => LinkedInMarketing(),
  'Discord Marketing': () => DiscordMarketing(),
  'Twitch Marketing': () => TwitchMarketing(),
  'Rumble Marketing': () => RumbleMarketing(),
  'Kick Marketing': () => KickMarketing(),
  'Club House Marketing': () => ClubHouseMarketing(),
  'SnapChat Marketing': () => SnapchatMarketing(),
  'Trovo Marketing': () => TrovoMarketing(),
  'Reddit Marketing': () => RedditMarketing(),
  'Website Traffic Marketing': () => WebsiteTraficMarketing(),
  'Tiktok Marketing': () => TiktokMarketing(),
  'YouTube Marketing': () => YoutubeMarketing(),
  'Facebook Marketing': () => FacebookMarketing(),
  'Apple Music Marketing': () => AppleMusicMarketing(),
  'Instagram Marketing': () => InstagramMarketing(),
  // Add more mappings as needed
};

Future<List<CategoryHiveModel>> fetchCategories() async {
  final box = Hive.box<CategoryHiveModel>('categories');
  try {
    final response = await http.get(
      Uri.parse('https://test.lipslay.com/api/staffFilterOption'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List categories = data['categories'];
      final categoryList = categories
          .map((json) => CategoryHiveModel.fromJson(json))
          .toList();

      // Save to Hive
      await box.clear();
      for (var cat in categoryList) {
        await box.put(cat.id, cat);
      }
      return categoryList;
    } else {
      // If API fails, return from Hive
      return box.values.toList();
    }
  } catch (e) {
    // On error, return from Hive
    return box.values.toList();
  }
}

// Converts CategoryHiveModel list to ServiceCategory list
Future<List<catmodel.ServiceCategory>> fetchCategoriesAsServiceCategory() async {
  final categoryHiveList = await fetchCategories();
  return categoryHiveList
      .map((cat) => catmodel.ServiceCategory(
            id: int.tryParse(cat.id ?? '0') ?? 0,
            title: cat.title ?? '',
            imageUrl: cat.imageUrl ?? '',
          ))
      .toList();
}

String normalize(String s) {
  return s.replaceAll(RegExp(r'[\s\-\&]+'), '').toLowerCase();
}
