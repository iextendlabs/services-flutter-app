import 'dart:async';
import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/BeautyAddonPage.dart';
import 'package:lipslay_flutter_frontend/HennaPage.dart';
import 'package:lipslay_flutter_frontend/NailsPage.dart';
import 'package:lipslay_flutter_frontend/NewOfferPage.dart';
import 'package:lipslay_flutter_frontend/OtherServicesPage.dart';
import 'package:lipslay_flutter_frontend/PackagePage.dart';
import 'package:lipslay_flutter_frontend/PlumberServicePage.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/gents_salon.dart';
import 'package:lipslay_flutter_frontend/ladies_salon2.dart';
import 'package:lipslay_flutter_frontend/not-needed/EarningCoursesPage.dart';
import 'package:lipslay_flutter_frontend/not-needed/consultant.dart';
import 'package:lipslay_flutter_frontend/not-needed/education.dart';
import 'package:lipslay_flutter_frontend/not-needed/freelancerspage.dart';
import 'package:lipslay_flutter_frontend/not-needed/itsolutionpage.dart';
import 'package:lipslay_flutter_frontend/not-needed/lpg_gas.dart';
import 'package:lipslay_flutter_frontend/not-needed/subscriptionspage.dart';
import 'package:lipslay_flutter_frontend/not-needed/swimmingpool.dart';
import 'package:lipslay_flutter_frontend/not-needed/travel_event.dart';
import 'package:lipslay_flutter_frontend/not-needed/wholesale.dart';
import 'package:lipslay_flutter_frontend/not-needed/wholesale_salon_products.dart';
import 'package:lipslay_flutter_frontend/notificationpage.dart';
import 'package:lipslay_flutter_frontend/not-needed/services.dart';
import 'package:lipslay_flutter_frontend/MASSAGES.dart';
import 'package:lipslay_flutter_frontend/staffProfilePage.dart';
import 'package:lipslay_flutter_frontend/wishlist_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lipslay_flutter_frontend/chatbot_page.dart';
// import 'package:lipslay_flutter_frontend/ladies_salon.dart'; // Import the Ladies Salon page (which is SearchPageUI)
import 'package:lipslay_flutter_frontend/memberpage.dart';
import 'package:http/http.dart' as http;
import 'package:lipslay_flutter_frontend/constants/api_constants.dart';
import 'package:lipslay_flutter_frontend/ItemView.dart';

class Ad {
  final String title;
  final String details;
  final String imageUrl;

  Ad({required this.title, required this.details, required this.imageUrl});
}

class SalonService {
  final String title;
  final String details;
  final String imageUrl;

  SalonService({
    required this.title,
    required this.details,
    required this.imageUrl,
  });
}

class Brand {
  final String name;
  final String imageUrl;

  Brand({required this.name, required this.imageUrl});
}

class ListItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? buttonText;

  ListItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.buttonText,
  });
}

class Offer {
  final String title;
  final String details;
  final String imageUrl;

  Offer({required this.title, required this.details, required this.imageUrl});
}

class Member {
  final String name;
  final String benefits;
  final String imageUrl;
  final String? buttonText;

  Member({
    required this.name,
    required this.benefits,
    required this.imageUrl,
    this.buttonText,
  });
}

class ServiceCategory {
  final String title;
  final String imageUrl;

  ServiceCategory({required this.title, required this.imageUrl});
}

class ApiCategory {
  final int id;
  final String title;
  final String imageUrl;

  ApiCategory({required this.id, required this.title, required this.imageUrl});

  factory ApiCategory.fromJson(Map<String, dynamic> json) {
    return ApiCategory(
      id: json['id'],
      title: json['title'] ?? '',
      imageUrl: json['image'] ?? '',
    );
  }
}

class FeaturedService {
  final String name;
  final String slug;
  final List<FeaturedServiceItem> services;

  FeaturedService({
    required this.name,
    required this.slug,
    required this.services,
  });

