import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/EarningCoursesPage.dart';
import 'package:lipslay_flutter_frontend/ItemView.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/consultant.dart';
import 'package:lipslay_flutter_frontend/education.dart';
import 'package:lipslay_flutter_frontend/freelancerspage.dart';
import 'package:lipslay_flutter_frontend/gents_salon.dart';
import 'package:lipslay_flutter_frontend/itsolutionpage.dart';
import 'package:lipslay_flutter_frontend/ladies_salon2.dart';
import 'package:lipslay_flutter_frontend/lpg_gas.dart';
import 'package:lipslay_flutter_frontend/notificationpage.dart';
import 'package:lipslay_flutter_frontend/services.dart';
import 'package:lipslay_flutter_frontend/spa.dart';
import 'package:lipslay_flutter_frontend/subscriptionspage.dart';
import 'package:lipslay_flutter_frontend/swimmingpool.dart';
import 'package:lipslay_flutter_frontend/travel_event.dart';
import 'package:lipslay_flutter_frontend/wholesale.dart';
import 'package:lipslay_flutter_frontend/wholesale_salon_products.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lipslay_flutter_frontend/chatbot_page.dart';
import 'package:lipslay_flutter_frontend/memberpage.dart';
import 'package:hive/hive.dart';
import 'models/category_hive_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Ad {
  final String title;
  final String details;
  final String imageUrl;

  Ad({required this.title, required this.details, required this.imageUrl});
 factory Ad.fromJson(Map<String, dynamic> json) => Ad(
  factory Ad.fromJson(Map<String, dynamic> json) => Ad(    title: json['title'] ?? '',
        title: json['title'] ?? '',etails'] ?? '',
        details: json['details'] ?? '',mage'] ?? '',
        imageUrl: json['image'] ?? '',
      );
}
ce {
class SalonService {
  final String title;
  final String details;
  final String imageUrl;
 SalonService({
  SalonService({    required this.title,
    required this.title,this.details,
    required this.details,ageUrl,
    required this.imageUrl,
  });
}

class Brand { final String name;
  final String name;  final String imageUrl;
  final String imageUrl;ink;
  final String link;
ame, required this.imageUrl, required this.link});
  Brand({required this.name, required this.imageUrl, required this.link});(Map<String, dynamic> json) => Brand(
',
  factory Brand.fromJson(Map<String, dynamic> json) => Brand(    imageUrl: json['image'] ?? '',
        name: json['name'] ?? '',on['link'] ?? '',
        imageUrl: json['image'] ?? '',
        link: json['link'] ?? '',
      );
}
al String title;
class ListItem { final String subtitle;
  final String title;  final String imageUrl;
  final String subtitle;g? buttonText;
  final String imageUrl;
  final String? buttonText;

  ListItem({    required this.subtitle,
    required this.title,
    required this.subtitle,   this.buttonText,
    required this.imageUrl,  });
    this.buttonText,
  });
}

