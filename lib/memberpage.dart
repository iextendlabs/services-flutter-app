import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'staff_detailpage.dart'; // Import your staff detail page

class OurMembersPage extends StatefulWidget {
  const OurMembersPage({Key? key}) : super(key: key);

  @override
  State<OurMembersPage> createState() => _OurMembersPageState();
}

class _OurMembersPageState extends State<OurMembersPage> {
  final List<Map<String, String>> members = [
    {
      'name': 'Sophia Bennett',
      'id': '12345',
      'image': 'assets/images/image4.png',
    },
    {
      'name': 'Ethan Carter',
      'id': '67890',
      'image': 'assets/images/image4.png',
    },
    {
      'name': 'Olivia Davis',
      'id': '24680',
      'image': 'assets/images/image4.png',
    },
    {
      'name': 'Liam Foster',
      'id': '13579',
      'image': 'assets/images/image4.png',
    },
    {
      'name': 'Ava Green',
      'id': '97531',
      'image': 'assets/images/image4.png',
    },
    {
      'name': 'Noah Hayes',
      'id': '86420',
      'image': 'assets/images/image4.png',
    },
  ];

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredMembers = members.where((member) {
      final name = member['name']!.toLowerCase();
      final id = member['id']!;
      return name.contains(searchText.toLowerCase()) ||
          id.contains(searchText);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.primarypageWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primarypageWhite,
        elevation: 0,
        title: const Text(
          'Our Members',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Ubuntu',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: AppColors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: filteredMembers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final member = filteredMembers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StaffDetailPage(
                            staffName: member['name']!,
                            staffPhotoUrl: member['image']!,
                            description: 'Member ID: ${member['id']}',
                            rating: 4.5,
                            services: const [],
                            availableSlots: '3:00–9:00, 11:00–3:00', // Pass the slots here

                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 44,
                          backgroundColor: AppColors.white,
                          backgroundImage: AssetImage(member['image']!),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          member['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.black,
                            fontFamily: 'Ubuntu',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Member ID: ${member['id']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                            fontFamily: 'Ubuntu',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}