  factory FeaturedService.fromJson(Map<String, dynamic> json) {
    return FeaturedService(
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      services:
          (json['services'] as List<dynamic>? ?? [])
              .map((e) => FeaturedServiceItem.fromJson(e))
              .toList(),
    );
  }
}

class FeaturedServiceItem {
  final dynamic id;
  final String name;
  final String price;
  final String? rating;
  final String image;
  final String description;
  final String? duration;
  final String slug;

  FeaturedServiceItem({
    required this.id,
    required this.name,
    required this.price,
    this.rating,
    required this.image,
    required this.description,
    this.duration,
    required this.slug,
  });

  factory FeaturedServiceItem.fromJson(Map<String, dynamic> json) {
    return FeaturedServiceItem(
      id: json['id'],
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      rating: json['rating']?.toString(),
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'],
      slug: json['slug'] ?? '',
    );
  }
}

class HomeTabContent extends StatefulWidget {
  const HomeTabContent({super.key});

  @override
  State<HomeTabContent> createState() => _HomeTabContentState();
}

class _HomeTabContentState extends State<HomeTabContent> {
  List<Map<String, String>> apiFaqs = [];
  bool showAllFaqs = false;
  final String defaultImagePath = 'assets/images/gents_salon.png';

  final List<Ad> advertisements = [
    Ad(
      title: 'Ad 1',
      details: 'Details about Ad 1',
      imageUrl: 'assets/images/image2.png',
    ),
    Ad(
      title: 'Ad 2',
      details: 'Details about Ad 2',
      imageUrl: 'assets/images/image4.png',
    ),
  ];

  final List<ServiceCategory> ladiesSalonCategories = [
    ServiceCategory(
      title: 'Ladies Salon',
      imageUrl: 'assets/images/ladies_salon.png',
    ),
    ServiceCategory(
      title: 'Gents Salon',
      imageUrl: 'assets/images/gents_salon.png',
    ),
    ServiceCategory(title: 'SPA', imageUrl: 'assets/images/spa.png'),
    ServiceCategory(
      title: 'Consultant',
      imageUrl: 'assets/images/consultant.png',
    ),
    ServiceCategory(
      title: 'Wholesale Salon Products',
      imageUrl: 'assets/images/wholesale.png',
    ),
    ServiceCategory(title: 'Services', imageUrl: 'assets/images/services.png'),
    ServiceCategory(
      title: 'Travel-Event',
      imageUrl: 'assets/images/entertainment.png',
    ),
    ServiceCategory(
      title: 'Freelancers',
      imageUrl: 'assets/images/freelancers.png',
    ),
    ServiceCategory(
      title: 'Earning Courses',
      imageUrl: 'assets/images/earning_courses.png',
    ),
    ServiceCategory(
      title: 'Wholesale',
      imageUrl: 'assets/images/wholesale.png',
    ),
    ServiceCategory(
      title: 'IT Solution',
      imageUrl: 'assets/images/it_solution.png',
    ),
    ServiceCategory(
      title: 'LPG gas cylinder',
      imageUrl: 'assets/images/lpg_gas.png',
    ),
    ServiceCategory(
      title: 'Subcriptions',
      imageUrl: 'assets/images/subscriptions.png',
    ),
    ServiceCategory(
      title: 'Education',
      imageUrl: 'assets/images/earningcourses.png',
    ),
    ServiceCategory(
      title: 'Swimming Pool',
      imageUrl: 'assets/images/swimmingpool.png',
    ),
  ];

  final List<SalonService> ladiesSalonServices = [
    SalonService(
      title: 'Ladies Salon Service 1',
      details: 'Details about Service 1',
      imageUrl: 'assets/images/image2.png',
    ),
    SalonService(
      title: 'Ladies Salon Service 2',
      details: 'Details about Service 2',
      imageUrl: 'assets/images/image4.png',
    ),
  ];

  final List<SalonService> gentsSalonServices = [
    SalonService(
      title: 'Gents Salon Service 1',
      details: 'Details about Service 1',
      imageUrl: 'assets/images/makeup.png',
    ),
    SalonService(
      title: 'Gents Salon Service 2',
      details: 'Details about Service 2',
      imageUrl: 'assets/images/waxing.png',
    ),
  ];

