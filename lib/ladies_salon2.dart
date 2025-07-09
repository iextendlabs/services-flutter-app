import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/BleachThreadingPage.dart';
import 'package:lipslay_flutter_frontend/FacialPage.dart';
import 'package:lipslay_flutter_frontend/HairPage.dart';
import 'package:lipslay_flutter_frontend/MASSAGES.dart';
import 'package:lipslay_flutter_frontend/MakeupPage.dart';
import 'package:lipslay_flutter_frontend/ManicurePedicurePage.dart';
import 'package:lipslay_flutter_frontend/WaxingPage.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lipslay_flutter_frontend/ItemView.dart';
import 'package:lipslay_flutter_frontend/book_nowPage.dart';
import 'package:lipslay_flutter_frontend/login2page.dart';
import 'package:lipslay_flutter_frontend/request_quote_page.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lipslay_flutter_frontend/NailArtPage.dart';
import 'package:lipslay_flutter_frontend/AcrylicsNailsPage.dart';
import 'package:lipslay_flutter_frontend/FrenchTipAcrylicsNalisPage.dart';

class LadiesSalonPage extends StatefulWidget {
  const LadiesSalonPage({super.key});

  @override
  State<LadiesSalonPage> createState() => _LadiesSalonPageState();
}

class _LadiesSalonPageState extends State<LadiesSalonPage> {
  String _searchText = '';
  Offset _fabPosition = const Offset(0, 0);

