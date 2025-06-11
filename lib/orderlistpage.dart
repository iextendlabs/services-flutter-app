import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:lipslay_flutter_frontend/login2page.dart';
import 'package:lipslay_flutter_frontend/notificationpage.dart';
import 'dart:convert'; // For encoding/decoding JSON
import 'package:shared_preferences/shared_preferences.dart'; // For storing authentication token

class OrderListPage extends StatefulWidget {
  final String driverId;
  final String driverEmail;

  const OrderListPage({
    super.key,
    required this.driverId,
    required this.driverEmail,
  });

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

/// The State for the OrderListPage widget.
class _OrderListPageState extends State<OrderListPage> {
  // Future that will hold the list of orders once fetched.
  late Future<List<Map<String, dynamic>>> _ordersFuture;
  // List of possible driver statuses, initialized as empty.
  // This will be populated dynamically from the backend.
  List<String> _driverStatuses = [];
  bool _isStatusesLoading = true; // Added a loading state for statuses

  // IMPORTANT: Change this URL based on your backend environment:
  // For Android Emulator: 'http://10.0.2.2:8001/api'
  // For iOS Simulator/Physical Device (if backend is on your machine): 'http://YOUR_MACHINE_LOCAL_IP:8001/api' (e.g., 'http://192.168.1.5:8001/api')
  // For Production: 'https://your-domain.com/api'
  // final String _baseUrl = 'http://127.0.0.1:8001/api';
  final String _baseUrl = 'https://test.lipslay.com/api';

  @override
  void initState() {
    super.initState();
    // First, fetch the driver statuses, then fetch orders.
    _fetchDriverStatuses().then((_) {
      setState(() {
        _isStatusesLoading = false; // Set to false once statuses are fetched
      });
      // Start fetching orders only after statuses are loaded
      _ordersFuture = _fetchOrders();
    });
  }

