import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lipslay_flutter_frontend/booking_service.dart';

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

class _BookingTabContentState extends State<BookingTabContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildBookingTile(Booking booking) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 0,
      color: Colors.white.withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order ID: ${booking.orderId}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Ubuntu',
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Total Amount: ${booking.total}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Ubuntu',
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Status: ${booking.status}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              booking.status == 'Pending'
                                  ? Colors.orange
                                  : booking.status == 'Confirmed'
                                  ? Colors.green
                                  : Colors.red,
                          fontFamily: 'Ubuntu',
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Date: ${booking.date}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Ubuntu',
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Staff: ${booking.staff}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Ubuntu',
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Time Slot: ${booking.timeSlot}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Ubuntu',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  onSelected: (value) {
                    if (value == 'Cancel Order') {
                      setState(() {
                        final currentBookings = List<Booking>.from(
                          bookingService.bookings.value,
                        );
                        currentBookings.removeWhere(
                          (b) => b.orderId == booking.orderId,
                        );
                        bookingService.bookings.value = currentBookings;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order cancelled')),
                      );
                    }
                    // Add other actions as needed
                  },
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem(
                          value: 'Reschedule',
                          child: Text('Reschedule'),
                        ),
                        const PopupMenuItem(value: 'View', child: Text('View')),
                        const PopupMenuItem(
                          value: 'PDF Download',
                          child: Text('PDF Download'),
                        ),
                        const PopupMenuItem(
                          value: 'Share',
                          child: Text('Share'),
                        ),
                        const PopupMenuItem(
                          value: 'Cancel Order',
                          child: Text('Cancel Order'),
                        ),
                      ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingList(List<Booking> bookings) {
    if (bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Text(
            'No bookings yet!',
            style: TextStyle(
              color: AppColors.grey600,
              fontSize: 18,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
    return ListView(children: bookings.map(_buildBookingTile).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarypageWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primarypageWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: null,
        toolbarHeight: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: AppColors.primarypageWhite,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.accentColor,
              labelColor: AppColors.accentColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
                fontSize: 16,
              ),
              tabs: const [Tab(text: 'Recent'), Tab(text: 'All')],
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder<List<Booking>>(
        valueListenable: bookingService.bookings,
        builder: (context, bookings, _) {
          return TabBarView(
            controller: _tabController,
            children: [
              // Recent Tab
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: _buildBookingList(bookings.take(2).toList()),
              ),
              // All Tab
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: _buildBookingList(bookings),
              ),
            ],
          );
        },
      ),
    );
  }
}