  final List<Brand> brands = [
    Brand(name: 'Brand 1', imageUrl: 'assets/images/nails.png'),
    Brand(name: 'Brand 2', imageUrl: 'assets/images/nails.png'),
    Brand(name: 'Brand 3', imageUrl: 'assets/images/profile_pic.webp'),
    Brand(name: 'Brand 4', imageUrl: 'assets/images/henna.png'),
    Brand(name: 'Brand 5', imageUrl: 'assets/images/house_maid.png'),
    Brand(name: 'Brand 6', imageUrl: 'assets/images/nails.png'),
    Brand(name: 'Brand 7', imageUrl: 'assets/images/nails.png'),
    Brand(name: 'Brand 8', imageUrl: 'assets/images/profile_pic.webp'),
    Brand(name: 'Brand 9', imageUrl: 'assets/images/henna.png'),
    Brand(name: 'Brand 10', imageUrl: 'assets/images/house_maid.png'),
  ];

  final ListItem installmentPlan = ListItem(
    title: 'Installment Plan',
    subtitle:
        'Spread the cost of your spa treatments with our flexible installment plans.',
    imageUrl: 'assets/images/image4.png',
    buttonText: 'Learn More',
  );

  final ListItem itSupport = ListItem(
    title: 'IT Support',
    subtitle: 'Get IT solutions for your spa business.',
    imageUrl: 'assets/images/image2.png',
    buttonText: 'Explore',
  );

  final ListItem businessLoans = ListItem(
    title: 'Business Loans',
    subtitle: 'Explore loan options to grow your spa business.',
    imageUrl: 'assets/images/image2.png',
    buttonText: 'Apply Now',
  );

  final ListItem earningPotential = ListItem(
    title: 'Earning Potential',
    subtitle: 'Discover how you can earn up to 400,000 AED.',
    imageUrl: 'assets/images/image2.png',
    buttonText: 'Learn More',
  );

  final ListItem spaChannel = ListItem(
    title: 'Spa Channel',
    subtitle: 'Watch our sponsored YouTube channel for spa tips and more.',
    imageUrl: 'assets/images/image2.png',
    buttonText: 'Watch Now',
  );

  final List<Offer> currentOffers = [
    Offer(
      title: 'Offer 1',
      details: 'Details about Offer 1',
      imageUrl: 'assets/images/image2.png',
    ),
    Offer(
      title: 'Offer 2',
      details: 'Details about Offer 2',
      imageUrl: 'assets/images/image2.png',
    ),
  ];

  final Member membershipBenefits = Member(
    name: 'Membership Benefits',
    benefits: 'Exclusive benefits for our spa members.',
    imageUrl: 'assets/images/image2.png',
    buttonText: 'Our Members',
  );

  List<Map<String, dynamic>> staffMembers = [];
  List<Map<String, dynamic>> testimonials = [];
  Map<String, dynamic> newsletter = {};
  Map<String, dynamic> appPromotion = {};

  @override
  void initState() {
    super.initState();
    fetchHomeData();
    fetchFaqs();
  }

