import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/login2page.dart';
import 'package:flutter/gestures.dart';
import 'package:lipslay_flutter_frontend/country_code.dart';
import 'package:http/http.dart' as http;
import 'package:lipslay_flutter_frontend/constants/api_constants.dart';
import 'dart:convert';
import 'package:hive/hive.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool _agreeToTerms = false;
  String? _selectedGender;
  Map<String, dynamic> _phoneCountry = {'flag': '🇦🇪', 'code': '+971'};
  Map<String, dynamic> _whatsappCountry = {'flag': '🇦🇪', 'code': '+971'};

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _affiliateController = TextEditingController();

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
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Create New Account',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontFamily: 'Ubuntu',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please fill in the details below to create your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 15,
                  fontFamily: 'Ubuntu',
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField(
                Icons.person_outline,
                'Enter Name',
                controller: _nameController,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                Icons.alternate_email,
                'Enter Email',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                Icons.lock_outline,
                'Enter Password',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                Icons.lock_outline,
                'Confirm Password',
                obscureText: true,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 15),
              _buildPhoneInputField('Enter Phone Number', _phoneCountry, (
                country,
              ) {
                setState(() {
                  _phoneCountry = country;
                });
              }, controller: _phoneController),
              const SizedBox(height: 15),
              _buildPhoneInputField(
                'Enter Whatsapp Number',
                _whatsappCountry,
                (country) {
                  setState(() {
                    _whatsappCountry = country;
                  });
                },
                controller: _whatsappController,
              ),
              const SizedBox(height: 20),
              _buildGenderSelection(),
              const SizedBox(height: 20),
              _buildAffiliateCodeTextField(),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Checkbox(
                      value: _agreeToTerms,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _agreeToTerms = newValue!;
                        });
                      },
                      activeColor: AppColors.accentColor,
                      checkColor: AppColors.white,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.black,
                          fontFamily: 'Ubuntu',
                        ),
                        children: [
                          const TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: const TextStyle(
                              color: AppColors.accentColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Navigating to Terms and Conditions...',
                                        ),
                                      ),
                                    );
                                  },
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: AppColors.accentColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Navigating to Privacy Policy...',
                                        ),
                                      ),
                                    );
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _agreeToTerms ? _registerUser : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Signup',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: AppColors.black,
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login2Page(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    IconData icon,
    String hintText, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.black,
          fontFamily: 'Ubuntu',
        ),
        prefixIcon: Icon(icon, color: AppColors.black),
        filled: true,
        fillColor: AppColors.secondaryDark,
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
      style: const TextStyle(color: AppColors.black, fontFamily: 'Ubuntu'),
    );
  }

  Widget _buildAffiliateCodeTextField() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Enter Affiliate Code (Optional)',
        hintStyle: const TextStyle(
          color: AppColors.black87,
          fontFamily: 'Ubuntu',
        ),
        prefixIcon: const Icon(
          Icons.handshake_outlined,
          color: AppColors.black,
        ),
        filled: true,
        fillColor: AppColors.secondaryDark,
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
      style: const TextStyle(color: AppColors.black, fontFamily: 'Ubuntu'),
    );
  }

  Widget _buildPhoneInputField(
    String hintText,
    Map<String, dynamic> currentCountry,
    Function(Map<String, dynamic>) onCountrySelected, {
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.black,
          fontFamily: 'Ubuntu',
        ),
        prefixIcon: GestureDetector(
          onTap: () async {
            final selected = await showModalBottomSheet<Map<String, dynamic>>(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColors.transparent,
              builder: (BuildContext context) {
                final screenHeight = MediaQuery.of(context).size.height;
                final desiredHeight = screenHeight * 0.6;
                return SizedBox(
                  height: desiredHeight,
                  child: const CountryCodeSelectionModal(),
                );
              },
            );
            if (selected != null) {
              onCountrySelected(selected);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${currentCountry['flag'] ?? ''} ${currentCountry['code'] ?? ''}',
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.grey,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Container(width: 1, height: 24, color: AppColors.grey200),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
        filled: true,
        fillColor: AppColors.secondaryDark,
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
      style: const TextStyle(color: AppColors.black, fontFamily: 'Ubuntu'),
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender:',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.black,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedGender = 'Male';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color:
                        _selectedGender == 'Male'
                            ? AppColors.accentColor
                            : AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          _selectedGender == 'Male'
                              ? AppColors.accentColor
                              : AppColors.grey,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.male,
                        color:
                            _selectedGender == 'Male'
                                ? AppColors.white
                                : AppColors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Male',
                        style: TextStyle(
                          color:
                              _selectedGender == 'Male'
                                  ? AppColors.white
                                  : AppColors.black,
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedGender = 'Female';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color:
                        _selectedGender == 'Female'
                            ? AppColors.accentColor
                            : AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          _selectedGender == 'Female'
                              ? AppColors.accentColor
                              : AppColors.grey,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.female,
                        color:
                            _selectedGender == 'Female'
                                ? AppColors.white
                                : AppColors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Female',
                        style: TextStyle(
                          color:
                              _selectedGender == 'Female'
                                  ? AppColors.white
                                  : AppColors.black,
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _registerUser() async {
    final url = Uri.parse('https://wishlist.lipslay.com/api/register');
    final body = {
      "affiliate": _affiliateController.text.trim(),
      "email": _emailController.text.trim(),
      "gender": _selectedGender ?? "",
      "name": _nameController.text.trim(),
      "password": _passwordController.text,
      "number": "${_phoneCountry['code']}${_phoneController.text.trim()}",
      "role": "Customer",
      "whatsapp":
          "${_whatsappCountry['code']}${_whatsappController.text.trim()}",
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          data['message'] != "User already exists.") {
        // Save user data to Hive
        final box = Hive.box('userBox');
        await box.put('user', data);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registration successful!')));
        // Navigate or do something else
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Registration failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
