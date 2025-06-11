import 'package:flutter/material.dart';

class StaffDetailPage extends StatelessWidget {
  final String staffName;
  final String staffPhotoUrl;
  final String description;
  final double rating;
  final List<String> services;

  const StaffDetailPage({
    Key? key,
    required this.staffName,
    required this.staffPhotoUrl,
    required this.description,
    required this.rating,
    required this.services,
  }) : super(key: key);

  Widget _buildRatingStars(double rating) {
    int fullStars = rating.floor();
    bool halfStar = (rating - fullStars) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.amber, size: 20);
        } else if (index == fullStars && halfStar) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 20);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(staffName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(staffPhotoUrl),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                staffName,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Center(child: _buildRatingStars(rating)),
            const SizedBox(height: 16),
            Text(
              'About',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              'Services',
              style: Theme.of(context).textTheme.titleMedium,
              
            ),
            Text(
              // ignore: prefer_interpolation_to_compose_strings
              description +
                  '\n\n'
                  "Want to lose weight but don’t have time for the gym? Lipslay.com brings you the ultimate weight loss at home guide — designed for busy people who want real results without expensive equipment or personal trainers.\n\n"
                  "Our expert-backed strategies include home-friendly workouts, low-calorie meal plans, fat-burning routines, and natural remedies to help you slim down effectively. Whether you’re looking to burn belly fat, drop a few kilos, or start a full-body transformation, we’ve got everything you need — right from the comfort of your home.\n\n"
                  "What You’ll Get at Lipslay.com:\n\n"
                  "✅ Easy-to-follow home workout routines (no equipment needed)\n"
                  "✅ Healthy meal prep tips and diet cheats\n"
                  "✅ Natural detox and metabolism-boosting drinks",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            ...services.map((service) => ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(service),
                )),
          ],
        ),
      ),
    );
  }
}

