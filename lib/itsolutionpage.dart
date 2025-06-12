import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class ITSolutionPage extends StatefulWidget {
  @override
  _ITSolutionPageState createState() => _ITSolutionPageState();
}

class _ITSolutionPageState extends State<ITSolutionPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> items = [
    {
      'name': 'Social Media support',
      'stars': 4.5,
      'time': '60 MINS',
      'liked': false,
      'image': 'assets/images/consultant.png',
    },
    {
      'name': 'Network Security Audit',
      'stars': 4.0,
      'time': '50 MINS',
      'liked': false,
      'image': 'assets/images/ladies_salon.png',
    },
    {
      'name': 'Custom CRM Development',
      'stars': 5.0,
      'time': '50 MINS',
      'liked': false,
      'image': 'assets/images/makeup.png',
    },

    
    {
      'name': 'Enterprise Whatsapp',
      'stars': 4.8,
      'time': '50 MINS',
      'liked': false,
      'image': 'assets/images/nails.png',
    },
    {
      'name': 'IT Infrastructure Setup',
      'stars': 4.2,
      'time': '50 MINS',
      'liked': false,
      'image': 'assets/images/consultant.png',
    },
    {
      'name': 'Data Backup Solutions',
      'stars': 4.6,
      'time': '50 MINS',
      'liked': false,
'image': 'assets/images/henna.png',
    },
    {
      'name': 'Cloud Migration Services',
      'stars': 4.9,
      'time': '50 MINS',
      'liked': false,
      'image': 'assets/images/consultant.png',
    },
    {
      'name': 'IT Consulting',
      'stars': 4.3,
      'time': '50 MINS',
      'liked': false,
      'image': 'assets/images/consultant.png',
    }
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredItems =
        items
            .where(
              (item) => item['name'].toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(title: Text('IT Solution Page')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search IT solutions...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                var item = filteredItems[index];
                // ...existing code...
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8),
                        CircleAvatar( 
                          radius: 28,
                          backgroundColor: AppColors.primarypageWhite,
                          backgroundImage: item['image'] != null ? AssetImage(item['image']) : null,
  child: item['image'] == null
      ? const Icon(Icons.computer, size: 32, color: AppColors.grey)
      : null,
),
                        const SizedBox(width: 12),
                        // Make the text flexible
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: AppColors.accentColor,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text('${item['stars']}'),
                                  const SizedBox(width: 16),
                                
                                ],

                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    color: AppColors.grey,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(item['time']),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                item['liked']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: item['liked'] ? AppColors.accentColor : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  item['liked'] = !item['liked'];
                                });
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Implement login to quote action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primarypageWhite,
                                foregroundColor: AppColors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 0,
                                ),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Login to Quote'),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                );
                // ...existing code...
              },
            ),
          ),
        ],
      ),
    );
  }
}
