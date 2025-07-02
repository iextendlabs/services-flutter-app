import 'package:flutter/material.dart';
import 'constants/appColors.dart';

class ViewBidsPage extends StatelessWidget {
  final List<Map<String, dynamic>> bids;

  const ViewBidsPage({super.key, this.bids = const [
    {
      'bidder': 'Salon A',
      'amount': 120,
      'message': 'We offer premium service with top products.',
      'date': '2025-07-01',
    },
    {
      'bidder': 'Salon B',
      'amount': 110,
      'message': 'Affordable and professional.',
      'date': '2025-07-01',
    },
    {
      'bidder': 'Salon C',
      'amount': 130,
      'message': 'Luxury experience guaranteed.',
      'date': '2025-07-01',
    },
  ]});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Bids',
          style: TextStyle(
            color: AppColors.black,
            fontFamily: 'Ubuntu',
          ),
        ),
        backgroundColor: AppColors.primarypageWhite,
        iconTheme: const IconThemeData(color: AppColors.black),
        elevation: 0,
      ),
      backgroundColor: AppColors.primarypageWhite,
      body: bids.isEmpty
          ? const Center(
              child: Text(
                'No bids available.',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontFamily: 'Ubuntu',
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bids.length,
              itemBuilder: (context, index) {
                final bid = bids[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: AppColors.primaryDark,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bid['bidder'] ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.black,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Bid Amount: AED ${bid['amount']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.accentColor,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          bid['message'] ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.black,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Date: ${bid['date']}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.grey,
                            fontFamily: 'Ubuntu',
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
}

