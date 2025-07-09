import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/go_to_home.dart';
import 'constants/appColors.dart';
import 'quotemodel.dart' as quote_model;
import 'quotes_tab.dart';
import 'quotes_repository.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class RequestQuotePage extends StatefulWidget {
  final String? initialServiceName;
  final String? initialServiceImage;
  final String? initialPhone;
  final String? initialWhatsapp;
  final String? initialLocation;
  final VoidCallback? onCheckQuotes;

  const RequestQuotePage({
    super.key,
    this.initialServiceName,
    this.initialServiceImage,
    this.initialPhone,
    this.initialWhatsapp,
    this.initialLocation,
    this.onCheckQuotes,
  });

  @override
  State<RequestQuotePage> createState() => _RequestQuotePageState();
}

class _RequestQuotePageState extends State<RequestQuotePage> {
  final _formKey = GlobalKey<FormState>();
  final _serviceNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _quantityController = TextEditingController();
  final _affiliateController = TextEditingController();
  final _locationController = TextEditingController();
  String? _selectedZone;
  String? _imagePath;

  Map<String, dynamic>? _selectedPhoneCountry;
  Map<String, dynamic>? _selectedWhatsappCountry;
  List<Map<String, dynamic>> _countries = [];

  @override
  void initState() {
    super.initState();
    _autoFillFromProfile();
    if (widget.initialServiceName != null) {
      _serviceNameController.text = widget.initialServiceName!;
    }
    _imagePath = widget.initialServiceImage;
    _phoneController.text = widget.initialPhone ?? '';
    _whatsappController.text = widget.initialWhatsapp ?? '';
    _locationController.text = widget.initialLocation ?? '';
    _loadCountries();
  }

