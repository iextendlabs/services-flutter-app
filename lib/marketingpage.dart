import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/Facebook.dart';
import 'package:lipslay_flutter_frontend/ItemView.dart';
import 'package:lipslay_flutter_frontend/Tiktok.dart';
import 'package:lipslay_flutter_frontend/applemusic.dart';
import 'package:lipslay_flutter_frontend/cart_service.dart';
import 'package:lipslay_flutter_frontend/club.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/discord.dart';
import 'package:lipslay_flutter_frontend/instagram.dart';
import 'package:lipslay_flutter_frontend/kick.dart';
import 'package:lipslay_flutter_frontend/linkedin.dart';
import 'package:lipslay_flutter_frontend/reddit.dart';
import 'package:lipslay_flutter_frontend/rumble.dart';
import 'package:lipslay_flutter_frontend/snapchat.dart';
import 'package:lipslay_flutter_frontend/soundcloud.dart';
import 'package:lipslay_flutter_frontend/spotify.dart';
import 'package:lipslay_flutter_frontend/telegrammarketing.dart';
import 'package:lipslay_flutter_frontend/trovo.dart';
import 'package:lipslay_flutter_frontend/twitch.dart';
import 'package:lipslay_flutter_frontend/websitetraffic.dart';
import 'package:lipslay_flutter_frontend/wishlist_service.dart';
import 'package:lipslay_flutter_frontend/youtube.dart';
import 'package:lipslay_flutter_frontend/book_nowPage.dart';

class MarketingPage extends StatefulWidget {
  const MarketingPage({super.key});

  @override
  State<MarketingPage> createState() => _MarketingPageState();
}

class _MarketingPageState extends State<MarketingPage> {
  String _searchText = '';
  final Set<int> _wishlist = {};

  final List<Map<String, dynamic>> subCategories = [
    {'image': 'assets/images/nails.png', 'title': 'Telegram Marketing'},
    {'image': 'assets/images/makeup.png', 'title': 'Spotify Marketing'},
    {'image': 'assets/images/consultant.png', 'title': 'SoundCloud Marketing'},
    {'image': 'assets/images/default.png', 'title': 'LinkedIn Marketing'},
    {'image': 'assets/images/default.png', 'title': 'Discord Marketing'},
    {'image': 'assets/images/default.png', 'title': 'Twitch Marketing'},
    {'image': 'assets/images/nails.png', 'title': 'Rumble Marketing'},
    {'image': 'assets/images/makeup.png', 'title': 'Kick Marketing'},
    {'image': 'assets/images/consultant.png', 'title': 'Club House Marketing'},
    {'image': 'assets/images/default.png', 'title': 'SnapChat Marketing'},
    {'image': 'assets/images/default.png', 'title': 'Trovo Marketing'},
    {'image': 'assets/images/default.png', 'title': 'Reddit Marketing'},
    {'image': 'assets/images/nails.png', 'title': 'Website Traffic Marketing'},
    {'image': 'assets/images/makeup.png', 'title': 'Tiktok Marketing'},
    {'image': 'assets/images/default.png', 'title': 'YouTube Marketing'},
    {'image': 'assets/images/consultant.png', 'title': 'Facebook Marketing'},
    {'image': 'assets/images/default.png', 'title': 'Apple Music Marketing'},
    {'image': 'assets/images/default.png', 'title': 'Instagram Marketing'},
  ];

