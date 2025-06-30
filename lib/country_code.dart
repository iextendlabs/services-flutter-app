import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:flutter/services.dart' show rootBundle; // For loading JSON
import 'dart:convert'; // For JSON decoding

// A simple data model for a country (updated to match JSON structure)
class Country {
  final String name;
  final String code; // ISO code, e.g., US, PK
  final String dialCode; // e.g., +1, +92
  final String flag; // Add flag property

  Country({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag, // Add flag to constructor
  });

  // Factory constructor to create a Country object from a JSON map
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      dialCode: json['dial_code']?.toString() ?? '',
      flag: json['flag']?.toString() ?? '🌐',
    );
  }
}

class CountryCodeSelectionModal extends StatefulWidget {
  const CountryCodeSelectionModal({super.key});

  @override
  State<CountryCodeSelectionModal> createState() =>
      _CountryCodeSelectionModalState();
}

class _CountryCodeSelectionModalState extends State<CountryCodeSelectionModal> {
  final TextEditingController _searchController = TextEditingController();
  List<Country> _allCountries = [];
  List<Country> _filteredCountries = [];
  bool _isLoading = true; // To show loading state

  @override
  void initState() {
    super.initState();
    _loadCountries();
    _searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCountries);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCountries() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/countries.json',
      );
      final List<dynamic> data = json.decode(response);
      setState(() {
        _allCountries = data.map((json) => Country.fromJson(json)).toList();
        // Sort the countries alphabetically by name
        _allCountries.sort((a, b) => a.name.compareTo(b.name));
        _filteredCountries = _allCountries; // Initialize with all countries
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading countries: $e');
      setState(() {
        _isLoading = false;
      });
      // Optionally show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load country list.')),
      );
    }
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = _allCountries;
      } else {
        _filteredCountries =
            _allCountries.where((country) {
              return country.name.toLowerCase().contains(query) ||
                  country.dialCode.toLowerCase().contains(query);
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFFEBEE),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize
                .min, // Essential to make the column take minimal height
        children: [
          // Drag handle
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.grey200,
              borderRadius: BorderRadius.circular(2),
            ),
            margin: const EdgeInsets.only(bottom: 16),
          ),
          const Text(
            'Select Country Code',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              fontFamily: 'Ubuntu',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search country or code',
              hintStyle: const TextStyle(
                color: AppColors.grey,
                fontFamily: 'Ubuntu',
              ),
              prefixIcon: const Icon(Icons.search, color: AppColors.black),
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.accentColor,
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 20.0,
              ),
            ),
            style: const TextStyle(
              color: AppColors.black,
              fontFamily: 'Ubuntu',
            ),
          ),
          const SizedBox(height: 16),
          _isLoading
              ? const Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.accentColor,
                  ),
                ),
              )
              : Expanded(
                // Changed Flexible to Expanded for better filling of available space within the modal's height
                child: ListView.builder(
                  // shrinkWrap: true, // No longer needed with Expanded in a sized parent
                  itemCount: _filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = _filteredCountries[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        leading: Text(
                          country.flag,
                          style: const TextStyle(
                            fontSize: 24,
                          ), // Show flag emoji
                        ),
                        title: Text(
                          country.name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        trailing: Text(
                          country.dialCode, // Use dialCode from JSON
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentColor,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(
                            context,
                            {
                              'flag': country.flag,
                              'code': country.dialCode,
                            }, // Pass both flag and code back
                          );
                        },
                      ),
                      );
                  },
                ),
              ),
        ],
      ),
    );
  }
}