class Offer {
  final String title;  final String imageUrl;
  final String details;
  final String imageUrl;title, required this.details, required this.imageUrl});

  Offer({required this.title, required this.details, required this.imageUrl});
}
al String name;
class Member { final String benefits;
  final String name;  final String imageUrl;
  final String benefits;ext;
  final String imageUrl;
  final String? buttonText;
    required this.name,
  Member({
    required this.name,   required this.imageUrl,
    required this.benefits,    this.buttonText,
    required this.imageUrl,
    this.buttonText,
  });
}ceCategory {

class ServiceCategory { final String imageUrl;
  final String title;
  final String imageUrl;eUrl});

  ServiceCategory({required this.title, required this.imageUrl});
}ulWidget {
 HomeTabContent({super.key});
class HomeTabContent extends StatefulWidget {
  const HomeTabContent({super.key});
omeTabContentState();
  @override
  State<HomeTabContent> createState() => _HomeTabContentState();
}tState extends State<HomeTabContent> {
ssets/images/gents_salon.png';
class _HomeTabContentState extends State<HomeTabContent> {
  final String defaultImagePath = 'assets/images/gents_salon.png';inal List<Ad> advertisements = [
   Ad(
  final List<Ad> advertisements = [  //     title: 'Ad 1',
    Ad(
      title: 'Ad 1',assets/images/image2.png',
      details: 'Details about Ad 1',
      imageUrl: 'assets/images/image2.png',
    ),   title: 'Ad 2',
    Ad(etails about Ad 2',
      title: 'Ad 2',images/image4.png',
      details: 'Details about Ad 2',
      imageUrl: 'assets/images/image4.png',;
    ),
  ];iceCategory> ladiesSalonCategories = [

  final List<ServiceCategory> ladiesSalonCategories = [
    ServiceCategory(   imageUrl: 'assets/images/ladies_salon.png',
      title: 'Ladies Salon',
      imageUrl: 'assets/images/ladies_salon.png',
    ),
    ServiceCategory(   imageUrl: 'assets/images/gents_salon.png',
      title: 'Gents Salon',
      imageUrl: 'assets/images/gents_salon.png',ry(title: 'SPA', imageUrl: 'assets/images/spa.png'),
    ),
    ServiceCategory(title: 'SPA', imageUrl: 'assets/images/spa.png'),
    ServiceCategory(   imageUrl: 'assets/images/consultant.png',
      title: 'Consultant',
      imageUrl: 'assets/images/consultant.png',
    ),
    ServiceCategory(   imageUrl: 'assets/images/wholesale.png',
      title: 'Wholesale Salon Products',
      imageUrl: 'assets/images/wholesale.png',Services', imageUrl: 'assets/images/services.png'),
    ),
    ServiceCategory(title: 'Services', imageUrl: 'assets/images/services.png'),   title: 'Travel-Event',
    ServiceCategory(assets/images/entertainment.png',
      title: 'Travel-Event',
      imageUrl: 'assets/images/entertainment.png',
    ),   title: 'Freelancers',
    ServiceCategory(assets/images/freelancers.png',
      title: 'Freelancers',
      imageUrl: 'assets/images/freelancers.png',
    ),   title: 'Earning Courses',
    ServiceCategory(assets/images/earning_courses.png',
      title: 'Earning Courses',
      imageUrl: 'assets/images/earning_courses.png',
    ),   title: 'Wholesale',
    ServiceCategory(assets/images/wholesale.png',
      title: 'Wholesale',
      imageUrl: 'assets/images/wholesale.png',
    ),   title: 'IT Solution',
    ServiceCategory(assets/images/it_solution.png',
      title: 'IT Solution',
      imageUrl: 'assets/images/it_solution.png',
    ),   title: 'LPG gas cylinder',
    ServiceCategory(assets/images/lpg_gas.png',
      title: 'LPG gas cylinder',
      imageUrl: 'assets/images/lpg_gas.png',
    ),   title: 'Subcriptions',
    ServiceCategory(     imageUrl: 'assets/images/subscriptions.png',
      title: 'Subcriptions',  //   ),
      imageUrl: 'assets/images/subscriptions.png',
    ),Education',
    ServiceCategory(ingcourses.png',
      title: 'Education',
      imageUrl: 'assets/images/earningcourses.png',
    ),   title: 'Swimming Pool',
    ServiceCategory(: 'assets/images/swimmingpool.png',
      title: 'Swimming Pool',
      imageUrl: 'assets/images/swimmingpool.png',
    ),
  ];inal List<SalonService> ladiesSalonServices = [
   SalonService(
  final List<SalonService> ladiesSalonServices = [  //     title: 'Ladies Salon Service 1',
    SalonService(
      title: 'Ladies Salon Service 1',: 'assets/images/image2.png',
      details: 'Details about Service 1',
      imageUrl: 'assets/images/image2.png',
    ),
    SalonService(   details: 'Details about Service 2',
      title: 'Ladies Salon Service 2',: 'assets/images/image4.png',
      details: 'Details about Service 2',
      imageUrl: 'assets/images/image4.png',
    ),
  ];l List<SalonService> gentsSalonServices = [
SalonService(
  final List<SalonService> gentsSalonServices = [      title: 'Gents Salon Service 1',
    SalonService(Service 1',
      title: 'Gents Salon Service 1',eUrl: 'assets/images/makeup.png',
      details: 'Details about Service 1',
      imageUrl: 'assets/images/makeup.png',
    ), 2',
    SalonService(details: 'Details about Service 2',
      title: 'Gents Salon Service 2',eUrl: 'assets/images/waxing.png',
      details: 'Details about Service 2',
      imageUrl: 'assets/images/waxing.png',
    ),
  ];inal List<Brand> brands = [
nd(
  final List<Brand> brands = [1',
    Brand(
      name: 'Brand 1',m',
      imageUrl: 'assets/images/nails.png', ),
      link: 'https://brand1.com',nd(
    ),2',
    Brand(g',
      name: 'Brand 2',m',
      imageUrl: 'assets/images/nails.png', ),
      link: 'https://brand1.com',nd(
    ),3',
    Brand(ebp',
      name: 'Brand 3',m',
      imageUrl: 'assets/images/profile_pic.webp', ),
      link: 'https://brand1.com',nd(
    ),4',
    Brand(g',
      name: 'Brand 4',m',
      imageUrl: 'assets/images/henna.png', ),
      link: 'https://brand1.com',nd(
    ),5',
    Brand(id.png',
      name: 'Brand 5',m',
      imageUrl: 'assets/images/house_maid.png', ),
      link: 'https://brand1.com',nd(
    ),6',
    Brand(
      name: 'Brand 6',m',
      imageUrl: 'assets/images/nails.png', ),
      link: 'https://brand1.com',nd(
    ),7',
    Brand(g',
      name: 'Brand 7',m',
      imageUrl: 'assets/images/nails.png', ),
      link: 'https://brand1.com',nd(
    ),',
    Brand(ebp',
      name: 'Brand 8',m',
      imageUrl: 'assets/images/profile_pic.webp', ),
      link: 'https://brand1.com',   Brand(
    ),  //     name: 'Brand 9',
    Brand(,
      name: 'Brand 9',.com',
      imageUrl: 'assets/images/henna.png',
      link: 'https://brand1.com',
    ),
    Brand(s/house_maid.png',
      name: 'Brand 10',     link: 'https://brand1.com',
      imageUrl: 'assets/images/house_maid.png',  //   ),
      link: 'https://brand1.com',
    ),
  ];

  final ListItem installmentPlan = ListItem(
    title: 'Installment Plan',    'Spread the cost of your spa treatments with our flexible installment plans.',
    subtitle:    imageUrl: 'assets/images/image4.png',
        'Spread the cost of your spa treatments with our flexible installment plans.',
    imageUrl: 'assets/images/image4.png',
    buttonText: 'Explore Plans',
  );

  final ListItem itSupport = ListItem(subtitle: 'Get IT solutions for your spa business.',
    title: 'IT Support',    imageUrl: 'assets/images/image2.png',
    subtitle: 'Get IT solutions for your spa business.',ged text here
    imageUrl: 'assets/images/image2.png',
    buttonText: 'Go to IT Solutions', // Changed text here
  );(

  final ListItem businessLoans = ListItem(subtitle: 'Explore loan options to grow your spa business.',
    title: 'Business Loans',    imageUrl: 'assets/images/image2.png',
    subtitle: 'Explore loan options to grow your spa business.',
    imageUrl: 'assets/images/image2.png',
    buttonText: 'Apply Now',
  );tem(
l',
  final ListItem earningPotential = ListItem(subtitle: 'Discover how you can earn up to 400,000 AED.',
    title: 'Earning Potential',    imageUrl: 'assets/images/image2.png',
    subtitle: 'Discover how you can earn up to 400,000 AED.',
    imageUrl: 'assets/images/image2.png',
    buttonText: 'Learn More',
  );

  final ListItem spaChannel = ListItem(btitle: 'Watch our sponsored YouTube channel for spa tips and more.',
    title: 'Spa Channel',rl: 'assets/images/image2.png',
    subtitle: 'Watch our sponsored YouTube channel for spa tips and more.',Now',
    imageUrl: 'assets/images/image2.png',
    buttonText: 'Watch Now',
  );l List<Offer> currentOffers = [
Offer(
  final List<Offer> currentOffers = [      title: 'Offer 1',
    Offer(
      title: 'Offer 1',mage2.png',
      details: 'Details about Offer 1',
      imageUrl: 'assets/images/image2.png',
    ),
    Offer(  details: 'Details about Offer 2',
      title: 'Offer 2',      imageUrl: 'assets/images/image2.png',
      details: 'Details about Offer 2',
      imageUrl: 'assets/images/image2.png',
    ),
  ];its = Member(

  final Member membershipBenefits = Member(
    name: 'Membership Benefits',
    benefits: 'Exclusive benefits for our spa members.',
    imageUrl: 'assets/images/image2.png',
    buttonText: 'Our Members',
  );
build(BuildContext context) {
  @override dynamic>>(
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchHomeData(),onnectionState == ConnectionState.waiting) {
      builder: (context, snapshot) {ularProgressIndicator());
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());r(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));ta found.'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data found.'));        final data = snapshot.data!;
        }es = (data['categories'] as List)
        final data = snapshot.data!;n) => CategoryHiveModel.fromJson(json))
        final categories = (data['categories'] as List)
            .map((json) => CategoryHiveModel.fromJson(json))
            .toList();on(json))
        final ads = (data['ads'] as List)
            .map((json) => Ad.fromJson(json))l brands = (data['brands'] as List)
            .toList();  .map((json) => Brand.fromJson(json))
        final brands = (data['brands'] as List)    .toList();
            .map((json) => Brand.fromJson(json))
            .toList();     return Column(
          children: [
        return Column(t(ads),
          children: [            _buildLadiesSalonCategoriesGrid(categories),
            _buildAdvertisementsList(ads),
            _buildLadiesSalonCategoriesGrid(categories),ther widgets
            _buildBrandGrid(brands),
            // ...other widgets
          ],
        );
      },
    );
  }

  // --- Widget Builder Methods --- _buildSectionTitle(String title) {
turn Padding(
  Widget _buildSectionTitle(String title) {   padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
    return Padding(      child: Text(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
      child: Text( TextStyle(
        title,: 18,
        style: const TextStyle(ht.bold,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.black87,
        ),
      ),
    );
  }ementsList(List<Ad> ads) {

  Widget _buildAdvertisementsList(List<Ad> ads) {
    return SizedBox(
      height: 160,xis.horizontal,
      child: ListView.builder(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: ads.length,
        itemBuilder: (context, index) {(
          final ad = ads[index]; () {
          return InkWell(vigator.push(
            onTap: () {  context,
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ItemView(details,
                        title: ad.title,
                        description: ad.details,
                        imageUrl: ad.imageUrl,
                      ),
                ),
              );dius.circular(12.0),
            },
            borderRadius: BorderRadius.circular(12.0), MediaQuery.of(context).size.width * 0.8,
            child: Container(in: const EdgeInsets.only(right: 12.0),
              width: MediaQuery.of(context).size.width * 0.8,(
              margin: const EdgeInsets.only(right: 12.0),ar(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [(0.1),
                  BoxShadow(
                    color: AppColors.grey.withOpacity(0.1),blurRadius: 5,
                    spreadRadius: 1,: const Offset(0, 3),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ], AssetImage(ad.imageUrl),
                image: DecorationImage(fit: BoxFit.cover,
                  image: AssetImage(ad.imageUrl),  colorFilter: ColorFilter.mode(
                  fit: BoxFit.cover,.black.withOpacity(0.2),
                  colorFilter: ColorFilter.mode(
                    AppColors.black.withOpacity(0.2),
                    BlendMode.darken,
                  ),(
                  onError:.error_outline,
                      (exception, stackTrace) => const Icon(olor: AppColors.white,
                        Icons.error_outline,
                        color: AppColors.white,
                      ),
                ),
              ),sets.all(16.0),
              child: Padding(olumn(
                padding: const EdgeInsets.all(16.0),sAxisAlignment: CrossAxisAlignment.start,
                child: Column(sAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(xtStyle(
                      ad.title,color: AppColors.white,
                      style: const TextStyle(  fontWeight: FontWeight.bold,
                        color: AppColors.white,    fontSize: 18,
                        fontWeight: FontWeight.bold,    ),
                        fontSize: 18,    ),
                      ),      Text(
                    ),          ad.details,
                    Text(            style: const TextStyle(
                      ad.details,                color: AppColors.white70,
                      style: const TextStyle(                  fontSize: 14,
                        color: AppColors.white70,                   ),
                        fontSize: 14,                    ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }4_145630358.png
iesGrid(List<CategoryHiveModel> categories) {
  // Modified Widget Builder for Ladies Salon Categories Grid to match image_2025-06-04_145630358.png
  Widget _buildLadiesSalonCategoriesGrid(List<CategoryHiveModel> categories) {ing: const EdgeInsets.symmetric(horizontal: 16.0),
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(hysics(),
        shrinkWrap: true,st SliverGridDelegateWithFixedCrossAxisCount(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(tio:
          crossAxisCount: 2, // Two columns+text in a row
          childAspectRatio:
              2.8, // Adjusted to make cards wider and accommodate image+text in a row
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,ies.length,
        ),) {
        itemCount: categories.length,ategories[index];
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell() {
            // Added InkWell for tap functionality and visual feedback'Tapped on Ladies Salon Category: ${category.title}');
            onTap: () {/ Conditional navigation based on category title
              log('Tapped on Ladies Salon Category: ${category.title}');              if (category.title == 'Ladies Salon') {
              // Conditional navigation based on category title
              if (category.title == 'Ladies Salon') {
                Navigator.push(PageRoute(
                  context,
                  MaterialPageRoute(text) =>
                    builder:lon2Page(), // Navigate to HomePage3 for Makeup
                        (context) =>
                            LadiesSalon2Page(), // Navigate to HomePage3 for Makeup
                  ),
                );
              }              if (category.title == 'Gents Salon') {

              if (category.title == 'Gents Salon') {
                Navigator.push(oute(
                  context,r:
                  MaterialPageRoute(
                    builder:GentsSalon(), // Navigate to LadiesSalon2Page for Henna
                        (context) =>
                            GentsSalon(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }tegory.title == 'SPA') {
 Default navigation for other categories, or remove if not needed
              if (category.title == 'SPA') { Navigator.push(
                // Default navigation for other categories, or remove if not needed
                Navigator.push(oute(
                  context,r:
                  MaterialPageRoute(
                    builder:SpaPage(), // Or a generic category view page
                        (context) =>ll want to pass the category title to the destination page:
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
                );lon Products') {
              }
              if (category.title == 'Wholesale Salon Products') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:Page for Henna
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
                );{
              }
              if (category.title == 'Travel-Event') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            TravelEventPage(), // Navigate to LadiesSalon2Page for Henna
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
                );es') {
              }
              if (category.title == 'Earning Courses') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:Henna
                        (context) =>
                            EarningCoursesPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Wholesale') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            WholesalePage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'IT Solution') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:or Henna
                        (context) =>
                            ITSolutionPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );') {
              }
              if (category.title == 'LPG gas cylinder') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            LpgGas(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              }
              if (category.title == 'Subcriptions') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:Henna
                        (context) =>
                            SubscriptionsPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );') {
              }
              if (category.title == 'Swimming Pool') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            SwimmingPool(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );if (category.title == 'Education') {
              }
              if (category.title == 'Education') {ontext,
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:      EducationPage(), // Navigate to LadiesSalon2Page for Henna
                        (context) =>
                            EducationPage(), // Navigate to LadiesSalon2Page for Henna
                  ),
                );
              } BorderRadius.circular(
            },
            borderRadius: BorderRadius.circular( for proper ripple effect
              12.0,
            ), // Apply to InkWell for proper ripple effect
            child: Container(
              decoration: BoxDecoration(
                color:y200, // Background color as in image_2025-06-04_145630358.png
                    AppColors, // Rounded edges
                        .grey200, // Background color as in image_2025-06-04_145630358.png
                borderRadius: BorderRadius.circular(12.0), // Rounded edges
              ),
              child: Row(
                // Use Row to place image and text side-by-side
                mainAxisAlignment:// Align content to the start (left)
                    MainAxisAlignment
                        .start, // Align content to the start (left), // Padding from the left edge
                children: [
                  const SizedBox(width: 12), // Padding from the left edgerounded corners
                  ClipRRect(
                    // Clip image to have rounded corners
                    borderRadius: BorderRadius.circular(/ Smaller rounded corners for the image itself
                      8.0,ild: Container(
                    ), // Smaller rounded corners for the image itself  color: AppColors.transparent,
                    child: Container(
                      color: AppColors.transparent,t: 50,
                      width: 50,
                      height: 50,.imageUrl,
                      child: Image.network(over,
                        category.imageUrl,t, error, stackTrace) =>
                        fit: BoxFit.cover,n(Icons.error_outline),
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error_outline),
                      ),
                    ),image and text
                  ),
                  const SizedBox(width: 12), // Spacing between image and text Use Expanded to allow text to take available space
                  Expanded(child: Text(
                    // Use Expanded to allow text to take available space
                    child: Text(    style: const TextStyle(
                      category.title,        fontSize: 14,
                      style: const TextStyle(          fontWeight: FontWeight.w600,
                        fontSize: 14,            color: AppColors.black87,
                        fontWeight: FontWeight.w600,            ),
                        color: AppColors.black87,              maxLines: 2, // Allow text to wrap if long
                      ),                overflow: TextOverflow.ellipsis,
                      maxLines: 2, // Allow text to wrap if long                 ),
                      overflow: TextOverflow.ellipsis,                  ),
                    ),e right edge
                  ),
                  const SizedBox(width: 8), // Padding from the right edge
                ],
              ),
            ),
          );
        },
      ),
    );
  }viceList(List<SalonService> services) {

  Widget _buildSalonServiceList(List<SalonService> services) {
    return SizedBox(
      height: 200,xis.horizontal,
      child: ListView.builder(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: services.length,
        itemBuilder: (context, index) {(
          final service = services[index]; () {
          return InkWell(vigator.push(
            onTap: () {  context,
              Navigator.push(
                context,
                MaterialPageRoute(ntext) => ItemView(
                  builder:
                      (context) => ItemView(vice.details,
                        title: service.title,ce.imageUrl,
                        description: service.details,
                        imageUrl: service.imageUrl,
                      ),
                ),
              );us.circular(12.0),
            },
            borderRadius: BorderRadius.circular(12.0),
            child: Container(: const EdgeInsets.only(right: 12.0),
              width: 180,ration: BoxDecoration(
              margin: const EdgeInsets.only(right: 12.0),color: AppColors.white,
              decoration: BoxDecoration(: BorderRadius.circular(12.0),
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.0),(
                boxShadow: [Colors.grey.withOpacity(0.1),
                  BoxShadow(
                    color: AppColors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),xisAlignment.start,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(d: ClipRRect(
                    aspectRatio: 16 / 9,borderRadius: const BorderRadius.vertical(
                    child: ClipRRect(    top: Radius.circular(12.0),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12.0),asset(
                      ),
                      child: Image.asset(cover,
                        service.imageUrl,
                        fit: BoxFit.cover,t, error, stackTrace) =>
                        errorBuilder: const Icon(Icons.error_outline),
                            (context, error, stackTrace) =>
                                const Icon(Icons.error_outline),
                      ),
                    ),
                  ),ding(
                  Expanded(eInsets.all(12.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),sAxisAlignment: CrossAxisAlignment.start,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Style(
                            service.title,ld,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,const SizedBox(height: 4),
                          ),  Text(
                          const SizedBox(height: 4),      service.details,
                          Text(        style: TextStyle(
                            service.details,            color: AppColors.grey600,
                            style: TextStyle(              fontSize: 14,
                              color: AppColors.grey600,              ),
                              fontSize: 14,                maxLines: 1,
                            ),                  overflow: TextOverflow.ellipsis,
                            maxLines: 1,                  ),
                            overflow: TextOverflow.ellipsis,                  ],
                          ),                   ),
                        ],                    ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }ldContext context, String text) {

  Widget _buildViewAllButton(BuildContext context, String text) {vatedButton(
    return Center(sed: () {
      child: ElevatedButton(/ Handle the view all button action
        onPressed: () {
          // Handle the view all button action  Navigator.push(
          if (text == 'View All Ladies\' Salon Services') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:sSalonPage
                    (context) =>
                        LadiesSalon2Page(), // Navigate  to LadiesSalonPage
              ),
            ); Add more conditions for other view all buttons if needed
          }
          // Add more conditions for other view all buttons if neededtedButton.styleFrom(
        },roundColor: AppColors.transparent,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,foregroundColor: AppColors.black,
          shadowColor: AppColors.transparent,  side: BorderSide(color: AppColors.grey200, width: 1.0),
          foregroundColor: AppColors.black,    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          side: BorderSide(color: AppColors.grey200, width: 1.0),       shape: RoundedRectangleBorder(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),            borderRadius: BorderRadius.circular(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),t(
        ),
        child: Text(fontSize: 15),
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }nd> brands) {
 SizedBox(
  Widget _buildBrandGrid(List<Brand> brands) {
    return SizedBox(
      height: 200,etric(horizontal: 16.0),
      child: GridView.builder(Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),liverGridDelegateWithFixedCrossAxisCount(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,AxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),, index) {
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          return InkWell(i.parse(brand.link);
            onTap: () async {unchUrl(url)) {
              final url = Uri.parse(brand.link);l, mode: LaunchMode.externalApplication);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }ircular(100),
            },
            borderRadius: BorderRadius.circular(100),,
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Center(
                child: SizedBox(ht: 80,
                  width: 80,ild: ClipOval(
                  height: 80,  child: Image.asset(
                  child: ClipOval(      brand.imageUrl,
                    child: Image.asset(        fit: BoxFit.cover,
                      brand.imageUrl,          errorBuilder:
                      fit: BoxFit.cover,                (context, error, stackTrace) => const Icon(
                      errorBuilder:                    Icons.error_outline,
                          (context, error, stackTrace) => const Icon(                      color: Colors.white,
                            Icons.error_outline,                       ),
                            color: Colors.white,                    ),
                          ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerticalListItem(ListItem item) {ets.symmetric(horizontal: 16.0, vertical: 8.0),
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),g: const EdgeInsets.all(16.0),
      child: Container(ration: BoxDecoration(
        padding: const EdgeInsets.all(16.0),color: AppColors.white,
        decoration: BoxDecoration(ius: BorderRadius.circular(12.0),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.0),(
          boxShadow: [AppColors.grey.withOpacity(0.1),
            BoxShadow(dius: 1,
              color: AppColors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),tart,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [3,
            Expanded(
              flex: 3,isAlignment: CrossAxisAlignment.start,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,  fontWeight: FontWeight.bold,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),ht: 4),
                  ),
                  const SizedBox(height: 4),
                  Text((color: AppColors.grey600, fontSize: 14),
                    item.subtitle,
                    style: TextStyle(color: AppColors.grey600, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,uttonText != null) ...[
                  ), SizedBox(height: 12),
                  if (item.buttonText != null) ...[
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {push(
                        if (item.buttonText == 'Our Members') {
                          Navigator.push(
                            context,  builder: (context) => OurMembersPage(),
                            MaterialPageRoute(   ),
                              builder: (context) => OurMembersPage(),
                            ),
                          );tonText == 'Learn More') {
                        }
                        if (item.buttonText == 'Learn More') {actual URL
                          final url =chUrl(
                              'https://youtube.com'; // Replace with actual URLUri.parse(url),
                          launchUrl(   mode: LaunchMode.externalApplication,
                            Uri.parse(url),
                            mode: LaunchMode.externalApplication,
                          );tonText == 'Go to IT Solutions') {
                        }
                        if (item.buttonText == 'Go to IT Solutions') {
                          Navigator.push(MaterialPageRoute(
                            context,     builder: (context) => ITSolutionPage(),
                            MaterialPageRoute(    ),
                              builder: (context) => ITSolutionPage(),
                            ),
                          ); {
                        }m';
                        if (item.buttonText == 'Watch Now') {
                          final url = 'https://youtube.com';
                          launchUrl(ode.externalApplication,
                            Uri.parse(url),
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },ckgroundColor: AppColors.transparent,
                      style: ElevatedButton.styleFrom(shadowColor: AppColors.transparent,
                        backgroundColor: AppColors.transparent,Color: AppColors.black,
                        shadowColor: AppColors.transparent,color: AppColors.grey200, width: 1.0),
                        foregroundColor: AppColors.black,ts.symmetric(
                        side: BorderSide(color: AppColors.grey200, width: 1.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,shape: RoundedRectangleBorder(
                        ),    borderRadius: BorderRadius.circular(8.0),
                        shape: RoundedRectangleBorder(    ),
                          borderRadius: BorderRadius.circular(8.0),    ),
                        ),      child: Text(
                      ),          item.buttonText!,
                      child: Text(extStyle(
                        item.buttonText!,     fontWeight: FontWeight.bold,
                        style: const TextStyle(    fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ],
              ), 16),
            ),
            const SizedBox(width: 16),
            Expanded( AspectRatio(
              flex: 2,pectRatio: 16 / 9,
              child: AspectRatio(child: ClipRRect(
                aspectRatio: 16 / 9,    borderRadius: BorderRadius.circular(12.0),
                child: ClipRRect(      child: Image.asset(
                  borderRadius: BorderRadius.circular(12.0),          item.imageUrl,
                  child: Image.asset(            fit: BoxFit.cover,
                    item.imageUrl,              errorBuilder:
                    fit: BoxFit.cover,                     (context, error, stackTrace) =>
                    errorBuilder:                            const Icon(Icons.error_outline),
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
  }> offers) {

  Widget _buildCurrentOffersList(List<Offer> offers) {vent overflow
    return SizedBox(er(
      height: 250.0, // Corrected height to prevent overflowAxis.horizontal,
      child: ListView.builder(ts.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,length,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),) {
        itemCount: offers.length,rs[index];
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,(
            ), // Increase this value as needed () {
            child: InkWell(vigator.push(
              onTap: () {  context,
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ItemView(er.details,
                          title: offer.title,.imageUrl,
                          description: offer.details,
                          imageUrl: offer.imageUrl,
                        ),
                  ),
                );us.circular(12.0),
              },
              borderRadius: BorderRadius.circular(12.0),e.width * 0.7,
              child: Container(: const EdgeInsets.only(right: 12.0),
                width: MediaQuery.of(context).size.width * 0.7,ration: BoxDecoration(
                margin: const EdgeInsets.only(right: 12.0),color: AppColors.white,
                decoration: BoxDecoration(: BorderRadius.circular(12.0),
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.0),(
                  boxShadow: [Colors.grey,
                    BoxShadow(
                      color: AppColors.grey,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),xisAlignment.start,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(d: ClipRRect(
                      aspectRatio: 16 / 9,borderRadius: const BorderRadius.vertical(
                      child: ClipRRect(    top: Radius.circular(12.0),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12.0),
                        ),eUrl,
                        child: Image.asset(
                          offer.imageUrl,der:
                          fit: BoxFit.cover,context, error, stackTrace) =>
                          errorBuilder:Icon(Icons.error_outline),
                              (context, error, stackTrace) =>
                                  const Icon(Icons.error_outline),
                        ),
                      ),
                    ),eInsets.all(12.0),
                    Padding(
                      padding: const EdgeInsets.all(12.0),sAxisAlignment: CrossAxisAlignment.start,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Style(
                            offer.title,ld,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,const SizedBox(height: 4),
                          ),  Text(
                          const SizedBox(height: 4),      offer.details,
                          Text(        style: TextStyle(
                            offer.details,            color: AppColors.grey600,
                            style: TextStyle(              fontSize: 14,
                              color: AppColors.grey600,              ),
                              fontSize: 14,                maxLines: 1,
                            ),                  overflow: TextOverflow.ellipsis,
                            maxLines: 1,                  ),
                            overflow: TextOverflow.ellipsis,                  ],
                          ),                   ),
                        ],                   ),
                      ),                  ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}sion is at the top-level of the file, outside any class.
to resolve the non_constant_identifier_names warning.
// Ensure this extension is at the top-level of the file, outside any class.mbershipBenefits).copyWith(...)` in build method.
// Changed to a named extension to resolve the non_constant_identifier_names warning.
// Also, call it with `_MemberExtension(membershipBenefits).copyWith(...)` in build method.
extension _MemberExtension on Member {ring? title,
  ListItem copyWith({ String? subtitle,
    String? title,   String? imageUrl,
    String? subtitle,    String? buttonText,
    String? imageUrl,
    String? buttonText,
  }) {itle: title ?? this.name,
    return ListItem(efits,
      title: title ?? this.name,
      subtitle: subtitle ?? this.benefits,buttonText: buttonText ?? this.buttonText,
      imageUrl: imageUrl ?? this.imageUrl,);
      buttonText: buttonText ?? this.buttonText,
    );
  }
}egories() async {
inal box = Hive.box<CategoryHiveModel>('categories');
Future<List<CategoryHiveModel>> fetchAndCacheCategories() async { try {
  final box = Hive.box<CategoryHiveModel>('categories');   final response = await http.get(
  try {      Uri.parse('https://wishlist.lipslay.com/api/home'),
    final response = await http.get(
      Uri.parse('https://wishlist.lipslay.com/api/home'),
    );{
    
    if (response.statusCode == 200) {se {
    return json.decode(response.body);throw Exception('Failed to load home data');
  } else {
    throw Exception('Failed to load home data');
  }
}
}e<Map<String, dynamic>> fetchHomeData() async {

Future<Map<String, dynamic>> fetchHomeData() async {
  try {   Uri.parse('https://wishlist.lipslay.com/api/home'),
    final response = await http.get(   );
      Uri.parse('https://wishlist.lipslay.com/api/home'),    












}  }    throw Exception('Failed to load home data: $e');  } catch (e) {    }      throw Exception('Failed to load home data');    } else {      return json.decode(response.body);    if (response.statusCode == 200) {        );    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load home data');
    }
  } catch (e) {
    throw Exception('Failed to load home data: $e');
  }
}
