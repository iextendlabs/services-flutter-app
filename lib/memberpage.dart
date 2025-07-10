import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lipslay_flutter_frontend/constants/api_constants.dart';
import 'dart:convert';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/book_nowPage.dart';
import 'package:lipslay_flutter_frontend/staffProfilePage.dart';
import 'staff_detailpage.dart';
// import 'package:lipslay_flutter_frontend/constants/api_constants.dart';

class OurMembersPage extends StatefulWidget {
  const OurMembersPage({Key? key}) : super(key: key);

  @override
  State<OurMembersPage> createState() => _OurMembersPageState();
}

class _OurMembersPageState extends State<OurMembersPage> {
  List<Map<String, dynamic>> staffMembers = [];
  String searchText = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStaff();
  }

  Future<void> fetchStaff() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/home'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> staff = data['staffMembers'] ?? [];
        setState(() {
          staffMembers = staff.map((e) => e as Map<String, dynamic>).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMembers =
        staffMembers.where((member) {
          final name = (member['name'] ?? '').toString().toLowerCase();
          final id = (member['id'] ?? '').toString();
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
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 18,
                              crossAxisSpacing: 8,
                              childAspectRatio: 0.85,
                            ),
                        itemBuilder: (context, index) {
                          final member = filteredMembers[index];
                          return GestureDetector(
                            onTap: () {
                              // Example navigation from member list:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => StaffProfilePage(
                                        staffId: member['id'],
                                      ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 44,
                                  backgroundColor: AppColors.white,
                                  backgroundImage:
                                      member['image'] != null &&
                                              member['image']
                                                  .toString()
                                                  .isNotEmpty
                                          ? NetworkImage(member['image'])
                                          : null,
                                  child:
                                      member['image'] == null ||
                                              member['image'].toString().isEmpty
                                          ? const Icon(
                                            Icons.person,
                                            size: 44,
                                            color: AppColors.grey,
                                          )
                                          : null,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  member['name'] ?? '',
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
                                  'Role: ${member['role'] ?? ''}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.grey,
                                    fontFamily: 'Ubuntu',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => StaffProfilePage(
                                              staffId: member['id'],
                                            ),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: AppColors.grey,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 0,
                                    ),
                                  ),
                                  child: const Text(
                                    'ViewProfile',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      fontFamily: 'Ubuntu',
                                    ),
                                  ),
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
