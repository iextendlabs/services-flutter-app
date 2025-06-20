// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/gents_salon.dart';
import 'package:lipslay_flutter_frontend/ladies_salon.dart';
import 'package:lipslay_flutter_frontend/ladies_salon2.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:lipslay_flutter_frontend/chatbot_page.dart' as chatbot_page;
import 'package:lipslay_flutter_frontend/notificationpage.dart' as notifpage;

import 'homepage2.dart'; // Make sure this path is correct if used
import 'home_tab.dart';
import 'wishlist_tab.dart';
import 'cart_tab.dart';
import 'quotes_tab.dart';
import 'booking_tab.dart';
import 'menu_tab.dart';
import 'search_tab.dart';
import 'wishlist_service.dart' as wishlist_service;
import 'cart_service.dart' as cart_service;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBottomNavIndex = 0;

  Offset _fabPosition = const Offset(0, 0);

  final List<Widget> _pages = const [
    HomeTabContent(), // Index 0: Home
    SearchPage(), // Index 1: Search
    WishlistTabContent(), // Index 2: Wishlist
    CartTabContent(), // Index 3: Cart
    QuotesTabContent(), // Index 4: Quotes
    BookingTabContent(), // Index 5: Booking
    MenuTabContent(), // Index 6: Menu
  ];

  final List<String> _pageTitles = const [
    'Lipslay Marketplace', // Home
    'Search', // Search
    'Wishlist', // Wishlist
    'Cart', // Cart
    'My Quotes', // Quotes
    'My Bookings', // Booking
    'Menu', // Menu
    // 'Home2', // Menu (for HomePage2)
  ];

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  // Function to launch WhatsApp
  Future<void> _launchWhatsApp() async {
    const String phoneNumber = '923250500849';
    const String message =
        'Hello, I would like to inquire about your services.';

    final Uri url = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );

    if (!mounted) return;

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not launch WhatsApp. Please install WhatsApp or check the number.',
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      final fabGroupHeight =
          15.0 + 5.0 + 25.0; // Approximation for initial FAB position
      final fabGroupWidth = 60.0; // Approximation for initial FAB position

      final safeAreaTop = MediaQuery.of(context).padding.top;
      final safeAreaBottom = MediaQuery.of(context).padding.bottom;

      final appBarHeight = AppBar().preferredSize.height + safeAreaTop;
      final bottomNavBarHeight = kBottomNavigationBarHeight + safeAreaBottom;

      final usableVerticalSpace =
          screenHeight - appBarHeight - bottomNavBarHeight;

      final initialFabX = screenWidth - fabGroupWidth - 20;

      // Adjusted initialFabY for better vertical centering considering app bar and bottom nav
      final initialFabY =
          appBarHeight +
          (usableVerticalSpace / 2) -
          (fabGroupHeight / 2) +
          55.0;

      setState(() {
        _fabPosition = Offset(initialFabX, initialFabY);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          AppColors.primarypageWhite, // Applied secondaryDark background
      appBar: AppBar(
        backgroundColor:
            AppColors.secondaryDark, // Applied primaryDark to app bar
        elevation: 0,
        toolbarHeight: 90.0,
        title:
            _selectedBottomNavIndex == 0
                ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lipslay Marketplace',
                      style: TextStyle(
                        color:
                            AppColors
                                .primaryTextColor, // Applied AppColors.primaryTextColor
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                    Text(
                      'Live Your Best',
                      style: TextStyle(
                        color:
                            AppColors
                                .secondaryTextColor, // Applied AppColors.secondaryTextColor
                        fontSize: 14,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ],
                )
                : Text(
                  _pageTitles[_selectedBottomNavIndex],
                  style: TextStyle(
                    color:
                        AppColors
                            .primaryTextColor, // Applied AppColors.primaryTextColor
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                    fontSize: 20,
                  ),
                ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  size: 30,
                  color:
                      AppColors
                          .primaryTextColor, // Applied AppColors.primaryTextColor
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const notifpage.NotificationsPage(),
                    ),
                  );
                },
              ),
              const Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor:
                      AppColors
                          .red, // Notification badge remains red for visibility
                  child: Text(
                    '0',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          // --- FIX START: Wrap IconButton in Builder for correct context ---
          Builder(
            builder: (BuildContext innerContext) {
              // Use a new context 'innerContext' here
              return IconButton(
                icon: Icon(
                  Icons.menu, // Standard menu icon
                  size: 30,
                  color: AppColors.primaryTextColor,
                ),
                onPressed: () {
                  // Now use innerContext, which is guaranteed to be a descendant of Scaffold
                  Scaffold.of(
                    innerContext,
                  ).openEndDrawer(); // Opens the endDrawer (right-sided)
                },
              );
            },
          ),
          // --- FIX END ---
          const SizedBox(width: 8), // Add some spacing
        ],
      ),

      body: Stack(
        children: [
          IndexedStack(index: _selectedBottomNavIndex, children: _pages),

          // Draggable FAB group
          Positioned(
            left: _fabPosition.dx,
            top: _fabPosition.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final screenHeight = MediaQuery.of(context).size.height;
                  final safeAreaTop = MediaQuery.of(context).padding.top;
                  final safeAreaBottom = MediaQuery.of(context).padding.bottom;

                  final fabGroupHeight =
                      56.0 +
                      10.0 +
                      50.0; // Estimate combined height of FABs and spacing
                  final fabGroupWidth = 60.0; // Estimate width of FABs

                  final minX = 0.0;
                  final maxX = screenWidth - fabGroupWidth;

                  final minAppbarY =
                      AppBar().preferredSize.height + safeAreaTop;
                  final maxBottomNavY =
                      screenHeight -
                      kBottomNavigationBarHeight -
                      safeAreaBottom -
                      fabGroupHeight -
                      10;

                  double newDx = _fabPosition.dx + details.delta.dx;
                  double newDy = _fabPosition.dy + details.delta.dy;

                  newDx = newDx.clamp(minX, maxX);
                  newDy = newDy.clamp(minAppbarY, maxBottomNavY);

                  _fabPosition = Offset(newDx, newDy);
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    heroTag: 'chat_fab_main',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const chatbot_page.ChatbotPage(),
                        ),
                      );
                    },
                    backgroundColor:
                        AppColors.accentColor, // Applied accentColor
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    heroTag: 'whatsapp_fab_main',
                    onPressed: _launchWhatsApp,
                    backgroundColor:
                        AppColors.primaryDark, // Applied accentColor
                    elevation: 0,
                    child: Image.asset(
                      'assets/images/whatsapp_icon.png', // Ensure this asset path is correct
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color:
              AppColors
                  .primaryDark, // Applied primaryDark to bottom nav background
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(
                0.3,
              ), // Darker shadow for dark theme
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(
              Icons.home_outlined,
              'Home',
              0,
              AppColors.accentColor,
              AppColors.primaryTextColor,
            ),
            _buildBottomNavItem(
              Icons.search,
              'Search',
              1,
              AppColors.accentColor,
              AppColors.primaryTextColor,
            ),
            ValueListenableBuilder<List<wishlist_service.WishlistItem>>(
              valueListenable: wishlist_service.wishlistService.items,
              builder: (context, wishlistItems, child) {
                final int wishlistCount = wishlistItems.length;
                return _buildBottomNavItemWithBadge(
                  Icons.favorite_outline,
                  'Wishlist',
                  wishlistCount,
                  2,
                  AppColors.accentColor, // Applied accentColor
                  AppColors
                      .primaryTextColor, // Applied AppColors.primaryTextColor
                );
              },
            ),
            ValueListenableBuilder<List<cart_service.CartItem>>(
              valueListenable: cart_service.cartService.items,
              builder: (context, cartItems, child) {
                final int cartCount = cart_service.cartService.itemCount;
                return _buildBottomNavItemWithBadge(
                  Icons.shopping_cart_outlined,
                  'Cart',
                  cartCount,
                  3,
                  AppColors.accentColor, // Applied accentColor
                  AppColors
                      .primaryTextColor, // Applied AppColors.primaryTextColor
                );
              },
            ),
            _buildBottomNavItem(
              Icons.format_quote_outlined,
              'Quotes',
              4,
              AppColors.accentColor,
              AppColors.primaryTextColor,
            ),
            _buildBottomNavItem(
              Icons.calendar_today_outlined,
              'Booking',
              5,
              AppColors.accentColor,
              AppColors.primaryTextColor,
            ),
            _buildBottomNavItem(
              Icons.menu,
              'Menu',
              6,
              AppColors.accentColor,
              AppColors.primaryTextColor,
            ),
            // _buildBottomNavItem(Icons.menu, 'Home2', 7, accentColor, AppColors.primaryTextColor),
          ],
        ),
      ),
      // Drawer is on the right side
      endDrawer: _buildAppDrawer(context),
    );
  }

  // Modified to accept accentColor and AppColors.primaryTextColor
  Widget _buildBottomNavItem(
    IconData icon,
    String label,
    int index,
    Color selectedColor,
    Color unselectedColor,
  ) {
    bool isSelected = _selectedBottomNavIndex == index;
    return GestureDetector(
      onTap: () => _onBottomNavItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color:
                isSelected
                    ? selectedColor
                    : unselectedColor.withOpacity(
                      0.7,
                    ), // Using unselected color with opacity
            size: 26,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color:
                  isSelected
                      ? selectedColor
                      : unselectedColor.withOpacity(
                        0.7,
                      ), // Using unselected color with opacity
            ),
          ),
        ],
      ),
    );
  }

  // Modified to accept accentColor and AppColors.primaryTextColor
  Widget _buildBottomNavItemWithBadge(
    IconData icon,
    String label,
    int badgeCount,
    int index,
    Color selectedColor,
    Color unselectedColor,
  ) {
    bool isSelected = _selectedBottomNavIndex == index;
    return GestureDetector(
      onTap: () => _onBottomNavItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                icon,
                color:
                    isSelected
                        ? selectedColor
                        : unselectedColor.withOpacity(
                          0.7,
                        ), // Using unselected color with opacity
                size: 26,
              ),
              if (badgeCount > 0)
                Positioned(
                  right: -5,
                  top: -5,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color:
                          AppColors.red, // Badge color remains red for emphasis
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.white, width: 1.5),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      badgeCount.toString(),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color:
                  isSelected
                      ? selectedColor
                      : unselectedColor.withOpacity(
                        0.7,
                      ), // Using unselected color with opacity
            ),
          ),
        ],
      ),
    );
  }

  // --- START: New methods for Drawer ---
  Widget _buildAppDrawer(BuildContext context) {
    return Drawer(
      backgroundColor:
          AppColors.primarypageWhite, // Background color for the drawer body
      child: ListView(
        padding: EdgeInsets.zero, // Important to remove default padding
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primarypageWhite, // Header background color
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align content to the bottom
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor:
                      AppColors
                          .primarypageWhite, // Accent color for avatar background
                  child: Icon(
                    Icons.person,
                    color: AppColors.accentColor,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Welcome, User!', // Placeholder user name
                  style: TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'user.email@example.com', // Placeholder user email
                  style: TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Categories with dropdown using ExpansionTile
          ExpansionTile(
            title: Text(
              'Categories',
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.category, color: AppColors.primaryTextColor),
            collapsedIconColor:
                AppColors.primaryTextColor, // Color when not expanded
            iconColor:
                AppColors
                    .accentColor, // Color of the expansion icon when expanded
            children: <Widget>[
              // ...existing code...
_buildDrawerItem(
  context,
  'Ladies Salon',
  Icons.spa,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LadiesSalon2Page()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'Gents Salon',
  Icons.cut, // Use a scissor icon for gents salon (Flutter 3.7+)
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'SPA',
  Icons.spa_outlined,
  onTap: () {
    // Replace with your SpaPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'Consultant',
  Icons.psychology_alt_outlined,
  onTap: () {
    // Replace with your ConsultantPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'Wholesale Services',
  Icons.storefront,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'Services',
  Icons.miscellaneous_services,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'Travel-Event',
  Icons.event,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'Freelancers',
  Icons.work_outline,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'Earning Courses',
  Icons.school_outlined,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'Wholesale',
  Icons.local_shipping,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'IT Solution',
  Icons.computer,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'LPG gas cylinder',
  Icons.local_gas_station,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'Subcriptions',
  Icons.subscriptions,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'Swimming Pool',
  Icons.pool,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'Education',
  Icons.menu_book,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GentsSalon()),
    );
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
_buildDrawerItem(
  context,
  'Show All Categories',
  Icons.more_horiz,
  onTap: () {
    Navigator.pop(context);
    print('Navigating to Other Categories');
  },
  textColor: AppColors.secondaryTextColor,
  iconColor: AppColors.secondaryTextColor,
),
            ],
          ),
          // Divider for visual separation
          Divider(color: AppColors.primaryTextColor.withOpacity(0.3)),
          // Example of other drawer items
          _buildDrawerItem(
            context,
            'My Profile',
            Icons.person_outline,
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // TODO: Implement navigation to My Profile page
              print('Navigating to My Profile');
            },
            textColor: AppColors.primaryTextColor,
            iconColor: AppColors.primaryTextColor,
          ),
          _buildDrawerItem(
            context,
            'Settings',
            Icons.settings,
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // TODO: Implement navigation to Settings page
              print('Navigating to Settings');
            },
            textColor: AppColors.primaryTextColor,
            iconColor: AppColors.primaryTextColor,
          ),
          // Add more items as needed
        ],
      ),
    );
  }

  // Helper method for building consistent drawer list tiles
  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon, {
    required VoidCallback onTap,
    required Color textColor,
    required Color iconColor,
  }) {
    return ListTile(
      title: Text(title, style: TextStyle(color: textColor, fontSize: 16)),
      leading: Icon(icon, color: iconColor),
      onTap: onTap,
      dense: true, // Makes the list tile a bit smaller
    );
  }

  // --- END: New methods for Drawer ---
}
