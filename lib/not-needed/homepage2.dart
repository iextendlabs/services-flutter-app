// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

// --- Data Models (Keep these as they are used by HomePage) ---
class Service {
  final String title;
  final String durationOrPrice;
  final String imageUrl;

  Service({
    required this.title,
    required this.durationOrPrice,
    required this.imageUrl,
  });
}

class Promotion {
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;

  Promotion({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
  });
}

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
  final String imageUrl; // Image for the right side of the list item
  final String? buttonText; // Optional button text

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
  final String imageUrl; // Image that already contains the offer percentage

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

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  // Removed _selectedIndex as it's now managed by MainScreen

  // --- Common Asset Path for all images ---
  final String defaultImagePath = 'assets/images/image2.jpg';

  // --- Dummy Data Lists (All images point to defaultImagePath) ---
  final List<Service> featuredServices = [
    Service(
      title: 'Relaxing Massage',
      durationOrPrice: '60 min',
      imageUrl: 'assets/images/image2.jpg',
    ),
    Service(
      title: 'Rejuvenating Face',
      durationOrPrice: '45 min',
      imageUrl: 'assets/images/image2.jpg',
    ),
    Service(
      title: 'Spa Pedicure',
      durationOrPrice: '75 min',
      imageUrl: 'assets/images/image2.jpg',
    ),
  ];

  final Promotion summerSpaPromotion = Promotion(
    title: 'Summer Spa Package',
    subtitle: 'Limited Time Offer',
    description:
        'Enjoy a full day of pampering with our exclusive summer package.',
    imageUrl: 'assets/images/image2.jpg',
  );

  final List<Ad> advertisements = [
    Ad(
      title: 'Ad 1',
      details: 'Details about Ad 1',
      imageUrl: 'assets/images/image2.jpg',
    ),
    Ad(
      title: 'Ad 2',
      details: 'Details about Ad 2',
      imageUrl: 'assets/images/image2.jpg',
    ),
  ];

  final List<SalonService> ladiesSalonServices = [
    SalonService(
      title: 'Ladies Salon Service 1',
      details: 'Details about Service 1',
      imageUrl: 'assets/images/image2.jpg',
    ),
    SalonService(
      title: 'Ladies Salon Service 2',
      details: 'Details about Service 2',
      imageUrl: 'assets/images/image2.jpg',
    ),
  ];

  final List<SalonService> gentsSalonServices = [
    SalonService(
      title: 'Gents Salon Service 1',
      details: 'Details about Service 1',
      imageUrl: 'assets/images/image2.jpg',
    ),
    SalonService(
      title: 'Gents Salon Service 2',
      details: 'Details about Service 2',
      imageUrl: 'assets/images/image2.jpg',
    ),
  ];

  final List<Brand> brands = [
    Brand(name: 'Brand 1', imageUrl: 'assets/images/nails.png'),
    Brand(name: 'Brand 2', imageUrl: 'assets/images/nails.png'),
    Brand(name: 'Brand 3', imageUrl: 'assets/images/profile_pic.webp'),
    Brand(name: 'Brand 4', imageUrl: 'assets/images/henna.png'),
    Brand(name: 'Brand 5', imageUrl: 'assets/images/image2.jpg'),
    Brand(name: 'Brand 6', imageUrl: 'assets/images/image2.jpg'),
    Brand(name: 'Brand 7', imageUrl: 'assets/images/image2.jpg'),
    Brand(name: 'Brand 8', imageUrl: 'assets/images/image2.jpg'),
    Brand(name: 'Brand 9', imageUrl: 'assets/images/image2.jpg'),
    Brand(name: 'Brand 10', imageUrl: 'assets/images/image2.jpg'),
  ];

  final ListItem installmentPlan = ListItem(
    title: 'Installment Plan',
    subtitle:
        'Spread the cost of your spa treatments with our flexible installment plans.',
    imageUrl: 'assets/images/image2.jpg',
    buttonText: 'Learn More',
  );

  final ListItem itSupport = ListItem(
    title: 'IT Support',
    subtitle: 'Get IT solutions for your spa business.',
    imageUrl: 'assets/images/image2.jpg',
    buttonText: 'Explore',
  );

  final ListItem businessLoans = ListItem(
    title: 'Business Loans',
    subtitle: 'Explore loan options to grow your spa business.',
    imageUrl: 'assets/images/image2.jpg',
    buttonText: 'Apply Now',
  );

  final ListItem earningPotential = ListItem(
    title: 'Earning Potential',
    subtitle: 'Discover how you can earn up to 400,000 AED.',
    imageUrl: 'assets/images/image2.jpg',
    buttonText: 'Learn More',
  );

  final ListItem spaChannel = ListItem(
    title: 'Spa Channel',
    subtitle: 'Watch our sponsored YouTube channel for spa tips and more.',
    imageUrl: 'assets/images/image2.jpg',
    buttonText: 'Watch Now',
  );

  final List<Offer> currentOffers = [
    Offer(
      title: 'Offer 1',
      details: 'Details about Offer 1',
      imageUrl: 'assets/images/image2.jpg',
    ),
    Offer(
      title: 'Offer 2',
      details: 'Details about Offer 2',
      imageUrl: 'assets/images/image2.jpg',
    ),
  ];

  final Member membershipBenefits = Member(
    name: 'Membership Benefits',
    benefits: 'Exclusive benefits for our spa members.',
    imageUrl: 'assets/images/image2.jpg',
    buttonText: 'Join Now',
  );

  @override
  Widget build(BuildContext context) {
    // HomePage now only returns its scrollable content, without a Scaffold
    return CustomScrollView(
      slivers: [
        // _buildSliverAppBar(), // Custom app bar with search
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Featured Services'),
              _buildFeaturedServicesList(featuredServices),
              const SizedBox(height: 16), // Spacing between sections

              _buildSectionTitle('Promotions'),
              _buildPromotionCard(summerSpaPromotion),
              const SizedBox(height: 16),

              _buildSectionTitle('Advertisements'),
              _buildAdvertisementsList(advertisements),
              const SizedBox(height: 16),

              _buildSectionTitle('Ladies\' Salon'),
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

  // --- Widget Builder Methods (These remain mostly unchanged) ---

  // ignore: unused_element
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
      expandedHeight: 080.0,
      floating: true,
      // pinned: true,
      backgroundColor: AppColors.white,
      elevation: 0.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.grey200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for services',
                    prefixIcon: Icon(Icons.search, color: AppColors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    isDense: true,
                  ),
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _buildFeaturedServicesList(List<Service> services) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Container(
            width: 160,
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
                          service.durationOrPrice,
                          style: TextStyle(
                            color: AppColors.grey600,
                            fontSize: 14,
                          ),
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

  Widget _buildPromotionCard(Promotion promotion) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    promotion.subtitle,
                    style: TextStyle(
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    promotion.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    promotion.description,
                    style: TextStyle(color: AppColors.grey600, fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Book Now
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Book Now'),
                  ),
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
                    promotion.imageUrl,
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
                  fit: BoxFit.contain,
                  color: AppColors.white,
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

  // In lib/home_page.dart

  // ... (other methods and data models)

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
