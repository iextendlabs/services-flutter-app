// ignore_for_file: deprecated_member_use

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/AcrylicsNailsPage.dart';
import 'package:lipslay_flutter_frontend/ECommercePage.dart';
import 'package:lipslay_flutter_frontend/Facebook.dart';
import 'package:lipslay_flutter_frontend/FrenchTipAcrylicsNalisPage.dart';
import 'package:lipslay_flutter_frontend/HairPage.dart';
import 'package:lipslay_flutter_frontend/MASSAGES.dart';
import 'package:lipslay_flutter_frontend/NailArtPage.dart';
import 'package:lipslay_flutter_frontend/NewOfferPage.dart';
import 'package:lipslay_flutter_frontend/OtherServicesPage.dart';
import 'package:lipslay_flutter_frontend/PlumberServicePage.dart';
import 'package:lipslay_flutter_frontend/Tiktok.dart';
import 'package:lipslay_flutter_frontend/applemusic.dart';
import 'package:lipslay_flutter_frontend/club.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/discord.dart';
import 'package:lipslay_flutter_frontend/female_massage.dart';
import 'package:lipslay_flutter_frontend/gents_salon.dart';
import 'package:lipslay_flutter_frontend/instagram.dart';
import 'package:lipslay_flutter_frontend/itsolutionpage.dart';
import 'package:lipslay_flutter_frontend/kick.dart';
import 'package:lipslay_flutter_frontend/ladies_salon2.dart';
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

Future<List<CategoryHiveModel>> fetchCategories() async {
  final box = Hive.box<CategoryHiveModel>('categories');
  try {
    final response = await http.get(
      Uri.parse('https://wishlist.lipslay.com/api/categories'),
    );
    if (response.statusCode == 200) {
      final List categories = json.decode(response.body); // <-- direct list
      final categoryList =
          categories.map((json) => CategoryHiveModel.fromJson(json)).toList();

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
Future<List<catmodel.ServiceCategory>>
fetchCategoriesAsServiceCategory() async {
  final categoryHiveList = await fetchCategories();
  return categoryHiveList
      .map(
        (cat) => catmodel.ServiceCategory(
          id: int.tryParse(cat.id ?? '0') ?? 0,
          title: cat.title ?? '',
          imageUrl: cat.imageUrl ?? '',
        ),
      )
      .toList();
}

String normalize(String s) {
  return s.replaceAll(RegExp(r'[\s\-\&]+'), '').toLowerCase();
}

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
      body: FutureBuilder<List<CategoryHiveModel>>(
        future: fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories found.'));
          }
          final categories = flattenCategories(
            snapshot.data!,
          ); // <-- Use flattened list
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

  Widget _buildCategoryCard(BuildContext context, CategoryHiveModel category) {
    return InkWell(
      onTap: () {
        final normalized = normalize(category.title);
        final builder = categoryPageBuilders[normalized];
        if (builder != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => builder()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No page found for ${category.title}')),
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
                        ? Image.network(
                          category.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/default.png',
                              fit: BoxFit.cover,
                            );
                          },
                        )
                        : Image.asset(
                          category.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/default.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                category.title.replaceAll('-', ' ').replaceAll('&', ' '),
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

List<CategoryHiveModel> flattenCategories(List<CategoryHiveModel> categories) {
  final List<CategoryHiveModel> all = [];
  for (final cat in categories) {
    all.add(cat);
    if (cat.subcategories != null && cat.subcategories!.isNotEmpty) {
      all.addAll(cat.subcategories!);
    }
  }
  return all;
}

final Map<String, Widget Function()> categoryPageBuilders = {
  'beautyaddon': () => const BeautyaddonPage(),
  'package': () => const PackagePage(),
  'bleachthreading': () => const BleachThreadingPage(),
  'facials': () => const FacialPage(),
  'henna': () => const HennaPage(),
  'nailart': () => const NailArtPage(),
  
  'makeup': () => const MakeupPage(),
  'manicure & pedicure': () => const ManicurePedicurePage(),
  'ladies massage': () => const LadiesMassagePage(),
  'nails': () => const NailsPage(),
  'waxing': () => const WaxingPage(),
  'male packages': () => const MalePackages(),
  'men\'s massage': () => const MensMassage(),
  'female massage': () => const FemaleMassage(),
  'it solution': () => ITSolutionPage(),
  'marketing': () => const MarketingPage(),
  'subscriptions': () => const SubscriptionsPage(),
  'pest control': () => Pestcontrolpage(),
  'home appliances': () => Homeappliancespage(),
  'maintenance': () => Maintenancepage(),
  'cleaning': () => Cleaningpage(),
  'it services': () => ITServicesPage(),
  'holidays': () => Holidays(),
  'entertainment': () => Entertainment(),
  'wholesale beverage': () => WholesaleBeverages(),
  'wholesale salon\n products': () => WholesaleSalonProductsPage(),
  'e-commerce stock': () => ECommercePage(),
  'telegram marketing': () => TelegramMarketing(),
  'spotify marketing': () => SpotifyMarketing(),
  'soundcloud marketing': () => SoundCloudMarketing(),
  'linkedin marketing': () => LinkedInMarketing(),
  'discord marketing': () => DiscordMarketing(),
  'twitch marketing': () => TwitchMarketing(),
  'rumble marketing': () => RumbleMarketing(),
  'kick marketing': () => KickMarketing(),
  'club house marketing': () => ClubHouseMarketing(),
  'snapchat marketing': () => SnapchatMarketing(),
  'trovo marketing': () => TrovoMarketing(),
  'reddit marketing': () => RedditMarketing(),
  'website traffic marketing': () => WebsiteTraficMarketing(),
  'tiktok marketing': () => TiktokMarketing(),
  'youtube marketing': () => YoutubeMarketing(),
  'facebook marketing': () => FacebookMarketing(),
  'apple music marketing': () => AppleMusicMarketing(),
  'instagram marketing': () => InstagramMarketing(),
  'nailart': () => const NailArtPage(),
  'acrylicsnails': () => const AcrylicsNailsPage(), // Assuming this is a specific case for acrylic nails
  'frenchtipacrylicsnails': () => const FrenchTipAcryilcsNailsPage(),
  'newoffer': () => const NewOfferPage(),
  'otherservices': () => const OtherServicesPage(),
  'gentssalon': () => const GentsSalon(),
  'ladiessalon': () => LadiesSalonPage(),
  'bleach&threading': () => const BleachThreadingPage(),
  'facial':() => const FacialPage(),
  'makeup':() => const MakeupPage(),
  'manicurepedicure':() => const ManicurePedicurePage(),
  'massages':() => const MASSAGESPage(),
  'waxing':() => const WaxingPage(),
  'hair':() => const HairPage(),
  'plumberservice': () => const PlumberServicePage(),
  
 // Default case if no specific page is found
  // Add more mappings as needed
};
