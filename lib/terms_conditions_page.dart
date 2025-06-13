import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE), // Light pink background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEBEE), // Match background color
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Terms & Condition',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Ubuntu',
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
              'Welcome to lipslay Terms and Conditions Page.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'By using our website and services, you agree to these Terms and Conditions, which, together with our Privacy Policy, govern lipslay\'s relationship with you.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 15),
            Text(
              '\'lipslay\', \'we\', \'our\', or \'us\' refer to the lipslay. The term \'you,\' \'your,\' \'the client,\' or \'user\' refers to the user of our services or the viewer of our website.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 15),
            Text(
              'The use of this website is subject to but not limited to the below terms of use:',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 15),
            Text(
              '1. The content of the pages of this website is for the explanation and implementation of our services. It is subject to change without notice.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '2. We use cookies to monitor Browse preferences. If you allow cookies to be used, the relevant personal information may be stored by us for use in fields we determine.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '3. lipslay keeps the right to change, amend, cancel, or make exceptions to the terms and conditions listed here. Please check this terms and conditions page from time to time. By using our services, you acknowledge that you agree with our terms and conditions.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '4. No partnership, joint venture, or agency is created as a result of the Terms and Conditions, and you do not have any authority of any kind to bind lipslay in any respect whatsoever. lipslay will not be liable for any failure to perform its obligations hereunder where such failure results from any reason beyond lipslay\'s reasonable control, including, without limitation, electronic, mechanical or communications failure or degradation.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '5. All materials on the website are owned by or licensed to us. This material includes, but is not limited to, layout, design, look, appearance, graphics, and such. Reproduction is strictly prohibited other than in accordance with the copyright notice, which forms part of these terms and conditions.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '6. You give your consent that you will not make unauthorized use of the materials and information on the website.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '7. We may also include links to other websites. These external links are provided for your convenience to provide further information. We are not responsible for the accuracy and correctness of the external link content.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '8. Your use of this website and any dispute arising out of such use of the website is subject to the local laws of UAE Main Courts.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '9. When you book through lipslay, we will help facilitate the services for your home needs. Once the service is done, the Fees you pay to our service professionals/3rd party service providers are non-refundable (unless there is a company-caused violation). We may update the pricing scheme on a going-forward basis. You are liable for any and all taxes (except taxes based on our income).',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '10. lipslay may change rates and fees from time to time by posting the changes on the lipslay website ten days in advance but with no advance notice mandatory for temporary promotions or any changes that result in the reduction of rates and fees.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),

            SizedBox(height: 10),
            Text(
              '11. lipslay cannot be held responsible for the unlawful acts of service professionals/3rd party service providers and users.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '12. lipslay checks the backgrounds of service professionals/3rd party service providers both directly and indirectly via third-party background check services. However, each user should exercise common sense and caution to protect their personal safety and property, just like you would when faced with any person whom you do not know.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '13. The users agree to hold lipslay free from liability for any damages and/or missing items during or after using the service professional/3rd party service provider services through lipslay.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '14. lipslay will charge you for your finalized bookings through the payment method specified on the website (e.g. a credit card or cash). If you pay any applicable charges with your credit card, we may seek pre-authorization of your credit card account prior to your purchase.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '15. If you choose to pay the fee by your credit card, you, as the cardholder, must retain a copy of transaction records and our policies and rules.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '16. You are responsible for maintaining the confidentiality of all the information in your account.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '17. If you want to cancel your booking, you are required to give a minimum of 24 hours\' notice of cancellation. The notification must be in written format and sent to lipslay@lipslay.com. We reserve the right to levy a charge of up to AED 100 to cover any relevant administrative expenses.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '18. Customers using the website who are minors/under the age of 18 shall not register as a user of the website and shall not transact on or use the website.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '19. lipslay has the right to apply penalties to its home service provider partners in the case of damage to the houses or house interiors in order to protect the community. However, what happens to the client\'s belongings and house interiors during the home service session is solely the client\'s responsibility. lipslay is not responsible for houses and interiors during the process of entering into the house or leaving the house. Service professionals/3rd party service providers or lipslay are not obliged to cover any damage(s) caused during the home service session.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '20. If any provision of this Terms and Conditions is found to be unenforceable or/and invalid, that provision shall be limited to the minimum extent necessary so that the Terms and Conditions shall otherwise be kept in full force and effect.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '21. lipslay may transfer, assign or delegate the Terms and Conditions and its rights and obligations without consent.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '22. lipslay will not trade with or provide any services to OFAC and sanctioned countries.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '23. lipslay will send messages via WhatsApp, SMS, email, or notifications as means of communication for the purposes of including but not limited to appointment confirmation, appointment updates, and marketing.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '24. lipslay is a booking platform that acts as an aggregator for different types of home services. The services are, including but not limited to, home cleaning, PCR test at home, healthcare at home, salon services, spa services, maintenance, car wash, laundry and dry cleaning, upholstery cleaning, disinfection services, and pest control. lipslay has contracts with 3rd party service providers that are licensed by the relevant authorities.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(
              height: 15,
            ), // Add a bit more space before the next section
            Text(
              'Method of Payment, Card Types, and Currency & Payment Information:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We accept payments online using Visa and MasterCard credit/debit cards in AED (or any other currency agreed upon).',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'By using your account as a payment instrument with lipslay, you are consenting to our terms of use. You may choose from various payment methods available on our Platform. We reserve the right to introduce additional payment methods or remove existing ones at our discretion. Online payments are processed by our third-party service providers, where your credit/debit card information will be stored for future bookings. lipslay does not store your credit card or payment information. Additionally, this stored information may be used for any future transactions, including but not limited to recurring appointments, outstanding payments, tips, or any other amounts due to lipslay.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Refund/Return Policy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Refunds will be done only through the Original Mode of Payment.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Quality Assurance Program / Quality Control Policy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We conduct random quality inspections on a regular basis to review the quality of our crew members\' work while they are on duty.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Here are the three methods we use in maintaining the quality checks:',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1.  Unannounced Visit - To ensure service professionals are properly uniformed and performing their duties thoroughly and completely.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 5),
            Text(
              '2.  On-Site Inspection - A walk-thru with the service professional and/or the client during regular business hours.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 5),
            Text(
              '3.  Follow-up – A brief telephone call by our customer service agents after your session has been completed.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Reporting Issues',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You can report the following issues within the timeframes below:',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '•  Missing/ stolen Items: within 48 hours.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(height: 5),
            Text(
              '•  Damaged items: within 24 hours.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(221, 48, 48, 48),
                fontFamily: 'Ubuntu',
              ),
            ),
            SizedBox(
              height: 30,
            ), // Add some space at the bottom for better scrolling
          ],
        ),
      ),
    );
  }
}
