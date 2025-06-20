import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:table_calendar/table_calendar.dart';


class BookableService {
  final String id;
  final String name;
  final String duration;
  final String imageUrl;

  BookableService({
    required this.id,
    required this.name,
    required this.duration,
    required this.imageUrl,
  });
}

class BookingTabContent extends StatefulWidget {
  const BookingTabContent({super.key});

  @override
  State<BookingTabContent> createState() => _BookingTabContentState();
}

class _BookingTabContentState extends State<BookingTabContent> {
  // Calendar related variables
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now(); // The currently visible month/year
  DateTime _selectedDay =
      DateTime.now(); // The actual selected date by the user

  String? _selectedTime;
  BookableService? _selectedService;

  // Dummy data for time slots and services (kept the same)
  final List<String> _availableTimeSlots = [
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '01:00 PM',
    '01:30 PM',
  ];

  final List<BookableService> _services = [
    BookableService(
      id: 'S001',
      name: 'Express Massage',
      duration: '30 min',
      imageUrl: 'assets/images/image3.png',
    ),
    BookableService(
      id: 'S002',
      name: 'Deep Tissue Massage',
      duration: '60 min',
      imageUrl: 'assets/images/image3.png',
    ),
    BookableService(
      id: 'S003',
      name: 'Hot Stone Massage',
      duration: '90 min',
      imageUrl: 'assets/images/image4.png',
    ),
    BookableService(
      id: 'S004',
      name: 'Aromatherapy Massage',
      duration: '60 min',
      imageUrl: 'assets/images/image2.png',
    ),
    BookableService(
      id: 'S005',
      name: 'Relaxing Facial',
      duration: '45 min',
      imageUrl: 'assets/images/image4.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay =
        DateTime.now(); // Initialize _selectedDay to a valid date, e.g., today
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarypageWhite, // Dark grey background
      // appBar: AppBar(
      //   backgroundColor:  AppColors.primarypageWhite, // Transparent AppBar
      //   elevation: 0,
      //this contain back button
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        // <--- Wrap with SingleChildScrollView
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2026, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _selectedTime = null;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: const TextStyle(
                    color: AppColors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                  leftChevronIcon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.black,
                    size: 20,
                  ),
                  rightChevronIcon: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.black,
                    size: 20,
                  ),
                  formatButtonDecoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  formatButtonTextStyle: const TextStyle(
                    color: AppColors.black,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: const TextStyle(
                    color: AppColors.black,
                    fontFamily: 'Ubuntu',
                  ),
                  weekendTextStyle: const TextStyle(
                    color: AppColors.black,
                    fontFamily: 'Ubuntu',
                  ),
                  outsideTextStyle: const TextStyle(
                    color: AppColors.calenderblueGrey,
                    fontFamily: 'Ubuntu',
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: AppColors.accentColor,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: const TextStyle(
                    color: AppColors.black,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppColors.accentColor.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: const TextStyle(
                    color: AppColors.black,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: AppColors.calendarWeekday,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                  weekendStyle: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                startingDayOfWeek: StartingDayOfWeek.sunday,
              ),
            ),
            const SizedBox(height: 30),

            // Select a time section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select a time',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _availableTimeSlots.length,
                itemBuilder: (context, index) {
                  final time = _availableTimeSlots[index];
                  final bool isSelected = _selectedTime == time;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ChoiceChip(
                      label: Text(time),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedTime = selected ? time : null;
                        });
                      },
                      selectedColor: AppColors.accentColor,
                      backgroundColor: AppColors.primarypageWhite,
                      labelStyle: TextStyle(
                        color:
                            isSelected
                                ? AppColors.white.withOpacity(0.4)
                                : AppColors.black,
                        fontFamily: 'Ubuntu',
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide.none,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),

            // Select a service section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select a service',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                final bool isSelected = _selectedService?.id == service.id;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedService = service;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppColors.accentColor.withOpacity(0.2)
                              : AppColors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                      border:
                          isSelected
                              ? Border.all(
                                color: AppColors.accentColor,
                                width: 2,
                              )
                              : null,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            service.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  width: 60,
                                  height: 60,
                                  color: AppColors.grey600,

                                  child: const Icon(
                                    Icons.broken_image,
                                    color: AppColors.white,
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.name,
                              style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              service.duration,
                              style: TextStyle(
                                color: AppColors.grey800,
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Continue Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10,
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedDay != null &&
                      _selectedTime != null &&
                      _selectedService != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Booking ${_selectedService!.name} on ${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year} at $_selectedTime',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select a date, time, and service to continue.',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
