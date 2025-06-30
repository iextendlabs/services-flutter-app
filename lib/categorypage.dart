// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/ECommercePage.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/female_massage.dart';
import 'package:lipslay_flutter_frontend/itsolutionpage.dart';
import 'package:lipslay_flutter_frontend/male_packages.dart';
import 'package:lipslay_flutter_frontend/marketingpage.dart';
import 'package:lipslay_flutter_frontend/mens_massage.dart';
import 'package:lipslay_flutter_frontend/subscriptionspage.dart';
import 'package:lipslay_flutter_frontend/wholesale_salon_products.dart';
import 'package:lipslay_flutter_frontend/wholesalebeverages.dart';
import 'home_tab.dart'; // Import where your ServiceCategory and lists are defined
import 'package:lipslay_flutter_frontend/BeautyAddonPage.dart';
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

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // You can import or copy your lists here, or pass them as parameters
    final List<ServiceCategory> ladiesSalonCategories = [
      ServiceCategory(
        title: 'Beauty Add-ons',
        imageUrl: 'assets/images/beauty_addons.png',
      ),
      ServiceCategory(
        title: 'Packages',
        imageUrl: 'assets/images/packages.png',
      ),
      ServiceCategory(
        title: 'Bleach & Threading',
        imageUrl: 'assets/images/bleach_threading.png',
      ),
      ServiceCategory(title: 'Facials', imageUrl: 'assets/images/facials.png'),
      ServiceCategory(title: 'Henna', imageUrl: 'assets/images/henna.png'),
      ServiceCategory(title: 'Makeup', imageUrl: 'assets/images/makeup.png'),
      ServiceCategory(
        title: 'Manicure & Pedicure',
        imageUrl: 'assets/images/manicure_pedicure.png',
      ),
      ServiceCategory(
        title: 'Ladies Massage',
        imageUrl: 'assets/images/ladies_massage.png',
      ),
      ServiceCategory(title: 'Nails', imageUrl: 'assets/images/nails.png'),
      ServiceCategory(title: 'Waxing', imageUrl: 'assets/images/waxing.png'),
    ];
    final List<ServiceCategory> gentsSalonCategories = [
      ServiceCategory(
        title: 'Male Packages',
        imageUrl: 'assets/images/packages.png',
      ),
      // ... add all your gents categories
    ];
    final List<ServiceCategory> spaCategories = [
      ServiceCategory(
        title: "Men's Massage",
        imageUrl: 'assets/images/postpartum_massage.png',
      ),
      ServiceCategory(
        title: "Female Massage",
        imageUrl: 'assets/images/full_body_massage.png',
      ),
      // ... add all your spa categories
    ];
    final List<ServiceCategory> consultantCategories = [
      ServiceCategory(
    title: 'IT Solution',
    imageUrl: 'assets/images/it_solution.png',
  ),
  ServiceCategory(
    title: 'Marketing',
    imageUrl: 'assets/images/marketing.png',
  ),
  ServiceCategory(
    title: 'Subscriptions',
    imageUrl: 'assets/images/subscriptions.png',
  ),
      // ... add all your consultant categories
    ];
    final List<ServiceCategory> wholesalesalonCategories = [
      
    ];
    final List<ServiceCategory> servicesCategories = [
      ServiceCategory(title: 'Services', imageUrl: 'assets/images/spa.png'),
        ServiceCategory(
    title: 'Pest Control',
    imageUrl: 'assets/images/it_solution.png',
  ),
  ServiceCategory(
    title: 'Home Appliances',
    imageUrl: 'assets/images/marketing.png',
  ),
  ServiceCategory(
    title: 'Maintenance',
    imageUrl: 'assets/images/services.png',
  ),
  ServiceCategory(
    title: 'Cleaning',
    imageUrl: 'assets/images/house_maid.png',
  ),
  ServiceCategory(
    title: 'IT Services',
    imageUrl: 'assets/images/subscriptions.png',
  ),
    ];
    final List<ServiceCategory> traveleventCategories = [
       ServiceCategory(
    title: 'Holidays',
    imageUrl: 'assets/images/holidays.png',
  ),
  ServiceCategory(
    title: 'Entertainment',
    imageUrl: 'assets/images/entertainment1.png',
  ),
    ];
    final List<ServiceCategory> feelancersCategories = [
      
      
    ];
    final List<ServiceCategory> earningcoursesCategories = [
      
      
    ];
    final List<ServiceCategory> wholesaleCategories = [
      ServiceCategory(title: 'Wholesale', imageUrl: 'assets/images/spa.png'),
        ServiceCategory(
    title: 'Wholesale Beverage',
    imageUrl: 'assets/images/onlinetuition.png',
  ),
  ServiceCategory(
    title: 'Wholesale Salon\n Products',
    imageUrl: 'assets/images/personaltrainer.png',
  ),
  ServiceCategory(
    title: 'E-Commerce Stock',
    imageUrl: 'assets/images/businesscourses.png',
  ),
    ];
    final List<ServiceCategory> itsolutionCategories = [
      ServiceCategory(
        title: 'IT Solutions',
        imageUrl: 'assets/images/itsolutions.png',
      ),
      // ... add all your IT solutions categories
    ];
    final List<ServiceCategory> lpggasCategories = [
      ServiceCategory(
        title: 'LPG Gas Cylinders',
        imageUrl: 'assets/images/lpggas.png',
      ),
      // ... add all your LPG gas categories
    ];
    final List<ServiceCategory> subscriptionCategories = [
      ServiceCategory(
        title: 'Subscriptions',
        imageUrl: 'assets/images/spa.png',
      ),
      // ... add all your spa categories
    ];
    final List<ServiceCategory> educationCategories = [
      ServiceCategory(
        title: 'Education',
        imageUrl: 'assets/images/education.png',
      ),
      // ... add all your education categories
    ];
    // Add more lists as needed

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
        backgroundColor: AppColors.primarypageWhite,
        foregroundColor: AppColors.black,
      ),
      backgroundColor: AppColors.primarypageWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(context, 'Ladies Salon', ladiesSalonCategories),
              const SizedBox(height: 24),
              _buildSection(context, "Gents' Salon", gentsSalonCategories),
              const SizedBox(height: 24),
              _buildSection(context, 'SPA', spaCategories),
              const SizedBox(height: 24),
              _buildSection(context, 'Consultant', consultantCategories),
              const SizedBox(height: 24),
              _buildSection(
                context,
                'Wholesale Salon Products',
                wholesalesalonCategories,
              ),
              const SizedBox(height: 24),
              _buildSection(context, 'Services', servicesCategories),
              const SizedBox(height: 24),
              _buildSection(context, 'Travel & Events', traveleventCategories),
              const SizedBox(height: 24),
              _buildSection(context, 'Freelancers', feelancersCategories),
              const SizedBox(height: 24),
              _buildSection(
                context,
                'Earning Courses',
                earningcoursesCategories,
              ),
              const SizedBox(height: 24),
              _buildSection(context, 'Wholesale', wholesaleCategories),
              const SizedBox(height: 24),
              _buildSection(context, 'IT Solutions', itsolutionCategories),
              const SizedBox(height: 24),
              _buildSection(context, 'LPG Gas Cylinders', lpggasCategories),
              const SizedBox(height: 24),
              _buildSection(context, 'Subscriptions', subscriptionCategories),
              const SizedBox(height: 24),
              _buildSection(context, 'Education', educationCategories),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<ServiceCategory> categories,
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

  Widget _buildCategoryCard(BuildContext context, ServiceCategory category) {
    return InkWell(
      onTap: () {
        // Handle navigation to category page
        final route = categoryPageBuilders[category.title];
        if (route != null) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => route()));
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
                child: Image.asset(
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
  'Beauty Add-ons': () => const BeautyAddonPage(),
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
  // Add more mappings as needed
};