  List<dynamic> _services = [];
  List<dynamic> _subcategories = [];
  String? _selectedSubcategory;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateFabPosition();
    });
    _fetchLadiesSalonServices();
  }

  Future<void> _fetchLadiesSalonServices() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final box = await Hive.openBox('LadiesSalonServices');
    final cacheKey = 'LadiesSalon_services';

    // Try to load from cache first
    final cached = box.get(cacheKey);
    if (cached != null) {
      try {
        final data = json.decode(cached);
        setState(() {
          _services = data['services'] ?? [];
          _subcategories = data['subcategories'] ?? [];
          _loading = false;
        });
      } catch (_) {}
    }

    // Always try to fetch fresh data
    try {
      final response = await http.get(
        Uri.parse('https://wishlist.lipslay.com/api/category?category=ladies-salon'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _services = data['services'] ?? [];
          _subcategories = data['subcategories'] ?? [];
          _loading = false;
        });
        box.put(cacheKey, json.encode(data));
      } else {
        setState(() {
          _loading = false;
          _error = 'Failed to load data';
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Failed to load data';
      });
    }
  }

  void _updateFabPosition() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fabGroupHeight = 56.0 + 10.0 + 50.0;
    final fabGroupWidth = 60.0;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final bottomNavBarHeight = kBottomNavigationBarHeight;
    final initialFabX = screenWidth - fabGroupWidth - 20;
    final initialFabY =
        screenHeight -
        safeAreaBottom -
        bottomNavBarHeight -
        fabGroupHeight -
        20;
    setState(() {
      _fabPosition = Offset(initialFabX, initialFabY);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredLadiesSalon =
        _services.where((f) {
          final matchesSearch = (f['name'] ?? '')
              .toString()
              .toLowerCase()
              .contains(_searchText.toLowerCase());
          final matchesSubcat =
              _selectedSubcategory == null ||
              f['subcategory'] == _selectedSubcategory;
          return matchesSearch && matchesSubcat;
        }).toList();

    return Scaffold(
      backgroundColor: AppColors.primarypageWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primarypageWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "LadiesSalon",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                      hintText: 'Search LadiesSalon',
                      hintStyle: TextStyle(
                        color: AppColors.black,
                        fontFamily: 'Ubuntu',
                      ),
                      prefixIcon: Icon(Icons.search, color: AppColors.black),
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
              if (_subcategories.isNotEmpty)
                Container(
                  height:
                      (_subcategories.length / 2).ceil() *
                      90.0, // Increased height for 2 per row
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 2.8, // Wide cards
                        ),
                    itemCount: _subcategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, idx) {
                      final subcat = _subcategories[idx];
                      final subcatName = subcat['title'] ?? ''; // <-- use title
                      final subcatImage = subcat['image'] ?? '';
                      return GestureDetector(
                        onTap: () {
                          final normalized =
                              subcatName
                                  .replaceAll(RegExp(r'[\s\-&]+'), '')
                                  .toLowerCase();
                          final builder = categoryPageBuilders[normalized];
                          if (builder != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => builder(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No page found for $subcatName'),
                              ),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.grey.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child:
                                    subcatImage.isNotEmpty
                                        ? Image.network(
                                          subcatImage,
                                          width: 48,
                                          height: 48,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                                    width: 48,
                                                    height: 48,
                                                    color: AppColors.grey200,
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                      color: AppColors.grey,
                                                      size: 24,
                                                    ),
                                                  ),
                                        )
                                        : Container(
                                          width: 48,
                                          height: 48,
                                          color: AppColors.grey200,
                                          child: const Icon(
                                            Icons.image,
                                            color: AppColors.grey,
                                            size: 24,
                                          ),
                                        ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  subcatName,
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    fontFamily: 'Ubuntu',
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 8),
              Expanded(
                child:
                    _loading
                        ? const Center(child: CircularProgressIndicator())
                        : _error != null
                        ? Center(
                          child: Text(
                            _error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                        : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: filteredLadiesSalon.length,
                          itemBuilder: (context, index) {
                            final service = filteredLadiesSalon[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ItemView(
                                          title: service['name'] ?? '',
                                          description:
                                              service['description'] ??
                                              'No description available.',
                                          imageUrl: service['image'] ?? '',
                                          whatsappNumber:
                                              '', // If you have whatsapp, pass here
                                          price: service['price'] ?? '',
                                          duration: service['duration'] ?? '',
                                          features: service['features'] ?? [],
                                          slug: service['slug'] ?? '',
                                        ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.grey.withOpacity(0.10),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Image.network(
                                          service['image'] ?? '',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    color: AppColors.grey200,
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                      color: AppColors.grey,
                                                    ),
                                                  ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              service['name'] ?? '',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: AppColors.black,
                                                fontFamily: 'Ubuntu',
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            if (service['rating'] != null)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 2.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      service['rating']
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: AppColors.black,
                                                        fontSize: 13,
                                                        fontFamily: 'Ubuntu',
                                                      ),
                                                    ),
                                                    const SizedBox(width: 2),
                                                    const Icon(
                                                      Icons.star,
                                                      color: AppColors.amber,
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 2.0,
                                              ),
                                              child: Text(
                                                service['price'] ?? '',
                                                style: const TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Ubuntu',
                                                ),
                                              ),
                                            ),
                                            if (service['duration'] != null)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 2.0,
                                                ),
                                                child: Text(
                                                  service['duration'],
                                                  style: const TextStyle(
                                                    color: AppColors.grey,
                                                    fontSize: 13,
                                                    fontFamily: 'Ubuntu',
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.favorite_border,
                                              color: AppColors.accentColor,
                                              size: 22,
                                            ),
                                            onPressed: () {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Added ${service['name']} to wishlist!',
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          OutlinedButton(
                                            onPressed: () async {
                                              final userBox =
                                                  await Hive.openBox('userBox');
                                              final token = userBox.get(
                                                'customer_token',
                                              );
                                              if (token == null ||
                                                  token.isEmpty) {
                                                // Not logged in, go to login page
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            const Login2Page(),
                                                  ),
                                                );
                                              } else {
                                                // Logged in, go to RequestQuotePage
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (
                                                          context,
                                                        ) => RequestQuotePage(
                                                          initialServiceName:
                                                              service['name'],
                                                          initialServiceImage:
                                                              service['image'],
                                                        ),
                                                  ),
                                                );
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                color: AppColors.grey
                                                    .withOpacity(0.4),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 0,
                                                  ),
                                              minimumSize: const Size(0, 32),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            child: FutureBuilder(
                                              future: Hive.openBox('userBox'),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  final userBox = Hive.box(
                                                    'userBox',
                                                  );
                                                  final token = userBox.get(
                                                    'customer_token',
                                                  );
                                                  return Text(
                                                    (token == null ||
                                                            token.isEmpty)
                                                        ? 'Login to Quote'
                                                        : 'Quote',
                                                    style: const TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      fontFamily: 'Ubuntu',
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox.shrink();
                                                }
                                              },
                                            ),
                                          ),
                                          // OutlinedButton(
                                          //   onPressed: () {
                                          //     Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //         builder: (context) => BookNowPage(
                                          //           serviceTitle: service['name'],
                                          //           serviceImage: service['image'],
                                          //           servicePrice: service['price'] ?? '',
                                          //           serviceRating: service['rating']?.toString() ?? '',
                                          //         ),
                                          //       ),
                                          //     );
                                          //   },
                                          //   style: OutlinedButton.styleFrom(
                                          //     side: BorderSide(
                                          //       color: AppColors.grey.withOpacity(0.4),
                                          //     ),
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius: BorderRadius.circular(20),
                                          //     ),
                                          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                          //     minimumSize: const Size(0, 32),
                                          //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          //   ),
                                          //   child: const Text(
                                          //     'Book Now',
                                          //     style: TextStyle(
                                          //       color: AppColors.black,
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 13,
                                          //       fontFamily: 'Ubuntu',
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
          // Draggable Floating Action Buttons (unchanged)
          Positioned(
            left: _fabPosition.dx,
            top: _fabPosition.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final screenHeight = MediaQuery.of(context).size.height;
                  final safeAreaTop = MediaQuery.of(context).padding.top;
                  final safeAreaBottom = MediaQuery.of(context).padding.bottom;
                  final fabGroupHeight = 56.0 + 10.0 + 50.0;
                  final fabGroupWidth = 60.0;
                  final minX = 0.0;
                  final maxX = screenWidth - fabGroupWidth;
                  final minAppbarY =
                      AppBar().preferredSize.height + safeAreaTop;
                  final maxBottomNavY =
                      screenHeight -
                      safeAreaBottom -
                      fabGroupHeight -
                      kBottomNavigationBarHeight -
                      10;
                  double newDx = _fabPosition.dx + details.delta.dx;
                  double newDy = _fabPosition.dy + details.delta.dy;
                  newDx = newDx.clamp(minX, maxX);
                  newDy = newDy.clamp(minAppbarY, maxBottomNavY);
                  _fabPosition = Offset(newDx, newDy);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Add the mapping for subcategory navigation
final Map<String, Widget Function()> categoryPageBuilders = {
  'bleachthreading': () => const BleachThreadingPage(),
  'facial': () => const FacialPage(),
  'makeup': () => const MakeupPage(),
  'manicurepedicure': () => const ManicurePedicurePage(),
  'massages': () => const MASSAGESPage(),
  'waxing': () => const WaxingPage(),
  'hair': () => const HairPage(),

  // Add more mappings as needed
};