  Future<void> fetchHomeData() async {
    final response = await http.get(Uri.parse('$baseUrl/api/home'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        staffMembers = List<Map<String, dynamic>>.from(
          data['staffMembers'] ?? [],
        );
        testimonials = List<Map<String, dynamic>>.from(
          data['testimonials'] ?? [],
        );
        newsletter = Map<String, dynamic>.from(data['newsletter'] ?? {});
        appPromotion = Map<String, dynamic>.from(data['appPromotion'] ?? {});
      });
    }
  }

  Future<void> fetchFaqs() async {
    final response = await http.get(Uri.parse('$baseUrl/api/faqs'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        apiFaqs =
            (data['faqs'] as List<dynamic>? ?? [])
                .map(
                  (e) => {
                    'question': (e['question'] ?? '').toString(),
                    'answer': (e['answer'] ?? '').toString(),
                  },
                )
                .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // HomePage now only returns its scrollable content, without a Scaffold
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildSectionTitle('Advertisements'),
              // _buildAdvertisementsList(advertisements),
              // const SizedBox(height: 16),

              // NEW SECTION: Ladies Salon Categories (Grid View)
              _buildSectionTitle(
                'Our Services', // Title as seen in image_2025-06-04_145630358.png
              ), // Title as seen in image_2025-06-04_145630358.png
              FutureBuilder<List<ApiCategory>>(
                future: fetchApiCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Failed to load categories'));
                  }
                  final categories = snapshot.data ?? [];
                  return _buildApiCategoriesGrid(categories);
                },
              ),
              const SizedBox(height: 16),

              // END NEW SECTION
              _buildSectionTitle('Featured Services'),
              FutureBuilder<List<FeaturedService>>(
                future: fetchFeaturedServices(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Failed to load featured services'),
                    );
                  }
                  final featured = snapshot.data ?? [];
                  return _buildFeaturedServicesList(featured);
                },
              ),
              const SizedBox(height: 16),

              // _buildSectionTitle('Gents\' Salon'),
              // _buildSalonServiceList(gentsSalonServices),
              // const SizedBox(height: 16),

              // _buildSectionTitle('Brands'),
              // _buildBrandGrid(brands),
              // const SizedBox(height: 16),

              // _buildSectionTitle('Buy Now Pay in Installments'),
              // _buildVerticalListItem(installmentPlan),
              // const SizedBox(height: 16),

              // _buildSectionTitle('IT Solutions'),
              // _buildVerticalListItem(itSupport),
              // const SizedBox(height: 16),

              // _buildSectionTitle('Loan Opportunities'),
              // _buildVerticalListItem(businessLoans),
              // const SizedBox(height: 16),

              // _buildSectionTitle('Earn Up to 400,000 AED'),
              // _buildVerticalListItem(earningPotential),
              // const SizedBox(height: 16),

              // _buildSectionTitle('YouTube Sponsored Channel'),
              // _buildVerticalListItem(spaChannel),
              // const SizedBox(height: 16),

              // _buildSectionTitle('Current Offers'),
              // _buildCurrentOffersList(currentOffers),
              // const SizedBox(height: 16),
              // _buildSectionTitle('Members'),
              // _buildVerticalListItem(
              //   ListItem(
              //     title: membershipBenefits.name,
              //     subtitle: membershipBenefits.benefits,
              //     imageUrl: membershipBenefits.imageUrl,
              //     buttonText: membershipBenefits.buttonText,
              //   ),
              // ),
              // const SizedBox(height: 20),

              // --- Team Section ---
              _buildTeamSection(),
              const SizedBox(height: 16),

              _buildViewAllButton(context, 'View All Staff'),
              const SizedBox(height: 16),

              // --- Testimonials Section ---
              _buildTestimonialsSection(),
              const SizedBox(height: 16),

              // --- Download App Section ---
              // _buildDownloadAppSection(),
              // const SizedBox(height: 16),

              // --- FAQ Section ---
              _buildFaqSection(),
              const SizedBox(height: 16),

              // --- Newsletter Section ---
              _buildNewsletterSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

  // --- Widget Builder Methods ---

  // Move this function to top-level so it can be used outside the class
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.black87,
        ),
      ),
    );
  }

  Widget _buildAdvertisementsList(List<Ad> ads) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: ads.length,
        itemBuilder: (context, index) {
          final ad = ads[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(ad.imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.black.withOpacity(0.2),
                  BlendMode.darken,
                ),
                onError:
                    (exception, stackTrace) =>
                        const Icon(Icons.error_outline, color: AppColors.white),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ad.title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    ad.details,
                    style: const TextStyle(
                      color: AppColors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Modified Widget Builder for Ladies Salon Categories Grid to match image_2025-06-04_145630358.png
  Widget _buildLadiesSalonCategoriesGrid(List<ServiceCategory> categories) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two columns
          childAspectRatio:
              2.8, // Adjusted to make cards wider and accommodate image+text in a row
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell(
            // Added InkWell for tap functionality and visual feedback
            onTap: () {
              log('Tapped on Ladies Salon Category: ${category.title}');
              // Conditional navigation based on category title

              if (category.title == 'Ladies Salon') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            LadiesSalonPage(), // Navigate to HomePage3 for Makeup
                  ),
                );
              }

              if (category.title == 'Gents Salon') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            GentsSalonPage(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }

              if (category.title == 'SPA') {
                // Default navigation for other categories, or remove if not needed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            MASSAGESPage(), // Or a generic category view page
                    // You might still want to pass the category title to the destination page:
                    // settings: RouteSettings(arguments: category.title),
                  ),
                );
              }
              if (category.title == 'Consultant') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ConsultantPage(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }
              if (category.title == 'Wholesale Salon Products') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            WholesaleSalonProductsPage(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }
              if (category.title == 'Services') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ServicesPage(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }
              if (category.title == 'Travel-Event') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            TravelEventPage(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }
              if (category.title == 'Freelancers') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            FreelancersPage(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }
              if (category.title == 'Earning Courses') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            EarningCoursesPage(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }
              if (category.title == 'Wholesale') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            WholesalePage(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }
              if (category.title == 'IT Solution') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ITSolutionPage(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }
              if (category.title == 'LPG gas cylinder') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            LpgGas(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }
              if (category.title == 'Subcriptions') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            SubscriptionsPage(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }
              if (category.title == 'Swimming Pool') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            SwimmingPool(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }
              if (category.title == 'Education') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            EducationPage(), // Navigate to LadiesSalon for Henna
                  ),
                );
              }
            },
            borderRadius: BorderRadius.circular(
              12.0,
            ), // Apply to InkWell for proper ripple effect
            child: Container(
              decoration: BoxDecoration(
                color:
                    AppColors
                        .grey200, // Background color as in image_2025-06-04_145630358.png
                borderRadius: BorderRadius.circular(12.0), // Rounded edges
              ),
              child: Row(
                // Use Row to place image and text side-by-side
                mainAxisAlignment:
                    MainAxisAlignment
                        .start, // Align content to the start (left)
                children: [
                  const SizedBox(width: 12), // Padding from the left edge
                  ClipRRect(
                    // Clip image to have rounded corners
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ), // Smaller rounded corners for the image itself
                    child: Container(
                      color:
                          AppColors
                              .transparent, // Background for the image circle
                      width: 50, // Adjust icon/image size as needed
                      height: 50,
                      child: Image.asset(
                        category.imageUrl,
                        fit:
                            BoxFit
                                .cover, // Use cover to fill the box while maintaining aspect ratio
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.error_outline),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12), // Spacing between image and text
                  Expanded(
                    // Use Expanded to allow text to take available space
                    child: Text(
                      category.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black87,
                      ),
                      maxLines: 2, // Allow text to wrap if long
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8), // Padding from the right edge
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper: Normalize category title for matching
  String normalizeCategoryTitle(String title) {
    return title.replaceAll(RegExp(r'[\s\-\&]+'), '').toLowerCase();
  }

  // Map normalized titles to pages
  final Map<String, Widget Function()> apiCategoryPageBuilders = {
    'beautyaddon': () => BeautyaddonPage(),
    'package': () => PackagePage(),
    'henna': () => HennaPage(),
    'nails': () => NailsPage(),
    'newoffer': () => NewOfferPage(),
    'otherservices': () => OtherServicesPage(),
    'gentssalon': () => GentsSalonPage(),
    'ladiessalon': () => LadiesSalonPage(),
    'plumberservice': () => PlumberServicePage(),
    // Add more mappings as needed
  };

  Widget _buildApiCategoriesGrid(List<ApiCategory> categories) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.8,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final normalized = normalizeCategoryTitle(category.title);
          return InkWell(
            onTap: () {
              final builder = apiCategoryPageBuilders[normalized];
              if (builder != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => builder()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No page found for ${category.title}'),
                  ),
                );
              }
            },
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.0),
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
                      child: Image.network(
                        category.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.error_outline),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      category.title.replaceAll('-', ' ').replaceAll('&', ' '),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSalonServiceList(List<SalonService> services) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Container(
            width: 180,
            margin: const EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12.0),
                    ),
                    child: Image.asset(
                      service.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.error_outline),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          service.details,
                          style: TextStyle(
                            color: AppColors.grey600,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildViewAllButton(BuildContext context, String text) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Handle the view all button action
          if (text == 'View All Staff') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        OurMembersPage(), // Navigate  to LadiesSalonPage
              ),
            );
          }
          // Add more conditions for other view all buttons if needed
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          foregroundColor: AppColors.black,
          side: BorderSide(color: AppColors.grey200, width: 1.0),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildNewsletterSection() {
    if (newsletter.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            newsletter['title'] ?? 'Newsletter',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            newsletter['description'] ?? '',
            style: const TextStyle(color: AppColors.grey600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          // TextField(
          //   decoration: InputDecoration(
          //     hintText: 'Enter your email',
          //     filled: true,
          //     fillColor: AppColors.grey200,
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: BorderSide.none,
          //     ),
          //     contentPadding: const EdgeInsets.symmetric(
          //       horizontal: 16,
          //       vertical: 12,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildBrandGrid(List<Brand> brands) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2E463F),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(
                  brand.imageUrl,
                  fit: BoxFit.fill,
                  // color:AppColors.white,
                  errorBuilder:
                      (context, error, stackTrace) => const Icon(
                        Icons.error_outline,
                        color: AppColors.white,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerticalListItem(ListItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: TextStyle(color: AppColors.grey600, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.buttonText != null) ...[
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (item.buttonText == 'Our Members') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OurMembersPage(),
                            ),
                          );
                        }
                        if (item.buttonText == 'Learn More') {
                          final url =
                              'https://youtube.com'; // Replace with actual URL
                          launchUrl(
                            Uri.parse(url),
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.transparent,
                        shadowColor: AppColors.transparent,
                        foregroundColor: AppColors.black,
                        side: BorderSide(color: AppColors.grey200, width: 1.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        item.buttonText!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.error_outline),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentOffersList(List<Offer> offers) {
    return SizedBox(
      height:
          270.0, // Corrected height to prevent overflow, i changed it so bottom overflow is prevented
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(
          16.0,
          0,
          16.0,
          24.0,
        ), // Increased bottom padding that is shadow was cutting the box bottom
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.7,
            margin: const EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12.0),
                    ),
                    child: Image.asset(
                      offer.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.error_outline),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offer.details,
                        style: TextStyle(
                          color: AppColors.grey600,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<List<ApiCategory>> fetchApiCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/api/home'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List categories = data['categoryCarousel'] ?? [];
      return categories.map((e) => ApiCategory.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<FeaturedService>> fetchFeaturedServices() async {
    final response = await http.get(Uri.parse('$baseUrl/api/home'));
    // print('Featured services response: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List featured = data['featuredServices'] ?? [];
      return featured.map((e) => FeaturedService.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load featured services');
    }
  }

  Widget _buildFeaturedServicesList(List<FeaturedService> featuredServices) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          featuredServices.map((fs) {
            if (fs.services.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 16.0,
                    bottom: 8.0,
                  ),
                  child: Text(
                    fs.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black87,
                    ),
                  ),
                ),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: fs.services.length,
                    itemBuilder: (context, index) {
                      final item = fs.services[index];
                      return GestureDetector(
                        onTap: () {
                          final fullSlug = item.slug;
                          final apiSlug = fullSlug.split('/').last;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemView(slug: apiSlug),
                            ),
                          );
                        },
                        child: Container(
                          width: 200,
                          margin: const EdgeInsets.only(right: 12.0),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12.0),
                                  ),
                                  child: Image.network(
                                    item.image,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.error_outline),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.price,
                                        style: TextStyle(
                                          color: AppColors.accentColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if (item.duration != null)
                                        Text(
                                          item.duration!,
                                          style: TextStyle(
                                            color: AppColors.grey600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      const SizedBox(height: 4),
                                      // IconButton(
                                      //   icon: const Icon(
                                      //     Icons.favorite_border,
                                      //     color: AppColors.accentColor,
                                      //     size: 22,
                                      //   ),
                                      //   onPressed: () {
                                      //     wishlistService.addItem(
                                      //       WishlistItem(
                                      //         id: item.id.toString(),
                                      //         imagePath: item.image,
                                      //         title: item.name,
                                      //         price: item.price,
                                      //         rating:
                                      //             item.rating != null
                                      //                 ? double.tryParse(
                                      //                       item.rating
                                      //                           .toString(),
                                      //                     ) ??
                                      //                     0
                                      //                 : 0,
                                      //         slug: (item.slug).split('/').last,
                                      //       ),
                                      //     );
                                      //     ScaffoldMessenger.of(
                                      //       context,
                                      //     ).showSnackBar(
                                      //       SnackBar(
                                      //         content: Text(
                                      //           'Added ${item.name} to wishlist!',
                                      //         ),
                                      //       ),
                                      //     );
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }

  // --- FAQ Section ---
  Widget _buildFaqSection() {
    if (apiFaqs.isEmpty) return const SizedBox.shrink();
    final faqsToShow = showAllFaqs ? apiFaqs : apiFaqs.take(3).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          ...faqsToShow.map((faq) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.grey200, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  childrenPadding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 12.0,
                  ),
                  collapsedBackgroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    faq['question'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black87,
                      fontSize: 15,
                    ),
                  ),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        faq['answer'] ?? '',
                        style: const TextStyle(
                          color: AppColors.grey800,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          if (apiFaqs.length > 3)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showAllFaqs = !showAllFaqs;
                  });
                },
                child: Text(
                  showAllFaqs ? 'Show Less' : 'View All FAQs',
                  style: const TextStyle(
                    color: AppColors.accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    if (staffMembers.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Our Staff'),
        SizedBox(
          height: 210, // Adjust height as needed
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: staffMembers.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final member = staffMembers[index];
              final specialties =
                  (member['specialties'] as List<dynamic>? ?? []).isNotEmpty
                      ? (member['specialties'] as List<dynamic>).first
                      : '';
              final rating = member['rating']?.toString() ?? '5.0';
              // ...inside _buildTeamSection() ListView.separated itemBuilder...
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 160,
                    margin: const EdgeInsets.only(top: 36),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 48), // Space for avatar overlap
                        Text(
                          member['name'] ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (specialties != null &&
                            specialties.toString().isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              specialties,
                              style: const TextStyle(
                                color: AppColors.grey600,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => StaffProfilePage(
                                        staffId:
                                            member['id'] is int
                                                ? member['id']
                                                : int.tryParse(
                                                      member['id'].toString(),
                                                    ) ??
                                                    0,
                                      ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accentColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            child: const Text('View Profile'),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: AppColors.white,
                        backgroundImage:
                            member['image'] != null &&
                                    member['image'].toString().isNotEmpty
                                ? NetworkImage(member['image'])
                                : const AssetImage('assets/images/default.png')
                                    as ImageProvider,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonialsSection() {
    if (testimonials.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Testimonials'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children:
                testimonials
                    .map(
                      (t) => Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey.withOpacity(0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // CircleAvatar(
                            //   radius: 24,
                            //   backgroundImage: const AssetImage('assets/images/default.png'),
                            // ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t['name'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (i) => Icon(
                                        Icons.star,
                                        color:
                                            i < (t['rating'] ?? 0)
                                                ? AppColors.accentColor
                                                : AppColors.grey200,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    t['comment'] ?? '',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}
