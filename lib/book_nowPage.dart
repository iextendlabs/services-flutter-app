import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lipslay_flutter_frontend/cart_service.dart' as cart_service;
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:intl/intl.dart';
import 'package:lipslay_flutter_frontend/Checkout.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lipslay_flutter_frontend/constants/api_constants.dart';

class BookNowPage extends StatefulWidget {
  final String? serviceTitle;
  final String? serviceImage;
  final String? servicePrice;
  final String? serviceRating;

  const BookNowPage({
    Key? key,
    this.serviceTitle,
    this.serviceImage,
    this.servicePrice,
    this.serviceRating,
  }) : super(key: key);

  @override
  State<BookNowPage> createState() => _BookNowPageState();
}

class ZoneModel {
  final int id;
  final String name;
  ZoneModel({required this.id, required this.name});
  factory ZoneModel.fromJson(Map<String, dynamic> json) =>
      ZoneModel(id: json['id'], name: json['name']);
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class StaffModel {
  final int id;
  final String name;
  final String image;
  final String subTitle;
  final String phone;
  final int status;

  StaffModel({
    required this.id,
    required this.name,
    required this.image,
    required this.subTitle,
    required this.phone,
    required this.status,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
    id: json['id'],
    name: json['name'],
    image: json['image'],
    subTitle: json['sub_title'],
    phone: json['phone'],
    status: json['status'],
  );
}

class SlotModel {
  final int id;
  final String name;
  final String timeStart;
  final String timeEnd;
  final bool available;
  final int seatAvailable;
  final List<StaffModel> staff;

  SlotModel({
    required this.id,
    required this.name,
    required this.timeStart,
    required this.timeEnd,
    required this.available,
    required this.seatAvailable,
    required this.staff,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) => SlotModel(
    id: json['id'],
    name: json['name'],
    timeStart: json['time_start'],
    timeEnd: json['time_end'],
    available: json['available'],
    seatAvailable: json['seatAvailable'],
    staff:
        (json['staff'] as List<dynamic>)
            .map((s) => StaffModel.fromJson(s))
            .toList(),
  );
}

class _BookNowPageState extends State<BookNowPage> {
  final List<Map<String, dynamic>> staffs = [
    {
      'name': 'Olivia Carter',
      'status': 'Available',
      'image': 'assets/images/image4.png',
      'times': ['3:00–9:00', '4:00–5:00'],
    },
    {
      'name': 'Sophia Bennett',
      'status': 'Available',
      'image': 'assets/images/image4.png',
      'times': ['2:00–6:00', '7:00–8:00'],
    },
    {
      'name': 'Ethan Carter',
      'status': 'Busy',
      'image': 'assets/images/image4.png',
      'times': ['1:00–4:00', '5:00–7:00'],
    },
    {
      'name': 'Ava Green',
      'status': 'Available',
      'image': 'assets/images/image4.png',
      'times': ['10:00–12:00', '2:00–4:00'],
    },
    {
      'name': 'Noah Hayes',
      'status': 'Available',
      'image': 'assets/images/image4.png',
      'times': ['11:00–3:00', '4:00–6:00'],
    },
    {
      'name': 'Liam Foster',
      'status': 'Busy',
      'image': 'assets/images/image4.png',
      'times': ['9:00–11:00', '1:00–2:00'],
    },
    {
      'name': 'Olivia Davis',
      'status': 'Available',
      'image': 'assets/images/image4.png',
      'times': ['12:00–3:00', '5:00–8:00'],
    },
  ];

  List<ZoneModel> zones = [];

  int? selectedStaff = 0;
  int selectedTime = 0;
  ZoneModel? selectedZone;
  DateTime? selectedDate;

  List<SlotModel> slots = [];
  int? selectedSlotIndex;
  int? selectedStaffIndex;

  @override
  void initState() {
    super.initState();
    _loadZones();
  }

  Future<void> _loadZones() async {
    final box = await Hive.openBox('zonesBox');
    List<ZoneModel> loadedZones = [];
    // Try to load from Hive first
    final cached = box.get('zones');
    if (cached != null) {
      final List<dynamic> cachedList = json.decode(cached);
      loadedZones = cachedList.map((z) => ZoneModel.fromJson(z)).toList();
    }
    setState(() {
      zones = loadedZones;
    });
    // Always try to fetch fresh data
    try {
      final response = await http.get(
        Uri.parse('https://wishlist.lipslay.com/api/zones'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> apiZones = data['zones'] ?? [];
        final List<ZoneModel> apiZoneModels =
            apiZones.map((z) => ZoneModel.fromJson(z)).toList();
        setState(() {
          zones = apiZoneModels;
        });
        box.put('zones', json.encode(apiZones));
      }
    } catch (_) {}
  }

  Future<void> fetchSlots({required String area, required String date}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/booking/slots?area=$area&date=$date'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> slotList = data['slots'] ?? [];
      setState(() {
        slots = slotList.map((s) => SlotModel.fromJson(s)).toList();
        selectedSlotIndex = slots.isNotEmpty ? 0 : null;
        selectedStaffIndex =
            slots.isNotEmpty && slots[0].staff.isNotEmpty ? 0 : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double staffTileHeight = 80.0;
    final int maxVisibleStaff = 4;
    final slot =
        slots.isNotEmpty && selectedSlotIndex != null
            ? slots[selectedSlotIndex!]
            : null;
    final staff = slot?.staff[selectedStaffIndex!];
    final selectedTimeSlot = '${slot?.timeStart} - ${slot?.timeEnd}';
    final timeStart = slot?.timeStart ?? '';
    final timeEnd = slot?.timeEnd ?? '';
    final List<String> times = timeStart.isNotEmpty && timeEnd.isNotEmpty
        ? ['$timeStart - $timeEnd']
        : [];
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F1F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Book Now',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // WhatsApp Order
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: AppColors.green,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Order via WhatsApp',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 18),
            // Zone Dropdown (from API/Hive)
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ZoneModel>(
                  value: selectedZone,
                  hint: const Text('Select Zone'),
                  isExpanded: true,
                  items:
                      zones
                          .map(
                            (zone) => DropdownMenuItem<ZoneModel>(
                              value: zone,
                              child: Text(zone.name),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedZone = value;
                    });
                    if (selectedDate != null && selectedZone != null) {
                      fetchSlots(
                        area: selectedZone!.name,
                        date: DateFormat('yyyy-MM-dd').format(selectedDate!),
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Calendar Picker
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                    if (selectedZone != null) {
                      fetchSlots(
                        area: selectedZone!.name,
                        date: DateFormat('yyyy-MM-dd').format(picked),
                      );
                    }
                  }
                },
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    const Icon(Icons.calendar_today, color: Colors.grey),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        selectedDate != null
                            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                            : 'Select Date',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.grey),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            // Staff selection
            if (slots.isNotEmpty && selectedSlotIndex != null) ...[
              const Text(
                'Time Slot',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Ubuntu',
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                children: List.generate(slots.length, (index) {
                  final slot = slots[index];
                  final isSelected = selectedSlotIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSlotIndex = index;
                        selectedStaffIndex = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.pink : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        '${slot.name} (${slot.timeStart} - ${slot.timeEnd})',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              const Text(
                'Staff',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Ubuntu',
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height:
                    80.0 * (slots[selectedSlotIndex!].staff.length.clamp(1, 4)),
                child: ListView.builder(
                  itemCount: slots[selectedSlotIndex!].staff.length,
                  itemBuilder: (context, index) {
                    final staff = slots[selectedSlotIndex!].staff[index];
                    final isSelected = selectedStaffIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedStaffIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                isSelected ? Colors.pink : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(staff.image),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  staff.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                                Text(
                                  staff.subTitle,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
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
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Time',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(times.length, (index) {
                final isSelected = selectedTime == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.pink : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      times[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Gather selected info
                  final staff = staffs[selectedStaff ?? 0];
                  final selectedTimeSlot = times[selectedTime];
                  final selectedZoneText = selectedZone?.name ?? 'Not selected';
                  final selectedDateText =
                      selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                          : 'Not selected';

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Booking Summary'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Zone: $selectedZoneText'),
                            Text('Date: $selectedDateText'),
                            Text('Staff: ${staff['name']}'),
                            Text('Time: $selectedTimeSlot'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              cart_service.cartService.addToCart(
                                cart_service.CartItem(
                                  id:
                                      'booking_${widget.serviceTitle}_${staff['name']}_$selectedZoneText\_$selectedDateText\_$selectedTimeSlot',
                                  name:
                                      widget.serviceTitle ??
                                      '', // <-- Only the service name
                                  imageUrl: staff['image'] ?? '',
                                  price:
                                      widget.servicePrice ??
                                      'AED 0', // <-- Use the selected item's price here
                                  mins:
                                      60, // <-- Pass the correct mins if available, or set accordingly
                                  staffName: staff['name'],
                                  bookingDate: selectedDateText,
                                  bookingTime: selectedTimeSlot,
                                  quantity: 1,
                                ),
                              );
                              Navigator.of(context).pop();
                              // User stays on the booking page to continue shopping
                            },
                            child: const Text('Continue Shopping'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();

                              // Check if cart has items
                              final cartItems = cart_service.cartService.items;
                              if (cartItems.value.isNotEmpty) {
                                // Go to checkout with all cart items
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => CheckoutPage(
                                          cartItems: cartItems.value,
                                        ),
                                  ),
                                );
                              } else {
                                // Go to checkout with single service
                                final staff = staffs[selectedStaff ?? 0];
                                final selectedTimeSlot = times[selectedTime];
                                final selectedZoneText =
                                    selectedZone?.name ?? 'Not selected';
                                final selectedDateText =
                                    selectedDate != null
                                        ? DateFormat(
                                          'yyyy-MM-dd',
                                        ).format(selectedDate!)
                                        : 'Not selected';
                                final currentCartItem = cart_service.CartItem(
                                  id:
                                      'booking_${widget.serviceTitle}_${staff['name']}_$selectedZoneText\_$selectedDateText\_$selectedTimeSlot',
                                  name: widget.serviceTitle ?? '',
                                  imageUrl: staff['image'] ?? '',
                                  price: widget.servicePrice ?? 'AED 0',
                                  mins: 60,
                                  staffName: staff['name'],
                                  bookingDate: selectedDateText,
                                  bookingTime: selectedTimeSlot,
                                  quantity: 1,
                                );

                                final cartItems =
                                    cart_service.cartService.items;
                                final alreadyInCart = cartItems.value.any(
                                  (item) => item.id == currentCartItem.id,
                                );
                                if (!alreadyInCart) {
                                  cart_service.cartService.addToCart(
                                    currentCartItem,
                                  );
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => CheckoutPage(
                                          cartItems:
                                              cart_service
                                                  .cartService
                                                  .items
                                                  .value,
                                        ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                            ),
                            child: const Text('Continue to Checkout'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
