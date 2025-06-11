import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE), // Light pink background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEBEE), // Match background color
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Color.fromARGB(255, 205, 102, 102),
            fontWeight: FontWeight.bold,
            fontFamily: 'Ubuntu',
            fontSize: 50,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome to lipslay About Us Page.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Ubuntu',
              ),
            ),

            SizedBox(height: 15),
            Text(
              '1. Acceptance of Terms',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 194, 70, 70),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'By accessing or using this website, you agree to be bound by these terms and conditions. If you do not agree with any of these terms, you are prohibited from using or accessing this site.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '2. Use License',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 194, 70, 70),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Permission is granted to temporarily download one copy of the materials on this website for personal, non-commercial transitory viewing only.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '3. Disclaimer',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 194, 70, 70),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'The materials on this website are provided on an \'as is\' basis. The website makes no warranties, expressed or implied.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '4. Limitations',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 194, 70, 70),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'In no event shall the website or its suppliers be liable for any damages arising out of the use or inability to use the materials on this website.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '5. Revisions and Errata',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 194, 70, 70),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'The materials appearing on this website may include technical, typographical, or photographic errors.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),

            SizedBox(height: 10),
            Text(
              '6. Governing Law',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 194, 70, 70),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Any claim relating to this website shall be governed by the laws of [Your Country] without regard to its conflict of law provisions.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