  final List<Map<String, dynamic>> gentsServices = const [
    {
      'imageUrl': 'assets/images/image2.png',
      'title': 'Haircut',
      'rating': 4.5,
      'price': 15,
    },
    {
      'imageUrl': 'assets/images/image4.png',
      'title': 'Beautyaddonrd Trim',
      'rating': 4.2,
      'price': 20,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredSubCategories =
        subCategories.where((sub) {
          return sub['title'].toString().toLowerCase().contains(
            _searchText.toLowerCase(),
          );
        }).toList();
    final filteredServices =
        gentsServices
            .where(
              (service) => service['title'].toString().toLowerCase().contains(
                _searchText.toLowerCase(),
              ),
            )
            .toList();

    return Scaffold(
      backgroundColor: AppColors.primarypageWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primarypageWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Marketing",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 24,
          ), // Prevents bottom overflow
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.accentColor.withOpacity(0.2),
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _searchText = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search Marketing ',
                            hintStyle: TextStyle(
                              color: AppColors.black,
                              fontFamily: 'Ubuntu',
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.black,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          style: const TextStyle(
                            color: AppColors.black,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (int i = 0; i < filteredSubCategories.length; i += 3)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(3, (j) {
                      int index = i + j;
                      if (index < filteredSubCategories.length) {
                        return _buildSubCategoryItem(
                          context,
                          filteredSubCategories[index],
                        );
                      } else {
                        // Empty space if not enough items for a full row
                        return const SizedBox(width: 70);
                      }
                    }),
                  ),
                ),
              // You can add more rows if you have more categories
              // Expanded(
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                itemCount: filteredServices.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final service = filteredServices[index];
                  final isWishlisted = _wishlist.contains(
                    gentsServices.indexOf(service),
                  );
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.primarypageWhite,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    child: Row(
                      children: [
                        // Wrap image + text area in GestureDetector
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ItemView(
                                        title: service['title'],
                                        description:
                                            'Service details for ${service['title']}', // Replace with actual description if available
                                        imageUrl: service['imageUrl'],
                                        price: service['price'],
                                      ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    service['imageUrl'],
                                    width: 56,
                                    height: 56,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                // Text area
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service['title'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: AppColors.black,
                                          fontFamily: 'Ubuntu',
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            service['rating'].toString(),
                                            style: const TextStyle(
                                              color: AppColors.black,
                                              fontSize: 13,
                                              fontFamily: 'Ubuntu',
                                            ),
                                          ),
                                          const SizedBox(width: 2),
                                          const Icon(
                                            Icons.star,
                                            color: AppColors.red,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'AED ${service['price']}',
                                        style: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Ubuntu',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Wishlist and Add to Cart column
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                wishlistService.isItemInWishlist(
                                      service['title'],
                                    )
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColors.accentColor,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  final itemId = service['title'];
                                  if (wishlistService.isItemInWishlist(
                                    itemId,
                                  )) {
                                    wishlistService.removeItem(itemId);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${service['title']} removed from wishlist',
                                        ),
                                      ),
                                    );
                                  } else {
                                    wishlistService.addItem(
                                      WishlistItem(
                                        id: itemId,
                                        imagePath: service['imageUrl'],
                                        title: service['title'],
                                        price: 'AED ${service['price']}',
                                        rating: service['rating'],
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${service['title']} added to wishlist',
                                        ),
                                      ),
                                    );
                                  }
                                });
                              },
                              tooltip:
                                  wishlistService.isItemInWishlist(
                                        service['title'],
                                      )
                                      ? 'Remove from Wishlist'
                                      : 'Add to Wishlist',
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => BookNowPage(
                                          // Pass item info to BookNowPage using named parameters
                                          serviceTitle: service['title'],
                                          serviceImage: service['imageUrl'],
                                          servicePrice:
                                              service['price'].toString(),
                                          serviceRating:
                                              service['rating'].toString(),
                                        ),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 0,
                                ),
                              ),
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSubCategoryItem(BuildContext context, Map<String, dynamic> sub) {
  Widget? targetPage;
  if (sub['title'] == 'Telegram Marketing') {
    targetPage = TelegramMarketing();
  }
  if (sub['title'] == 'Spotify Marketing') {
    targetPage = SpotifyMarketing();
  }
  if (sub['title'] == 'SoundCloud Marketing') {
    targetPage = SoundCloudMarketing();
  }
  if (sub['title'] == 'LinkedIn Marketing') {
    targetPage = LinkedInMarketing();
  }
  if (sub['title'] == 'Discord Marketing') {
    targetPage = DiscordMarketing();
  }
  if (sub['title'] == 'Twitch Marketing') {
    targetPage = TwitchMarketing();
  }
  if (sub['title'] == 'Rumble Marketing') {
    targetPage = RumbleMarketing();
  }
  if (sub['title'] == 'Kick Marketing') {
    targetPage = KickMarketing();
  }
  if (sub['title'] == 'Club House Marketing') {
    targetPage = ClubHouseMarketing();
  }
  //
  if (sub['title'] == 'SnapChat Marketing') {
    targetPage = SnapchatMarketing();
  }
  if (sub['title'] == 'Trovo Marketing') {
    targetPage = TrovoMarketing();
  }
  if (sub['title'] == 'Reddit Marketing') {
    targetPage = RedditMarketing();
  }
  if (sub['title'] == 'Website Traffic Marketing') {
    targetPage = WebsiteTraficMarketing();
  }
  if (sub['title'] == 'Tiktok Marketing') {
    targetPage = TiktokMarketing();
  }
  if (sub['title'] == 'YouTube Marketing') {
    targetPage = YoutubeMarketing();
  }
  if (sub['title'] == 'Facebook Marketing') {
    targetPage = FacebookMarketing();
  }
  if (sub['title'] == 'Apple Music Marketing') {
    targetPage = AppleMusicMarketing();
  }
  if (sub['title'] == 'Instagram Marketing') {
    targetPage = InstagramMarketing();
  }

  return GestureDetector(
    onTap:
        targetPage != null
            ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => targetPage!),
              );
            }
            : null,
    child: Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(sub['image']),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            sub['title'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Ubuntu',
              color: AppColors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

// }
// }
