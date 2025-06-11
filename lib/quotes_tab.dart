import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class QuotesTabContent extends StatelessWidget {
  const QuotesTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Quotes Page Content',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
