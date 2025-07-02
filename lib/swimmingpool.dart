import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/CleaningPage.dart';
import 'package:lipslay_flutter_frontend/ItemView.dart';
import 'package:lipslay_flutter_frontend/cart_service.dart';
import 'package:lipslay_flutter_frontend/club.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/discord.dart';
import 'package:lipslay_flutter_frontend/dosing.dart';
import 'package:lipslay_flutter_frontend/filtration.dart';
import 'package:lipslay_flutter_frontend/kick.dart';
import 'package:lipslay_flutter_frontend/linkedin.dart';
import 'package:lipslay_flutter_frontend/pump.dart';
import 'package:lipslay_flutter_frontend/rumble.dart';
import 'package:lipslay_flutter_frontend/snapchat.dart';
import 'package:lipslay_flutter_frontend/soundcloud.dart';
import 'package:lipslay_flutter_frontend/spotify.dart';
import 'package:lipslay_flutter_frontend/swimingcleaning.dart';
import 'package:lipslay_flutter_frontend/telegrammarketing.dart';
import 'package:lipslay_flutter_frontend/twitch.dart';
import 'package:lipslay_flutter_frontend/wishlist_service.dart';

class SwimmingPool extends StatefulWidget {
  const SwimmingPool({super.key});

  @override
  State<SwimmingPool> createState() => _SwimmingPoolState();
}

class _SwimmingPoolState extends State<SwimmingPool> {
  String _searchText = '';
  // final Set<int> _wishlist = {};

  final List<Map<String, dynamic>> subCategories = [
    {'image': 'assets/images/filtration.png', 'title': 'Filtration Equipments'},
    {'image': 'assets/images/dosing.png', 'title': 'Dosing Equipment\'s'},
    {'image': 'assets/images/cleaning.png', 'title': 'Cleaning Equipments'},
    {'image': 'assets/images/pumps.png', 'title': 'Pump & Counter current'},
  ];

