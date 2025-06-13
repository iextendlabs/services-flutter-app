import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class ScheduleAppointmentScreen extends StatefulWidget {
  @override
  _ScheduleAppointmentScreenState createState() =>
      _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  int _selectedDayIndex = 1; // Example: April 16 is selected
  int _selectedTimeIndex = 4; // Example: 12:00 PM is selected

  // Increased the number of dates to better demonstrate horizontal scrolling
  final List<Map<String, String>> dates = [
    {'month': 'APR', 'day': '15', 'weekday': 'Sat'},
    {'month': 'APR', 'day': '16', 'weekday': 'Mon'}, // Currently selected
    {'month': 'APR', 'day': '17', 'weekday': 'Tue'},
    {'month': 'APR', 'day': '18', 'weekday': 'Wed'},
    {'month': 'APR', 'day': '19', 'weekday': 'Thu'},
    {'month': 'APR', 'day': '20', 'weekday': 'Fri'},
    {'month': 'APR', 'day': '21', 'weekday': 'Sat'},
    {'month': 'APR', 'day': '22', 'weekday': 'Sun'},
  ];

  final List<String> times = [
    '09:00 AM', '10:00 AM', '11:00 AM',
    '12:00 PM', // Currently selected
    '01:00 PM', '02:00 PM',
    '03:00 PM', '04:00 PM', '05:00 PM',
    '06:00 PM', '07:00 PM', '08:00 PM',
    '09:00 PM', // Added more times for fuller grid
  ];

  @override
  Widget build(BuildContext context) {
    // AccessAppColors from the ThemeData defined in main.dart
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color darkTextColor =
        Theme.of(context).colorScheme.onBackground; // Using colorScheme
    final Color lightTextColor =
        Theme.of(context).textTheme.bodySmall!.color!; // Using textTheme

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Navigator.pop(context); // Example: Go back to previous screen
          },
        ),
        title: Text(
          'Schedule Appointment',
          // Use textTheme for consistency
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Salon Information
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    // !!! CHANGED: From Image.network to Image.asset
                    child: Image.asset(
                      'assets/images/image2.jpg', // <--- Update this path to your image
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: AppColors.amber, size: 18),
                          Text(
                            '4.5',
                            // Use textTheme for consistency
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Text(
                        'Retro Salons',
                        // Use textTheme for consistency
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'Central Park, City Tower, New York',
                        // Use textTheme for consistency
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Select a day
              Text(
                'Select a day',
                // Use textTheme for consistency
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 15),
              Container(
                height: 100, // Fixed height for horizontal date picker
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == _selectedDayIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDayIndex = index;
                        });
                      },
                      child: Container(
                        // Removed fixed width: We'll let the content size it or use a flexible width.
                        // For a better 'full' look, consider wrapping this in Expanded inside a Row
                        // within the ListView.builder, but that makes it fixed.
                        // Keeping it like this allows more elements to scroll.
                        width:
                            75, // Slightly increased width to make them distinct
                        margin: EdgeInsets.only(
                          right: 12,
                        ), // Slightly increased margin
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? primaryColor
                                  : Theme.of(context)
                                      .colorScheme
                                      .surface, // Use theme surface color
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color:
                                isSelected ? primaryColor : AppColors.grey200!,
                          ),
                          boxShadow:
                              isSelected
                                  ? [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ]
                                  : [],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dates[index]['month']!,
                              style: TextStyle(
                                color:
                                    isSelected
                                        ? AppColors.white
                                        : lightTextColor,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              dates[index]['day']!,
                              style: TextStyle(
                                color:
                                    isSelected
                                        ? AppColors.white
                                        : darkTextColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              dates[index]['weekday']!,
                              style: TextStyle(
                                color:
                                    isSelected
                                        ? AppColors.white
                                        : lightTextColor,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30),

              // Select time
              Text(
                'Select time',
                // Use textTheme for consistency
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 15),
              GridView.builder(
                shrinkWrap: true, // Important for nested scroll views
                physics:
                    NeverScrollableScrollPhysics(), // Disable internal scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.0, // Adjust for desired button height
                ),
                itemCount: times.length,
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedTimeIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTimeIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? primaryColor
                                : Theme.of(context)
                                    .colorScheme
                                    .surface, // Use theme surface color
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: isSelected ? primaryColor : AppColors.grey200!,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            times[index].split(' ')[0], // Time part
                            style: TextStyle(
                              color:
                                  isSelected ? AppColors.white : darkTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            times[index].split(' ')[1], // AM/PM part
                            style: TextStyle(
                              color:
                                  isSelected ? AppColors.white : lightTextColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.surface, // Use theme surface color
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$93.00',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 22,
                  ), // Apply bold style and adjust size
                ),
                Text(
                  'in total',
                  style:
                      Theme.of(
                        context,
                      ).textTheme.bodySmall, // Use small body text style
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Handle book now
              },
              // Style is now mostly handled by ElevatedButtonThemeData in main.dart
              child: Text(
                'Book Now',
                style:
                    Theme.of(
                      context,
                    ).textTheme.labelLarge, // Use labelLarge for button text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