  Future<void> _autoFillFromProfile() async {
    try {
      final response = await http.get(
        Uri.parse('https://wishlist.lipslay.com/api/getprofile'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Phone
        if (_phoneController.text.isEmpty && (data['phone'] ?? '').toString().isNotEmpty) {
          final phone = data['phone'];
          // If phone is already local (no country code), just set it
          final match = _extractCountryAndNumber(phone);
          if (match != null && match['number'] != null && match['number']!.isNotEmpty) {
            setState(() {
              _phoneController.text = match['number']!;
              _selectedPhoneCountry = _findCountryByDialCode(match['code'] ?? '');
            });
          } else if (phone != null && phone.toString().isNotEmpty) {
            setState(() {
              _phoneController.text = phone.toString();
              _selectedPhoneCountry = null;
            });
          }
        }
        // WhatsApp
        if (_whatsappController.text.isEmpty && (data['whatsapp'] ?? '').toString().isNotEmpty) {
          final whatsapp = data['whatsapp'];
          final match = _extractCountryAndNumber(whatsapp);
          if (match != null && match['number'] != null && match['number']!.isNotEmpty) {
            setState(() {
              _whatsappController.text = match['number']!;
              _selectedWhatsappCountry = _findCountryByDialCode(match['code'] ?? '');
            });
          } else if (whatsapp != null && whatsapp.toString().isNotEmpty) {
            setState(() {
              _whatsappController.text = whatsapp.toString();
              _selectedWhatsappCountry = null;
            });
          }
        }
        // Affiliate
        if (_affiliateController.text.isEmpty && (data['affiliate'] ?? '').toString().isNotEmpty) {
          setState(() {
            _affiliateController.text = data['affiliate'];
          });
        }
        // Location (if available)
        if (_locationController.text.isEmpty && (data['address'] ?? '').toString().isNotEmpty) {
          setState(() {
            _locationController.text = data['address'];
          });
        }
      }
    } catch (e) {
      // Optionally log error
    }
  }

  Map<String, String>? _extractCountryAndNumber(String input) {
    // Try to match +971 5xxxxxxx or +9715xxxxxxx or 9715xxxxxxx
    final regex = RegExp(r'^(\+?\d{1,4})[\s-]?(\d{5,})');
    final match = regex.firstMatch(input);
    if (match != null) {
      return {'code': match.group(1) ?? '', 'number': match.group(2) ?? ''};
    }
    return null;
  }

  Map<String, dynamic>? _findCountryByDialCode(String code) {
    if (_countries.isEmpty) return null;
    // Remove leading + if present
    final normalized = code.replaceAll('+', '');
    return _countries.firstWhere(
      (c) => c['dial_code'].replaceAll('+', '') == normalized,
      orElse: () => _countries.first,
    );
  }

  Future<void> _loadCountries() async {
    final String data = await rootBundle.loadString(
      'assets/data/countries.json',
    );
    final List<dynamic> jsonResult = json.decode(data);
    setState(() {
      _countries = jsonResult.cast<Map<String, dynamic>>();
      // Default to UAE if available
      _selectedPhoneCountry = _countries.firstWhere(
        (c) => c['code'] == 'AE',
        orElse: () => _countries.first,
      );
      _selectedWhatsappCountry = _selectedPhoneCountry;
    });
  }

  void _selectCountry(Function(Map<String, dynamic>) onSelected) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        TextEditingController searchController = TextEditingController();
        List<Map<String, dynamic>> filtered = List.from(_countries);
        return StatefulBuilder(
          builder: (context, setModalState) {
            void filter(String value) {
              setModalState(() {
                filtered =
                    _countries
                        .where(
                          (c) =>
                              c['name'].toLowerCase().contains(
                                value.toLowerCase(),
                              ) ||
                              c['dial_code'].contains(value),
                        )
                        .toList();
              });
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search country',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: filter,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final country = filtered[index];
                      return ListTile(
                        leading: Text(
                          country['flag'] ?? '',
                          style: const TextStyle(fontSize: 22),
                        ),
                        title: Text(country['name']),
                        trailing: Text(country['dial_code']),
                        onTap: () => Navigator.pop(context, country),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
    if (result != null) {
      onSelected(result);
    }
  }

  Widget _phoneFieldWithFlag({
    required TextEditingController controller,
    required Map<String, dynamic>? selectedCountry,
    required void Function(Map<String, dynamic>?) onCountryChanged,
    String hint = '3XXXXXXXX',
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      onChanged: (value) {
        final match = _extractCountryAndNumber(value);
        if (match != null) {
          final country = _findCountryByDialCode(match['code'] ?? '');
          // Only update the controller if the value actually changes (avoid infinite loop)
          final localNumber = match['number'] ?? value;
          if (value != localNumber && localNumber.isNotEmpty) {
            // Use WidgetsBinding to avoid setState during build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.value = TextEditingValue(
                text: localNumber,
                selection: TextSelection.collapsed(offset: localNumber.length),
              );
            });
          }
          onCountryChanged(country);
        } else {
          onCountryChanged(null);
        }
      },
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10, right: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                selectedCountry != null && selectedCountry['flag'] != null
                    ? selectedCountry['flag']
                    : '🌐',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 6),
              if (selectedCountry != null &&
                  selectedCountry['dial_code'] != null &&
                  (selectedCountry['dial_code'] as String).isNotEmpty)
                Text(
                  selectedCountry['dial_code'] + ' ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    fontSize: 15,
                    fontFamily: 'Ubuntu',
                  ),
                ),
            ],
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppColors.accentColor,
          fontSize: 15,
          fontFamily: 'Ubuntu',
        ),
        filled: true,
        fillColor: AppColors.primaryDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(
        color: AppColors.black,
        fontSize: 15,
        fontFamily: 'Ubuntu',
      ),
    );
  }

  @override
  void dispose() {
    _serviceNameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _quantityController.dispose();
    _affiliateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submitQuote() {
    if (_formKey.currentState!.validate()) {
      final quote = quote_model.Quote(
        serviceName: _serviceNameController.text,
        description: _descriptionController.text,
        phoneNumber: _phoneController.text,
        whatsappNumber: _whatsappController.text,
        sourcingQuantity: int.parse(_quantityController.text),
        affiliateCode: _affiliateController.text,
        zone: _selectedZone ?? '',
        location: _locationController.text,
        imagePath: _imagePath ?? '',
        phoneCountryCode: _selectedPhoneCountry?['dial_code'] ?? '',
        phoneCountryFlag: _selectedPhoneCountry?['flag'] ?? '',
        whatsappCountryCode: _selectedWhatsappCountry?['dial_code'] ?? '',
        whatsappCountryFlag: _selectedWhatsappCountry?['flag'] ?? '',
      );
      QuotesRepository.quotes.value = [...QuotesRepository.quotes.value, quote];
      // print('Quotes list now has ${QuotesRepository.quotes.length} items');
      // for (var q in QuotesRepository.quotes) {
      // print('Quote: ${q.serviceName}, ${q.description}');
      // }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => AlertDialog(
              title: const Text('Quote Submitted!'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text('Service Name: ${quote.serviceName}'),
                    Text('Description: ${quote.description}'),
                    Text('Phone: ${quote.phoneNumber}'),
                    Text('WhatsApp: ${quote.whatsappNumber}'),
                    Text('Quantity: ${quote.sourcingQuantity}'),
                    if (quote.affiliateCode.isNotEmpty)
                      Text('Affiliate Code: ${quote.affiliateCode}'),
                    Text('Zone: ${quote.zone}'),
                    Text('Location: ${quote.location}'),
                    if (quote.imagePath.isNotEmpty)
                      Text('Image: ${quote.imagePath}'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // QuotesRepository.quotes.add(quote);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('Return to Homepage'),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.of(context).pop(); // Close dialog
                //     Navigator.of(context).pop(); // Pop RequestQuotePage
                //     if (widget.onCheckQuotes != null) {
                //       widget.onCheckQuotes!(); // Try to switch to Quotes tab via callback
                //     } else {
                //       // Fallback: force navigation to HomePage and Quotes tab
                //       Navigator.pushAndRemoveUntil(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => HomePage(
                //             initialTabIndex: 4, // <-- You need to support this in HomePage
                //           ),
                //         ),
                //         (route) => false,
                //       );
                //     }
                //   },
                //   child: const Text('Check Quotes List'),
                // ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarypageWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primarypageWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Request a Quote',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('Service Name', required: true),
              _quoteField(
                controller: _serviceNameController,
                hint: 'Service Name',
              ),
              const SizedBox(height: 14),
              _label('Details', required: true),
              _quoteField(
                controller: _descriptionController,
                hint: 'Enter Details',
                maxLines: 5,
              ),
              const SizedBox(height: 14),
              _label('Phone Number', required: true),
              _phoneFieldWithFlag(
                controller: _phoneController,
                selectedCountry: _selectedPhoneCountry,
                onCountryChanged: (country) {
                  setState(() {
                    _selectedPhoneCountry = country;
                  });
                },
              ),
              const SizedBox(height: 14),
              _label('WhatsApp Number', required: true),
              _phoneFieldWithFlag(
                controller: _whatsappController,
                selectedCountry: _selectedWhatsappCountry,
                onCountryChanged: (country) {
                  setState(() {
                    _selectedWhatsappCountry = country;
                  });
                },
              ),
              const SizedBox(height: 14),
              _label('Sourcing Quantity', required: true),
              _quoteField(
                controller: _quantityController,
                hint: 'Sourcing Quantity',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 14),
              _label('Affiliate Code (optional)'),
              _quoteField(
                controller: _affiliateController,
                hint: 'Affiliate Code',
                required: false,
              ),
              const SizedBox(height: 14),
              _label('Select Zone', required: true),
              _zoneDropdown(),
              const SizedBox(height: 14),
              _label('Location', required: true),
              _quoteField(controller: _locationController, hint: 'Location'),
              const SizedBox(height: 22),
              _uploadImageBox(context),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitQuote,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Submit Quote',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 13,
            fontFamily: 'Ubuntu',
          ),
          children:
              required
                  ? [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                  : [],
        ),
      ),
    );
  }

  Widget _quoteField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    bool required = true,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator:
          required
              ? (value) => value == null || value.isEmpty ? 'Required' : null
              : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppColors.accentColor,
          fontSize: 15,
          fontFamily: 'Ubuntu',
        ),
        filled: true,
        fillColor: AppColors.primaryDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(
        color: AppColors.black,
        fontSize: 15,
        fontFamily: 'Ubuntu',
      ),
    );
  }

  Widget _zoneDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonFormField<String>(
        value: _selectedZone,
        decoration: const InputDecoration(border: InputBorder.none),
        hint: const Text(
          'Select Zone',
          style: TextStyle(
            color: AppColors.accentColor,
            fontSize: 18,
            fontFamily: 'Ubuntu',
          ),
        ),
        items: const [
          DropdownMenuItem(value: 'Zone 1', child: Text('Zone 1')),
          DropdownMenuItem(value: 'Zone 2', child: Text('Zone 2')),
          DropdownMenuItem(value: 'Zone 3', child: Text('Zone 3')),
        ],
        onChanged: (value) {
          setState(() {
            _selectedZone = value;
          });
        },
        validator:
            (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _uploadImageBox(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.primarypageWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.accentColor.withOpacity(0.4),
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Upload Image',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Ubuntu',
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tap to upload an image',
            style: TextStyle(
              color: AppColors.accentColor,
              fontSize: 15,
              fontFamily: 'Ubuntu',
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () {
              // Implement image picker logic here if needed
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDark,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: const Text(
              'Upload',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
