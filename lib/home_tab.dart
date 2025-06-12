import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/consultant.dart';
import 'package:lipslay_flutter_frontend/freelancerspage.dart';
import 'package:lipslay_flutter_frontend/gents_salon.dart';
import 'package:lipslay_flutter_frontend/ladies_salon2.dart';
import 'package:lipslay_flutter_frontend/notificationpage.dart';
import 'package:lipslay_flutter_frontend/services.dart';
import 'package:lipslay_flutter_frontend/spa.dart';
import 'package:lipslay_flutter_frontend/travel_event.dart';
import 'package:lipslay_flutter_frontend/wholesale_salon_products.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lipslay_flutter_frontend/chatbot_page.dart';
import 'package:lipslay_flutter_frontend/ladies_salon.dart'; // Import the Ladies Salon page (which is SearchPageUI)

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

class HomeTabContent extends StatefulWidget {
  const HomeTabContent({super.key});

  @override
  State<HomeTabContent> createState() => _HomeTabContentState();
}

class _HomeTabContentState extends State<HomeTabContent> {
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
    ServiceCategory(title: 'Earning Courses', imageUrl: 'assets/images/earning_courses.png'),
    ServiceCategory(title: 'Wholesale', imageUrl: 'assets/images/wholesale.png'),
    ServiceCategory(title: 'IT Solution', imageUrl: 'assets/images/it_solution.png'),
    ServiceCategory(title: 'LPG gas cylinder', imageUrl: 'assets/images/waxing.png'),
    ServiceCategory(title: 'Subcriptions', imageUrl: 'assets/images/subscriptions.png'),
    ServiceCategory(title: 'Education', imageUrl: 'assets/images/waxing.png'),
    

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
    buttonText: 'Join Now',
  );

  @override
  Widget build(BuildContext context) {
    // HomePage now only returns its scrollable content, without a Scaffold
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Advertisements'),
              _buildAdvertisementsList(advertisements),
              const SizedBox(height: 16),

              // NEW SECTION: Ladies Salon Categories (Grid View)
              _buildSectionTitle(
                'Ladies Salon',
              ), // Title as seen in image_2025-06-04_145630358.png
              _buildLadiesSalonCategoriesGrid(ladiesSalonCategories),
              const SizedBox(height: 16),

              // END NEW SECTION
              _buildSectionTitle(
                'Ladies\' Salon',
              ), // Existing section for horizontal services
              _buildSalonServiceList(ladiesSalonServices),
              const SizedBox(height: 16),
              _buildViewAllButton(context, 'View All Ladies\' Salon Services'),
              const SizedBox(height: 16),

              _buildSectionTitle('Gents\' Salon'),
              _buildSalonServiceList(gentsSalonServices),
              const SizedBox(height: 16),

              _buildSectionTitle('Brands'),
              _buildBrandGrid(brands),
              const SizedBox(height: 16),

              _buildSectionTitle('Buy Now Pay in Installments'),
              _buildVerticalListItem(installmentPlan),
              const SizedBox(height: 16),

              _buildSectionTitle('IT Solutions'),
              _buildVerticalListItem(itSupport),
              const SizedBox(height: 16),

              _buildSectionTitle('Loan Opportunities'),
              _buildVerticalListItem(businessLoans),
              const SizedBox(height: 16),

              _buildSectionTitle('Earn Up to 400,000 AED'),
              _buildVerticalListItem(earningPotential),
              const SizedBox(height: 16),

              _buildSectionTitle('YouTube Sponsored Channel'),
              _buildVerticalListItem(spaChannel),
              const SizedBox(height: 16),

              _buildSectionTitle('Current Offers'),
              _buildCurrentOffersList(currentOffers),
              const SizedBox(height: 16),

              _buildSectionTitle('Members'),
              _buildVerticalListItem(
                membershipBenefits.copyWith(
                  title: membershipBenefits.name,
                  subtitle: membershipBenefits.benefits,
                  buttonText: membershipBenefits.buttonText,
                ),
              ),
              const SizedBox(
                height: 20,
              ), // Reduced bottom space, as main Scaffold provides BottomNav
            ],
          ),
        ),
      ],
    );
  }

  // --- Widget Builder Methods ---

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
                            LadiesSalon2Page(), // Navigate to HomePage3 for Makeup
                  ),
                );
              }
              if (category.title == 'Ladies Salon') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            LadiesSalon2Page(), // Navigate to HomePage3 for Makeup
                  ),
                );
              }
              
              if (category.title == 'Gents Salon') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            GentsSalon(), // Navigate to LadiesSalon2Page for Henna
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
                            SpaPage(), // Or a generic category view page
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
                            ConsultantPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Wholesale Salon Products') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            WholesaleSalonProductsPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Services') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ServicesPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Travel-Event') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ConsultantPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Freelancers') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            FreelancersPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Earning Courses') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ConsultantPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Wholesale') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ConsultantPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'IT Solution') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ConsultantPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'LPG gas cylinder') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ConsultantPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Subcriptions') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ConsultantPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Swimming Pool') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ConsultantPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Education') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ConsultantPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Consultant') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ConsultantPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Consultant') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ConsultantPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Consultant') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ConsultantPage(), // Navigate to LadiesSalon2Page for Henna
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
                        .grey200
                        , // Background color as in image_2025-06-04_145630358.png
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
                          AppColors.transparent, // Background for the image circle
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
          // Handle View All action
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
                        // Handle button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.transparent,
                        shadowColor: AppColors.transparent,
                        foregroundColor: AppColors.black,
                        side: BorderSide(
                          color: AppColors.grey200,
                          width: 1.0,
                        ),
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
      height: 250.0, // Corrected height to prevent overflow
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
}

// Ensure this extension is at the top-level of the file, outside any class.
// Changed to a named extension to resolve the non_constant_identifier_names warning.
// Also, call it with `_MemberExtension(membershipBenefits).copyWith(...)` in build method.
extension _MemberExtension on Member {
  ListItem copyWith({
    String? title,
    String? subtitle,
    String? imageUrl,
    String? buttonText,
  }) {
    return ListItem(
      title: title ?? this.name,
      subtitle: subtitle ?? this.benefits,
      imageUrl: imageUrl ?? this.imageUrl,
      buttonText: buttonText ?? this.buttonText,
    );
  }
}
