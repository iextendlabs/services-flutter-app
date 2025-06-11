// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class MyScheduleScreen extends StatelessWidget {
  const MyScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access theme colors and text styles for consistency
    final Color darkTextColor = Theme.of(context).colorScheme.onBackground;
    final Color lightTextColor = Theme.of(context).textTheme.bodySmall!.color!;
    final Color primaryColor =
        Theme.of(
          context,
        ).primaryColor; // Used for the selected icon in bottom nav

    // Sample data for the schedule
    final List<Map<String, String>> todaySchedule = [
      {
        'service': 'Massage Therapy',
        'time': '10:00 AM - 11:00 AM',
        'image':
            'assets/images/image2.jpg', // Replace with your asset image paths
      },
      {
        'service': 'Facial Treatment',
        'time': '11:30 AM - 12:30 PM',
        'image': 'assets/images/image2.jpg',
      },
      {
        'service': 'Body Scrub',
        'time': '1:00 PM - 2:00 PM',
        'image': 'assets/images/image2.jpg',
      },
      {
        'service': 'Manicure',
        'time': '2:30 PM - 3:30 PM',
        'image': 'assets/images/image2.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu), // Hamburger menu icon
          onPressed: () {
            // Handle menu button press (e.g., open a Drawer)
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Text(
          'My Schedule',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true, // Center the title as seen in the design
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold, // Make "Today" bold
              ),
            ),
            const SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true, // Important for nested scroll views
              physics:
                  const NeverScrollableScrollPhysics(), // Disable internal scrolling
              itemCount: todaySchedule.length,
              itemBuilder: (context, index) {
                final scheduleItem = todaySchedule[index];
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15.0,
                  ), // Spacing between items
                  child: Row(
                    children: [
                      // Circular Profile Picture
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          40.0,
                        ), // Half of width/height for perfect circle
                        child: Image.asset(
                          scheduleItem['image']!, // Make sure these assets exist and are configured in pubspec.yaml
                          width: 65,
                          height: 65,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Service Name and Time
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            scheduleItem['service']!,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold, // Service name bold
                            ),
                          ),
                          Text(
                            scheduleItem['time']!,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: lightTextColor, // Lighter color for time
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            // You can add "Upcoming" or other sections here if needed
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensures all labels are shown
        backgroundColor:
            Theme.of(context).colorScheme.surface, // Background of the nav bar
        selectedItemColor: primaryColor, // Highlighted color
        unselectedItemColor: lightTextColor, // Unselected icon/text color
        selectedLabelStyle: TextStyle(fontSize: 12, color: primaryColor),
        unselectedLabelStyle: TextStyle(fontSize: 12, color: lightTextColor),
        showUnselectedLabels:
            true, // Explicitly show labels for unselected items
        currentIndex: 1, // 'Schedule' is the second item (index 1)

        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            // Custom icon for Schedule with badge
            icon: Stack(
              children: [
                const Icon(Icons.calendar_today_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: primaryColor, // Badge background color
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: const Text(
                      '12', // The number '12' from the design
                      style: TextStyle(color: AppColors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people_alt_outlined),
            label: 'Clients',
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.laptop_chromebook_outlined,
            ), // Using a laptop icon as a placeholder for 'Services'
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Handle navigation here based on the index
          // For example, using Navigator.push for different screens
          if (index == 0) {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else if (index == 1) {
            // Already on Schedule screen
          }
          // etc.
        },
      ),
    );
  }
}
