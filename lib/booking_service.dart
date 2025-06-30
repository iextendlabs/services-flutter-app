import 'package:flutter/material.dart';

class Booking {
  final String orderId;
  final String total;
  final String status;
  final String date;
  final String staff;
  final String timeSlot;

  Booking({
    required this.orderId,
    required this.total,
    required this.status,
    required this.date,
    required this.staff,
    required this.timeSlot,
  });

  Color get statusColor {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class BookingService {
  final bookings = ValueNotifier<List<Booking>>([]);

  void addBooking(Booking booking) {
    bookings.value = [...bookings.value, booking];
  }
}

final bookingService = BookingService();
