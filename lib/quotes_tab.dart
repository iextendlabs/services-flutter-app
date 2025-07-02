import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/viewbids.dart';
import 'constants/appColors.dart';
import 'quotemodel.dart';
import 'quotes_repository.dart';
import 'quote_detail.dart';

class QuotesTabContent extends StatefulWidget {
  const QuotesTabContent({super.key});

  @override
  State<QuotesTabContent> createState() => _QuotesTabContentState();
}

class _QuotesTabContentState extends State<QuotesTabContent> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final quotesNotifier = QuotesRepository.quotes;
    final quotes = quotesNotifier.value;
    if (quotes.isEmpty) {
      return const Center(
        child: Text(
          'No quotes submitted yet.',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontFamily: 'Ubuntu',
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: quotes.length,
      itemBuilder: (context, index) {
        final q = quotes[index];
        // For demonstration, using DateTime.now(). In real use, add a date/time field to Quote.
        final dateTime = DateTime.now();
        final formattedDate =
            "${dateTime.day}/${dateTime.month}/${dateTime.year}";
        final formattedTime =
            "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

        return Card(
          color: AppColors.primaryDark,
          margin: const EdgeInsets.only(bottom: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child:
                      q.imagePath != null && q.imagePath!.isNotEmpty
                          ? Image.asset(
                            q.imagePath!,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          )
                          : Container(
                            width: 64,
                            height: 64,
                            color: AppColors.grey200,
                            child: const Icon(
                              Icons.image,
                              color: AppColors.grey,
                            ),
                          ),
                ),
                const SizedBox(width: 16),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        q.serviceName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Source Quantity: ${q.sourcingQuantity}",
                        style: const TextStyle(
                          color: AppColors.accentColor,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Send by, Status, Date/Time in a single line below image
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Send by: ${q.phoneNumber}", // Replace with user name if available
                              style: const TextStyle(
                                color: AppColors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Status: Pending", // Replace with real status if available
                            style: const TextStyle(
                              color: AppColors.amber,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Date: $formattedDate $formattedTime",
                            style: const TextStyle(
                              color: AppColors.grey600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // Rectangle with rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12, // Slightly more height for rectangle look
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => QuoteDetailPage(
                                          fromName:
                                              "Admin", // Replace with actual data if available
                                          // fromRole: "Admin",
                                          contactNumber: q.phoneNumber,
                                          address: q.location,
                                          serviceName: q.serviceName,
                                          serviceImage: q.imagePath ?? "",
                                          quantity: q.sourcingQuantity,
                                          status: "Pending",
                                          message: q.description,
                                          whatsappNumber:
                                              q.whatsappNumber ?? "",
                                          phoneCountryCode: q.phoneCountryCode,
                                          phoneCountryFlag: q.phoneCountryFlag,
                                          whatsappCountryCode:
                                              q.whatsappCountryCode,
                                          whatsappCountryFlag:
                                              q.whatsappCountryFlag,
                                        ),
                                  ),
                                );
                              },
                              child: const Text(
                                'View Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // Rectangle with rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ViewBidsPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'View Bid',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