  // final List<Map<String, dynamic>> gentsServices = const [
  //   {
  //     'imageUrl': 'assets/images/image2.png',
  //     'title': 'Haircut',
  //     'rating': 4.5,
  //     'price': 15,
  //   },
  //   {
  //     'imageUrl': 'assets/images/image4.png',
  //     'title': 'Beautyaddonrd Trim',
  //     'rating': 4.2,
  //     'price': 20,
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    final filteredSubCategories =
        subCategories.where((sub) {
          return sub['title'].toString().toLowerCase().contains(
            _searchText.toLowerCase(),
          );
        }).toList();
    // final filteredServices =
    //     gentsServices
    //         .where(
    //           (service) => service['title'].toString().toLowerCase().contains(
    //             _searchText.toLowerCase(),
    //           ),
    //         )
    //         .toList();

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
              // ListView.separated(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 16,
              //     horizontal: 12,
              //   ),
              // itemCount: filteredServices.length,
              // separatorBuilder: (_, __) => const SizedBox(height: 16),
              // itemBuilder: (context, index) {
              //   final service = filteredServices[index];
              //   final isWishlisted = _wishlist.contains(
              //     gentsServices.indexOf(service),
              //   );
              // return Container(
              //   decoration: BoxDecoration(
              //     color: AppColors.primarypageWhite,
              //     borderRadius: BorderRadius.circular(16),
              //     boxShadow: [
              //       BoxShadow(
              //         color: AppColors.grey.withOpacity(0.08),
              //         blurRadius: 8,
              //         offset: const Offset(0, 2),
              //       ),
              //     ],
              //   ),
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 8,
              //     horizontal: 8,
              //   ),
              //   child: Row(
              //     children: [
              //       // Wrap image + text area in GestureDetector
              //       Expanded(
              //         child: GestureDetector(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder:
              //                     (context) => ItemView(
              //                       title: service['title'],
              //                       description:
              //                           'Service details for ${service['title']}', // Replace with actual description if available
              //                       imageUrl: service['imageUrl'],
              //                     ),
              //               ),
              //             );
              //           },
              //           child: Row(
              //             children: [
              //               ClipRRect(
              //                 borderRadius: BorderRadius.circular(12),
              //                 child: Image.asset(
              //                   service['imageUrl'],
              //                   width: 56,
              //                   height: 56,
              //                   fit: BoxFit.cover,
              //                 ),
              //               ),
              //               const SizedBox(width: 14),
              //               // Text area
              //               Expanded(
              //                 child: Column(
              //                   crossAxisAlignment:
              //                       CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       service['title'],
              //                       style: const TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 16,
              //                         color: AppColors.black,
              //                         fontFamily: 'Ubuntu',
              //                       ),
              //                     ),
              //                     const SizedBox(height: 4),
              //                     Row(
              //                       children: [
              //                         Text(
              //                           service['rating'].toString(),
              //                           style: const TextStyle(
              //                             color: AppColors.black,
              //                             fontSize: 13,
              //                             fontFamily: 'Ubuntu',
              //                           ),
              //                         ),
              //                         const SizedBox(width: 2),
              //                         const Icon(
              //                           Icons.star,
              //                           color: AppColors.red,
              //                           size: 16,
              //                         ),
              //                       ],
              //                     ),
              //                     const SizedBox(height: 2),
              //                     Text(
              //                       'AED ${service['price']}',
              //                       style: const TextStyle(
              //                         color: AppColors.black,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w500,
              //                         fontFamily: 'Ubuntu',
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       // Wishlist and Add to Cart column
              //       Column(
              //         children: [
              //           IconButton(
              //             icon: Icon(
              //               wishlistService.isItemInWishlist(
              //                     service['title'],
              //                   )
              //                   ? Icons.favorite
              //                   : Icons.favorite_border,
              //               color: AppColors.accentColor,
              //               size: 20,
              //             ),
              //             onPressed: () {
              //               setState(() {
              //                 final itemId = service['title'];
              //                 if (wishlistService.isItemInWishlist(
              //                   itemId,
              //                 )) {
              //                   wishlistService.removeItem(itemId);
              //                   ScaffoldMessenger.of(context).showSnackBar(
              //                     SnackBar(
              //                       content: Text(
              //                         '${service['title']} removed from wishlist',
              //                       ),
              //                     ),
              //                   );
              //                 } else {
              //                   wishlistService.addItem(
              //                     WishlistItem(
              //                       id: itemId,
              //                       imagePath: service['imageUrl'],
              //                       title: service['title'],
              //                       price: 'AED ${service['price']}',
              //                     ),
              //                   );
              //                   ScaffoldMessenger.of(context).showSnackBar(
              //                     SnackBar(
              //                       content: Text(
              //                         '${service['title']} added to wishlist',
              //                       ),
              //                     ),
              //                   );
              //                 }
              //               });
              //             },
              //             tooltip:
              //                 wishlistService.isItemInWishlist(
              //                       service['title'],
              //                     )
              //                     ? 'Remove from Wishlist'
              //                     : 'Add to Wishlist',
              //           ),
              //           OutlinedButton(
              //             onPressed: () {
              //               cartService.addToCart(
              //                 CartItem(
              //                   id: service['title'],
              //                   name: service['title'],
              //                   imageUrl: service['imageUrl'],
              //                   price: 'AED ${service['price']}',
              //                 ),
              //               );
              //               ScaffoldMessenger.of(context).showSnackBar(
              //                 SnackBar(
              //                   content: Text(
              //                     '${service['title']} added to cart',
              //                   ),
              //                 ),
              //               );
              //             },
              //             style: OutlinedButton.styleFrom(
              //               side: BorderSide(color: AppColors.grey),
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(20),
              //               ),
              //               padding: const EdgeInsets.symmetric(
              //                 horizontal: 18,
              //                 vertical: 0,
              //               ),
              //             ),
              //             child: const Text(
              //               'Add to Cart',
              //               style: TextStyle(
              //                 color: AppColors.black,
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 13,
              //                 fontFamily: 'Ubuntu',
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // );
              // },
              // ),
              // ),
            ],
            // ),
          ),
        ),
      ),
    );
  }
}
// class _SwimmingPoolState extends State<SwimmingPool> {
// ... (existing code)

Widget _buildSubCategoryItem(BuildContext context, Map<String, dynamic> sub) {
  Widget? targetPage;
  if (sub['title'] == 'Filtration Equipments') {
    targetPage = FiltrationEquipments();
  }
  if (sub['title'] == 'Dosing Equipment\'s') {
    targetPage = DosingEquipments();
  }
  if (sub['title'] == 'Cleaning Equipments') {
    targetPage = SwimmingCleaning();
  }
  if (sub['title'] == 'Pump & Counter current') {
    targetPage = PumpAndCounterCurrent();
  }

  //Add more navigation logic as needed

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
