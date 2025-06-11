import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:lipslay_flutter_frontend/login2page.dart';
import 'dart:convert'; // For encoding/decoding JSON
import 'package:shared_preferences/shared_preferences.dart'; // For storing authentication token

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

/// The State for the NotificationsPage widget.
class _NotificationsPageState extends State<NotificationsPage> {
  late Future<List<Map<String, dynamic>>> _notificationsFuture;

  // IMPORTANT: Base URL should be consistent with your API.
  final String _baseUrl = 'http://test.lipslay.com/api';

  @override
  void initState() {
    super.initState();
    _notificationsFuture = _fetchNotifications();
  }

  /// Fetches notifications for the logged-in user (driver).
  /// This will make an API call to your Laravel backend.
  Future<List<Map<String, dynamic>>> _fetchNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt(
      'driver_id',
    ); // Assuming notifications are tied to user_id

    if (userId == null) {
      // Handle case where user ID is not available (e.g., not logged in)
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login2Page()),
          (Route<dynamic> route) => false,
        );
      }
      throw Exception('User not logged in. Cannot fetch notifications.');
    }

    try {
      // Assuming your Laravel API has a route like '/api/notification?user_id=<userId>'
      // based on your api.php: Route::get('notification', [StaffAppController2::class, 'notification']);
      // Note: This route is in StaffAppController2, not DriverAppController.
      // You might need to adjust your Laravel backend to have a driver-specific notification route
      // or ensure StaffAppController2 handles driver notifications.
      final response = await http.get(
        Uri.parse('$_baseUrl/notification?user_id=$userId'),
        // If this route is protected by Sanctum, you'll need the token:
        // headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ${prefs.getString('driver_token')}'},
      );

      if (response.statusCode == 200) {
        // Parse the JSON response body.
        final Map<String, dynamic> responseData = json.decode(response.body);
        debugPrint(
          'Notifications API Response: $responseData',
        ); // Log the full response

        // Assuming the API returns notifications under a key like 'notifications'
        // or 'data'. Adjust 'notifications' if your API uses a different key.
        final List<dynamic> jsonResponse = responseData['notifications'] ?? [];
        // If 'notifications' key is not present or is null, it defaults to an empty list.

        return jsonResponse.cast<Map<String, dynamic>>();
      } else if (response.statusCode == 401) {
        // Unauthorized, clear token and redirect to login
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
        // Log the full response body for non-200 status codes to help debug
        debugPrint(
          'Failed to load notifications (Status: ${response.statusCode}): ${response.body}',
        );
        throw Exception(
          'Failed to load notifications: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('Fetch notifications error: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Latest Notifications:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _notificationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error loading notifications: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'No new notifications.',
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
                        final notification = snapshot.data![index];
                        // Assuming notification structure has 'title' and 'body' or similar
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.info_outline,
                              color: Colors.blueGrey,
                            ),
                            title: Text(
                              notification['title'] ?? 'No Title',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              notification['body'] ?? 'No Description',
                            ),
                            onTap: () {
                              // Handle notification tap, e.g., navigate to order details
                              debugPrint(
                                'Notification tapped: ${notification['id']}',
                              );
                            },
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
