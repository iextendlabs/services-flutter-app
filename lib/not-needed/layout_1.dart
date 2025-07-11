// lib/layout_1.dart

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class SpaServicesScreen extends StatelessWidget {
  const SpaServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.amber,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () {
            // Handle back button press
            // For example, if pushed, pop the current route:
            // Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Spa Services',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Featured Services',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200, // Adjust height as needed
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    FeaturedServiceCard(
                      imagePath: 'assets/images/image2.jpg',
                      title: 'Relaxing Massage',
                      duration: '60 min',
                      price: '\$120',
                    ),
                    SizedBox(width: 16),
                    FeaturedServiceCard(
                      imagePath: 'assets/images/image2.jpg',
                      title: 'Facial Rejuvenation',
                      duration: '45 min',
                      price: '\$90',
                    ),
                    SizedBox(width: 16),
                    FeaturedServiceCard(
                      imagePath: 'assets/images/image2.jpg',
                      title: 'Facial Rejuvenation',
                      duration: '45 min',
                      price: '\$90',
                    ),
                    SizedBox(width: 16),
                    FeaturedServiceCard(
                      imagePath: 'assets/images/image2.jpg',
                      title: 'Facial Rejuvenation',
                      duration: '45 min',
                      price: '\$90',
                    ),
                    SizedBox(width: 16),
                    FeaturedServiceCard(
                      imagePath: 'assets/images/image2.jpg',
                      title: 'Facial Rejuvenation',
                      duration: '45 min',
                      price: '\$90',
                    ),
                    SizedBox(width: 16),
                    FeaturedServiceCard(
                      imagePath: 'assets/images/image2.jpg',
                      title: 'Facial Rejuvenation',
                      duration: '45 min',
                      price: '\$90',
                    ),
                    SizedBox(width: 16),
                    FeaturedServiceCard(
                      imagePath: 'assets/images/image2.jpg',
                      title: 'Facial Rejuvenation',
                      duration: '45 min',
                      price: '\$90',
                    ),
                    // Add more FeaturedServiceCard widgets as needed
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'All Services',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Column(
                children: const [
                  ServiceListItem(
                    imagePath: 'assets/images/image2.jpg',
                    title: 'Swedish Massage',
                    duration: '60 min',
                    price: '\$120',
                  ),
                  ServiceListItem(
                    imagePath: 'assets/images/image2.jpg',
                    title: 'Deep Tissue Massage',
                    duration: '45 min',
                    price: '\$90',
                  ),
                  ServiceListItem(
                    imagePath: 'assets/images/image2.jpg',
                    title: 'Hot Stone Massage',
                    duration: '75 min',
                    price: '\$150',
                  ),
                  ServiceListItem(
                    imagePath: 'assets/images/image2.jpg',
                    title: 'Aromatherapy Massage',
                    duration: '60 min',
                    price: '\$100',
                  ),
                  ServiceListItem(
                    imagePath: 'assets/images/image2.jpg',
                    title: 'Express Facial',
                    duration: '45 min',
                    price: '\$80',
                  ),
                  ServiceListItem(
                    imagePath: 'assets/images/image2.jpg',
                    title: 'Anti-Aging Facial',
                    duration: '75 min',
                    price: '\$140',
                  ),
                  ServiceListItem(
                    imagePath: 'assets/images/image2.jpg',
                    title: 'Hydrating Facial',
                    duration: '60 min',
                    price: '\$110',
                  ),
                  ServiceListItem(
                    imagePath: 'assets/images/image2.jpg',
                    title: 'Detoxifying Body Wrap',
                    duration: '75 min',
                    price: '\$130',
                  ),
                  ServiceListItem(
                    imagePath: 'assets/images/image2.jpg',
                    title: 'Sugar Body Scrub',
                    duration: '60 min',
                    price: '\$100',
                  ),
                  ServiceListItem(
                    imagePath: 'assets/images/image2.jpg',
                    title: 'Mini Manicure',
                    duration: '45 min',
                    price: '\$70',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturedServiceCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String duration;
  final String price;

  const FeaturedServiceCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.duration,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 218, 161, 140),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$duration \u2022 $price',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceListItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String duration;
  final String price;

  const ServiceListItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.duration,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 218, 161, 140),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$duration \u2022 $price',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
