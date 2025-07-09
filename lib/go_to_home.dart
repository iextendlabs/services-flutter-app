// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/categorypage.dart';
import 'package:lipslay_flutter_frontend/categorypage.dart' as catpage;
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/gents_salon.dart';

import 'package:lipslay_flutter_frontend/ladies_salon2.dart';
import 'package:lipslay_flutter_frontend/models/category_hive_model.dart';
import 'package:lipslay_flutter_frontend/quotemodel.dart';
import 'package:lipslay_flutter_frontend/quotes_repository.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:lipslay_flutter_frontend/chatbot_page.dart' as chatbot_page;
import 'package:lipslay_flutter_frontend/notificationpage.dart' as notifpage;
import 'package:lipslay_flutter_frontend/EarningCoursesPage.dart';
import 'package:lipslay_flutter_frontend/ItemView.dart';
// import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/consultant.dart';
import 'package:lipslay_flutter_frontend/education.dart';
import 'package:lipslay_flutter_frontend/freelancerspage.dart';
// import 'package:lipslay_flutter_frontend/front_end/gents_salon.dart';
import 'package:lipslay_flutter_frontend/itsolutionpage.dart';
// ignore: duplicate_import
import 'package:lipslay_flutter_frontend/ladies_salon2.dart';
import 'package:lipslay_flutter_frontend/lpg_gas.dart';
import 'package:lipslay_flutter_frontend/notificationpage.dart';
import 'package:lipslay_flutter_frontend/services.dart';
import 'package:lipslay_flutter_frontend/MASSAGES.dart';
import 'package:lipslay_flutter_frontend/subscriptionspage.dart';
import 'package:lipslay_flutter_frontend/swimmingpool.dart';
import 'package:lipslay_flutter_frontend/travel_event.dart';
import 'package:lipslay_flutter_frontend/wholesale.dart';
import 'package:lipslay_flutter_frontend/wholesale_salon_products.dart';
// ignore: duplicate_import
import 'package:url_launcher/url_launcher.dart';
import 'package:lipslay_flutter_frontend/chatbot_page.dart';

import 'package:lipslay_flutter_frontend/memberpage.dart';
import 'package:lipslay_flutter_frontend/profile_page.dart';
// ignore: duplicate_import
import 'package:lipslay_flutter_frontend/subscriptionspage.dart';

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
  final int initialTabIndex;
  const HomePage({Key? key, this.initialTabIndex = 0}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late int selectedBottomNavIndex;
  int quotesTabKey = 0;
  Offset _fabPosition = const Offset(0, 0);

  List<Widget> get _pages => [
    const HomeTabContent(), // Index 0: Home
    const SearchPage(), // Index 1: Search
    const WishlistTabContent(), // Index 2: Wishlist
    const CartTabContent(), // Index 3: Cart
    QuotesTabContent(key: ValueKey(quotesTabKey)), // Index 4: Quotes
    const BookingTabContent(), // Index 5: Booking
    const MenuTabContent(), // Index 6: Menu
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

  void onBottomNavItemTapped(int index) {
    setState(() {
      selectedBottomNavIndex = index;
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
    selectedBottomNavIndex = widget.initialTabIndex;

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

  // int _quotesTabKey = 0;

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
            selectedBottomNavIndex == 0
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
                  _pageTitles[selectedBottomNavIndex],
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
          IndexedStack(index: selectedBottomNavIndex, children: _pages),

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
                          builder:
                              (context) => const chatbot_page.ChatbotPage(),
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
                  AppColors.accentColor,
                  AppColors.primaryTextColor,
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
                  AppColors.accentColor,
                  AppColors.primaryTextColor,
                );
              },
            ),
            // ValueListenableBuilder<List<Quote>>(
            //   valueListenable: QuotesRepository.quotes,
            //   builder: (context, quotes, child) {
            //     final int quotesCount = quotes.length;
            //     return _buildBottomNavItemWithBadge(
            //       Icons.format_quote_outlined,
            //       'Quotes',
            //       quotesCount,
            //       4,
            //       AppColors.accentColor,
            //       AppColors.primaryTextColor,
            //     );
            //   },
            // ),
            _buildBottomNavItem(
              Icons.calendar_today_outlined,
              'Booking',
              5,
              AppColors.accentColor,
              AppColors.primaryTextColor,
            ),
            _buildBottomNavItem(
              Icons.person_outline,
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
    bool isSelected = selectedBottomNavIndex == index;
    return GestureDetector(
      onTap: () => onBottomNavItemTapped(index),
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
    bool isSelected = selectedBottomNavIndex == index;
    return GestureDetector(
      onTap: () => onBottomNavItemTapped(index),
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
      // backgroundColor: AppColors.primarypageWhite,
      child: FutureBuilder<List<CategoryHiveModel>>(
        future: fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: AppColors.primarypageWhite),
                  child: Text('Categories', style: TextStyle(fontSize: 20)),
                ),
                ListTile(title: Text('Failed to load categories')),
              ],
            );
          }
          final categories = snapshot.data!;
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  // color: AppColors.primarypageWhite,
                  color: AppColors.secondaryDark.withOpacity(0.9),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.accentColor.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        color: AppColors.accentColor,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Welcome, Admin!',
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'admin.@gmail.com',
                      style: TextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ...categories.map((cat) {
                final normalized = normalize(cat.title);
                final builder = catpage.categoryPageBuilders[normalized];
                final subcategories = cat.subcategories ?? [];
                final hasSub = subcategories.isNotEmpty;
                return Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:
                          hasSub
                              ? ExpansionTile(
                                title: Text(
                                  cat.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryTextColor,
                                  ),
                                ),
                                children:
                                    subcategories.map((sub) {
                                      final subNorm = normalize(sub.title);
                                      final subBuilder =
                                          catpage.categoryPageBuilders[subNorm];
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: AppColors.secondaryDark
                                              .withOpacity(0.4),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            sub.title,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color:
                                                  AppColors.secondaryTextColor,
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                            left: 32,
                                            right: 16,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          onTap:
                                              subBuilder != null
                                                  ? () {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                subBuilder(),
                                                      ),
                                                    );
                                                  }
                                                  : null,
                                          hoverColor: AppColors.accentColor
                                              .withOpacity(0.08),
                                        ),
                                      );
                                    }).toList(),
                              )
                              : ListTile(
                                title: Text(
                                  cat.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryTextColor,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onTap:
                                    builder != null
                                        ? () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => builder(),
                                            ),
                                          );
                                        }
                                        : null,
                                hoverColor: AppColors.accentColor.withOpacity(
                                  0.08,
                                ),
                              ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Divider(
                        color: AppColors.primaryTextColor.withOpacity(0.08),
                        thickness: 1,
                        height: 0,
                      ),
                    ),
                  ],
                );
              }).toList(),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      'All Categories',
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 16,
                      ),
                    ),
                    leading: Icon(
                      Icons.category_outlined,
                      color: AppColors.primaryTextColor,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CategoryPage(),
                        ),
                      );
                    },
                    dense: true,
                    hoverColor: AppColors.accentColor.withOpacity(0.08),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      'My Profile',
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 16,
                      ),
                    ),
                    leading: Icon(
                      Icons.person_outline,
                      color: AppColors.primaryTextColor,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    dense: true,
                    hoverColor: AppColors.accentColor.withOpacity(0.08),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
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
