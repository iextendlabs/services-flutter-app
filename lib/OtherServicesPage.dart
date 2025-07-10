import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lipslay_flutter_frontend/ItemView.dart';
import 'package:lipslay_flutter_frontend/book_nowPage.dart';
import 'package:lipslay_flutter_frontend/constants/api_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OtherServicesPage extends StatefulWidget {
  const OtherServicesPage({super.key});

  @override
  State<OtherServicesPage> createState() => _OtherServicesPageState();
}

class _OtherServicesPageState extends State<OtherServicesPage> {
  String _searchText = '';
  Offset _fabPosition = const Offset(0, 0);

  List<dynamic> _services = [];
  bool _loading = true;
  String? _error;
  String? _title;
  String? _description;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateFabPosition();
    });
    _fetchOtherServices();
  }

  Future<void> _fetchOtherServices() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/category?category=other-services'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _title = data['title'] ?? 'Other Services';
          _description = data['description'] ?? '';
          _imageUrl = data['image'];
          _services = data['services'] ?? [];
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load data';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load data';
        _loading = false;
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
    final filteredServices =
        _services.where((f) {
          return (f['name'] ?? f['title'] ?? '')
              .toString()
              .toLowerCase()
              .contains(_searchText.toLowerCase());
        }).toList();

    return Scaffold(
      backgroundColor: AppColors.primarypageWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primarypageWhite,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _title ?? "Other Services",
          style: const TextStyle(
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
              // if (_imageUrl != null && _imageUrl!.isNotEmpty)
              //   Padding(
              //     padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
              //     child: Stack(
              //       children: [
              //         Container(
              //           width: double.infinity,
              //           height: 180,
              //           decoration: BoxDecoration(
              //             borderRadius: const BorderRadius.only(
              //               bottomLeft: Radius.circular(32),
              //               bottomRight: Radius.circular(32),
              //             ),
              //             image: DecorationImage(
              //               image: NetworkImage(_imageUrl!),
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           child: Container(
              //             decoration: BoxDecoration(
              //               borderRadius: const BorderRadius.only(
              //                 bottomLeft: Radius.circular(32),
              //                 bottomRight: Radius.circular(32),
              //               ),
              //               color: Colors.black.withOpacity(0.18),
              //             ),
              //           ),
              //         ),
              //         Positioned(
              //           left: 24,
              //           bottom: 18,
              //           child: Text(
              //             _title ?? '',
              //             style: const TextStyle(
              //               color: Colors.white,
              //               fontSize: 28,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: 'Ubuntu',
              //               shadows: [
              //                 Shadow(
              //                   color: Colors.black54,
              //                   offset: Offset(0, 2),
              //                   blurRadius: 8,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              if (_description != null && _description!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
                  child: Text(
                    _description!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.black87,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
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
                      hintText: 'Search Services',
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
              const SizedBox(height: 16),
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
                        : filteredServices.isEmpty
                        ? const Center(
                          child: Text(
                            'No services available at the moment.',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 16,
                            ),
                          ),
                        )
                        : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: filteredServices.length,
                          itemBuilder: (context, index) {
                            final service = filteredServices[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ItemView(
                                          title:
                                              service['name'] ??
                                              service['title'] ??
                                              '',
                                          description:
                                              service['description'] ??
                                              'No description available.',
                                          imageUrl: service['image'] ?? '',
                                          price:
                                              service['price']?.toString() ??
                                              '',
                                          whatsappNumber:
                                              service['whatsapp'] ?? '',
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
                                        child:
                                            (service['image'] != null &&
                                                    service['image']
                                                        .toString()
                                                        .isNotEmpty)
                                                ? (service['image']
                                                        .toString()
                                                        .startsWith('http')
                                                    ? Image.network(
                                                      service['image'],
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) => Container(
                                                            width: 80,
                                                            height: 80,
                                                            color:
                                                                AppColors
                                                                    .grey200,
                                                            child: const Icon(
                                                              Icons
                                                                  .broken_image,
                                                              color:
                                                                  AppColors
                                                                      .grey,
                                                            ),
                                                          ),
                                                    )
                                                    : Image.asset(
                                                      service['image'],
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                    ))
                                                : Container(
                                                  width: 80,
                                                  height: 80,
                                                  color: AppColors.grey200,
                                                  child: const Icon(
                                                    Icons.image,
                                                    color: AppColors.grey,
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
                                              service['name'] ??
                                                  service['title'] ??
                                                  '',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: AppColors.black,
                                                fontFamily: 'Ubuntu',
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            if ((service['rating'] ?? 0) > 0)
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
                                                service['price'] != null &&
                                                        service['price']
                                                            .toString()
                                                            .isNotEmpty
                                                    ? 'AED ${service['price']}'
                                                    : '',
                                                style: const TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
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
                                                    'Added ${service['name'] ?? service['title']} to wishlist!',
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) => BookNowPage(
                                                        serviceTitle:
                                                            service['name'] ??
                                                            service['title'] ??
                                                            '',
                                                        serviceImage:
                                                            service['image'] ??
                                                            '',
                                                        servicePrice:
                                                            service['price']
                                                                ?.toString() ??
                                                            '',
                                                        serviceRating:
                                                            service['rating']
                                                                ?.toString() ??
                                                            '',
                                                      ),
                                                ),
                                              );
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
                                            child: const Text(
                                              'Login to Quote',
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
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
          // Draggable Floating Action Buttons
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