  /// Fetches the list of driver statuses from the Laravel backend.
  Future<void> _fetchDriverStatuses() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/driver-statuses'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          // Assuming Laravel returns a 'driver_statuses' key containing a list of strings
          _driverStatuses = List<String>.from(
            responseData['driver_statuses'] ?? [],
          );
          debugPrint('Fetched driver statuses: $_driverStatuses');
        });
      } else {
        debugPrint(
          'Failed to load driver statuses: ${response.statusCode} ${response.body}',
        );
        // Fallback to a default list if API call fails
        setState(() {
          _driverStatuses = [
            'Pending',
            'Accepted',
            'Picked Up',
            'On the Way',
            'Delivered',
            'Cancelled',
          ];
        });
      }
    } catch (e) {
      debugPrint('Error fetching driver statuses: $e');
      // Fallback to a default list if network error occurs
      setState(() {
        _driverStatuses = [
          'Pending',
          'Accepted',
          'Picked Up',
          'On the Way',
          'Delivered',
          'Cancelled',
        ];
      });
    }
  }

  /// Fetches orders for the logged-in driver from the Laravel backend API.
  Future<List<Map<String, dynamic>>> _fetchOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('driver_token');
    final int? driverId = prefs.getInt('driver_id'); // Get the stored driver ID

    // If no token or driverId is found, throw an error or redirect to login.
    if (token == null || driverId == null) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login2Page()),
          (Route<dynamic> route) => false,
        );
      }
      throw Exception(
        'Authentication information not found. Please log in again.',
      );
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/driverOrders?user_id=$driverId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Corrected: Added Authorization header
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> jsonResponse = responseData['orders'] ?? [];

        return jsonResponse.cast<Map<String, dynamic>>();
      } else if (response.statusCode == 401) {
        await prefs.remove('driver_token');
        await prefs.remove('driver_id');
        await prefs.remove('driver_email');
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login2Page()),
            (Route<dynamic> route) => false,
          );
        }
        throw Exception('Session expired. Please log in again.');
      } else {
        throw Exception(
          'Failed to load orders: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('Fetch orders error: $e');
      rethrow;
    }
  }

  /// Updates the driver status for a specific order via API call.
  Future<void> _updateOrderDriverStatus(int orderId, String newStatus) async {
    print('Flutter is sending orderId: $orderId, newStatus: $newStatus');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Updating status for Order #$orderId to $newStatus...'),
      ),
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('driver_token');
    final int? driverId = prefs.getInt(
      'driver_id',
    ); // Get the stored driver ID for the request

    // If no token or driverId is found, prevent update and potentially redirect to login.
    if (token == null || driverId == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Authentication token missing or driver ID not found. Please log in again.',
            ),
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login2Page()),
          (Route<dynamic> route) => false,
        );
      }
      return; // Stop execution if token or driver ID is missing
    }

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/driverOrderStatusUpdate'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Corrected: Added Authorization header
        },
        body: json.encode({
          'order_id': orderId,
          'driver_status': newStatus,
          'user_id': driverId,
          'text':
              'Driver status updated to "$newStatus"', // ADDED: Default text for chat
          'type': 'status_update', // ADDED: Default type for chat
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _ordersFuture = _fetchOrders(); // Re-fetch orders to update UI
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Order #$orderId status updated to $newStatus successfully!',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to update status for Order #$orderId: ${response.statusCode}',
            ),
          ),
        );
        debugPrint(
          'Failed to update order status: ${response.body}',
        ); // Log the response body for more info
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating status for Order #$orderId: $e'),
        ),
      );
      debugPrint('Order status update error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: AppColors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.remove('driver_token');
              await prefs.remove('driver_id');
              await prefs.remove('driver_email');
              if (mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login2Page()),
                  (Route<dynamic> route) => false,
                );
              }
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.delivery_dining,
                    color: AppColors.white,
                    size: 48.0,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.driverEmail,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Driver ID: ${widget.driverId}',
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.7),
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                debugPrint('Navigate to Profile Page');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${widget.driverEmail}!',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child:
                  _isStatusesLoading // Check if statuses are loading
                      ? const Center(
                        child: CircularProgressIndicator(),
                      ) // Show loading for statuses
                      : FutureBuilder<List<Map<String, dynamic>>>(
                        future: _ordersFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Failed to load orders: ${snapshot.error}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.inbox_outlined,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    'No orders yet.',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final order = snapshot.data![index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Staff Name: ${order['staff_name'] ?? 'N/A'}',
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text('Order #${order['id'] ?? 'N/A'}'),
                                        const SizedBox(height: 4.0),
                                        Text(
                                          'Status: ${order['status'] ?? 'N/A'}',
                                        ),
                                        // Dropdown to change driver_status for this order
                                        Row(
                                          children: [
                                            const Text('Driver Status: '),
                                            DropdownButton<String>(
                                              // The value must be one of the items in the list.
                                              // Ensure the current order's driver_status is part of _driverStatuses
                                              value:
                                                  _driverStatuses.contains(
                                                        order['driver_status'],
                                                      )
                                                      ? order['driver_status']
                                                      : _driverStatuses
                                                          .isNotEmpty
                                                      ? _driverStatuses
                                                          .first // Fallback to first if not found
                                                      : 'Pending', // Last resort default
                                              onChanged: (String? newValue) {
                                                if (newValue != null) {
                                                  _updateOrderDriverStatus(
                                                    order['id'],
                                                    newValue,
                                                  );
                                                }
                                              },
                                              items:
                                                  _driverStatuses.map<
                                                    DropdownMenuItem<String>
                                                  >((String value) {
                                                    return DropdownMenuItem<
                                                      String
                                                    >(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Pickup: ${order['pickup_address'] ?? 'N/A'}',
                                        ),
                                        Text(
                                          'Dropoff: ${order['dropoff_address'] ?? 'N/A'}',
                                        ),
                                        if (order['staff_number'] != null &&
                                            order['staff_number'] != 'N/A')
                                          Text(
                                            'Staff Number: ${order['staff_number']}',
                                          ),
                                        if (order['staff_whatsapp'] != null &&
                                            order['staff_whatsapp'] != 'N/A')
                                          Text(
                                            'Staff WhatsApp: ${order['staff_whatsapp']}',
                                          ),
                                        if (order['last_chat'] is Map &&
                                            order['last_chat']['text'] != null)
                                          Text(
                                            'Last Chat: ${order['last_chat']['text']}',
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
