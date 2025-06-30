import 'package:flutter/material.dart';
import 'constants/appColors.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarypageWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: AppColors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Privacy Policy',
              style: TextStyle(
                color: AppColors.accentColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 18),
            Text(
              'We are committed to safeguarding the privacy of our website visitors; this policy sets out how we will treat your personal information. Our website uses cookies. By using our website and agreeing to this policy, you consent to our use of cookies in accordance with the terms of this policy.',
              style: TextStyle(color: AppColors.black87, fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'What information do we collect?',
              style: TextStyle(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We may collect, store and use the following kinds of personal information:\n\n'
              '• information about your computer and about your visits to and use of this website (including your IP address, geographical location, browser type and version, operating system, referral source, length of visit, page views and website navigation);\n'
              '• information relating to any transactions carried out between you and us on or in relation to this website, including information relating to any purchases you make of our goods or services (including booking a cleaner through lipslay);\n'
              '• information that you provide to us for the purpose of registering with us (including your name, address and email address);\n'
              '• information that you provide to us for the purpose of subscribing to our website services, email notifications and/or newsletters (including your name and email address);\n'
              '• any other information that you choose to send to us; and\n'
              '• other information.\n\n'
              'Before you disclose to us the personal information of another person, you must obtain that person’s consent to both the disclosure and the processing of that personal information in accordance with the terms of this privacy policy.\n\n'
              'All credit/debit cards details and personally identifiable information will NOT be stored, sold, shared, rented or leased to any third parties.',
              style: TextStyle(color: AppColors.black87, fontSize: 15),
            ),
            SizedBox(height: 16),
            Text(
              '1. Cookies',
              style: TextStyle(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'A cookie is a file containing an identifier (a string of letters and numbers) that is sent by a web server to a web browser and is stored by the browser. The identifier is then sent back to the server each time the browser requests a page from the server. This enables the web server to identify and track the web browser. We may use both “session” cookie and “persistent” cookies on the website. Session cookies will be deleted from your computer when you close your browser. Persistent cookies will remain stored on your computer until deleted, or until they reach a specified expiry date. We will use the session cookies to: keep track of you whilst you navigate the website; keep track of your bookings; prevent fraud and increase website security; and [other uses]. We will use the persistent cookies to: enable our website to recognize you when you visit; keep track of your preferences in relation to your use of our website; and other uses.\n'
              'We use Google Analytics to analyze the use of this website. Google Analytics generates statistical and other information about website use by means of cookies, which are stored on users’ computers. The information generated relating to our website is used to create reports about the use of the website. Google will store this information. Google’s privacy policy is available at: http://www.google.com/privacypolicy.html. Our payment services providers may also send you cookies.',
              style: TextStyle(color: AppColors.black87, fontSize: 15),
            ),
            SizedBox(height: 16),
            Text(
              '2. Using your personal information',
              style: TextStyle(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Personal information submitted to us via this website will be used for the purposes specified in this privacy policy or in relevant parts of the website. We may use your personal information to:\n\n'
              '• administer the website;\n'
              '• improve your browsing experience by personalizing the website;\n'
              '• enable your use of the services available on the website;\n'
              '• supply to you services purchased via the website;\n'
              '• send statements and invoices to you, and collect payments from you;\n'
              '• send you general (non-marketing) commercial communications;\n'
              '• send you email notifications which you have specifically requested;\n'
              '• send you our newsletter and other marketing communications relating to our business which we think may be of interest to you, by post or, where you have specifically agreed to this, by email or similar technology (and you can inform us at any time if you no longer require marketing communications);\n'
              '• deal with enquiries and complaints made by or about you relating to the website;\n'
              '• keep the website secure and prevent fraud;\n'
              '• verify compliance with the terms and conditions governing the use of the website (including monitoring private messages sent through our website private messaging service); and\n'
              '• other uses.\n\n'
              'Where you submit personal information for publication on our website, we will publish and otherwise use that information in accordance with the licence you grant to us. We will not, without your express consent, provide your personal information to any third parties for the purpose of direct marketing. All our website credit card financial transactions are handled through our payment services provider, Checkout. You can review their privacy policy at https://www.checkout.com/legal/privacy-policy. We will share information with Checkout only to the extent necessary for the purposes of processing payments you make via our website, refunding such payments and dealing with complaints and queries relating to such payments and refunds. lipslay will neither store any debit/credit card details of users nor pass any debit/credit card details to third parties.',
              style: TextStyle(color: AppColors.black87, fontSize: 15),
            ),
            SizedBox(height: 16),
            Text(
              '3. Disclosures',
              style: TextStyle(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We may disclose your personal information to any of our employees, officers, agents, suppliers or subcontractors insofar as reasonably necessary for the purposes set out in this privacy policy. We may disclose your personal information to any member of our group of companies (this means our subsidiaries, our ultimate holding company and all its subsidiaries) insofar as reasonably necessary for the purposes set out in this privacy policy. In addition, we may disclose your personal information:\n\n'
              '• to the extent that we are required to do so by law;\n'
              '• in connection with any ongoing or prospective legal proceedings;\n'
              '• in order to establish, exercise or defend our legal rights (including providing information to others for the purposes of fraud prevention and reducing credit risk);\n'
              '• to any person who we reasonably believe may apply to a court or other competent authority for disclosure of that personal information where, in our reasonable opinion, such court or authority would be reasonably likely to order disclosure of that personal information.\n\n'
              'Except as provided in this privacy policy, we will not provide your information to third parties.',
              style: TextStyle(color: AppColors.black87, fontSize: 15),
            ),
            SizedBox(height: 16),
            Text(
              '4. International data transfers',
              style: TextStyle(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Information that we collect may be stored and processed in and transferred between any of the countries in which we operate in order to enable us to use the information in accordance with this privacy policy. In addition, personal information that you submit for publication on the website may be published on the internet and may be available, via the internet, around the world. We cannot prevent the use or misuse of such information by others.\n'
              'You expressly agree to such transfers of personal information.',
              style: TextStyle(color: AppColors.black87, fontSize: 15),
            ),
            SizedBox(height: 16),
            Text(
              '5. Security of your personal information',
              style: TextStyle(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We will take reasonable technical and organisational precautions to prevent the loss, misuse or alteration of your personal information. We will store all the personal information you provide on our secure (password- and firewall-protected) servers. All electronic transactions entered into via the website will be protected by encryption technology. You acknowledge that the transmission of information over the internet is inherently insecure, and we cannot guarantee the security of data sent over the internet. lipslay takes appropriate steps to ensure data privacy and security including through various hardware and software methodologies. However, lipslay cannot guarantee the security of any information that is disclosed online.',
              style: TextStyle(color: AppColors.black87, fontSize: 15),
            ),
            SizedBox(height: 16),
            Text(
              '6. Policy amendments',
              style: TextStyle(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We may update this privacy policy from time to time by posting a new version on our website. You should check this page occasionally to ensure you are happy with any changes. We may also notify you of changes to our privacy policy by email.',
              style: TextStyle(color: AppColors.black87, fontSize: 15),
            ),
            SizedBox(height: 16),
            Text(
              '7. Your rights',
              style: TextStyle(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'You may instruct us to provide you with any personal information we hold about you. Provision of such information will be subject to:\n\n'
              '• the payment of a fee (currently fixed at GBP £5); and\n'
              '• the supply of appropriate evidence of your identity (for this purpose, we will usually accept a photocopy of your passport certified by a solicitor or bank plus an original copy of a utility bill showing your current address).\n'
              'We may withhold such personal information to the extent permitted by law.\n'
              'You may instruct us not to process your personal information for marketing purposes, by sending an email to us at lipslay@lipslay.com. In practice, you will usually either expressly agree in advance to our use of your personal information for marketing purposes, or we will provide you with an opportunity to opt out of the use of your personal information for marketing purposes.',
              style: TextStyle(color: AppColors.black87, fontSize: 15),
            ),
            SizedBox(height: 16),
            Text(
              '8. Third party websites',
              style: TextStyle(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'The website contains links to other websites. We are not responsible for the privacy policies or practices of third party websites.',
              style: TextStyle(color: AppColors.black87, fontSize: 15),
            ),
            SizedBox(height: 16),
            Text(
              '9. Updating information',
              style: TextStyle(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please let us know if the personal information which we hold about you needs to be corrected or updated.',
              style: TextStyle(color: AppColors.black87, fontSize: 15),
            ),
            SizedBox(height: 16),
            Text(
              '10. Data Collection',
              style: TextStyle(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We collect data containing your phone number, email id, home address, latitude, and longitude. This information is provided to us when you want to make a booking. We need to contact you and find your location to provide home services. In case you wish to have this data deleted, send us an email to lipslay@lipslay.com requesting the data deletion.',
              style: TextStyle(color: AppColors.black87, fontSize: 15),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
