// import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:lipslay_flutter_frontend/chatbot_page.dart';
// import 'package:lipslay_flutter_frontend/notificationpage.dart';

// // Your actual tab content files
// import 'home_tab.dart';
// import 'wishlist_tab.dart';
// import 'cart_tab.dart';
// import 'quotes_tab.dart';
// import 'booking_tab.dart';
// import 'menu_tab.dart';
// import 'search_tab.dart';
// import 'wishlist_service.dart';
// import 'cart_service.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedBottomNavIndex = 0;

//   Offset _fabPosition = const Offset(0, 0);

//   // Define how many items should be visible without scrolling
//   final int _visibleBottomNavItems = 4; // Can be 3 or 4 as per your request

//   final List<Widget> _pages = const [
//     HomeTabContent(),
//     SearchPage(),
//     CartTabContent(),
//     WishlistTabContent(),
//     QuotesTabContent(),
//     BookingTabContent(),
//     MenuTabContent(),
//   ];

//   final List<IconData> _bottomNavIcons = const [
//     Icons.home_outlined,
//     Icons.search_outlined,
//     Icons.shopping_bag_outlined,
//     Icons.favorite_outline,
//     Icons.format_quote_outlined,
//     Icons.calendar_today_outlined,
//     Icons.menu,
//   ];

//   final List<String> _pageTitles = const [
//     'Lipslay Marketplace',
//     'Search',
//     'Cart',
//     'Wishlist',
//     'Quotes',
//     'Booking',
//     'Menu',
//   ];

//   // GlobalKey to get the size and position of the individual bottom nav items
//   // Its length MUST match _bottomNavIcons.length
//   // FIX: Declare as 'late' and initialize in initState
//   late final List<GlobalKey> _bottomNavItemKeys;

//   // GlobalKey for the Row inside the SingleChildScrollView, to correctly calculate indicator position
//   final GlobalKey _bottomNavRowKey = GlobalKey();

//   // Variables for the animated circular indicator
//   double _indicatorX = 0.0;
//   double _indicatorWidth = 0.0;
//   double _indicatorHeight = 0.0;

//   late PageController _pageController; // Using PageController for `PageView`
//   late ScrollController
//       _bottomNavScrollController; // Controller for horizontal scrolling of bottom nav items

//   void _onBottomNavItemTapped(int index) {
//     setState(() {
//       _selectedBottomNavIndex = index;
//       // Animate to the corresponding page in PageView
//       _pageController.animateToPage(
//         index,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     });
//     // Ensure the indicator position and scroll are updated after the page has jumped
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _updateIndicatorPosition();
//     });
//   }

//   // Function to launch WhatsApp
//   Future<void> _launchWhatsApp() async {
//     const String phoneNumber = '923250500849';
//     const String message =
//         'Hello, I would like to inquire about your services.';

//     final Uri url = Uri.parse(
//       'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
//     );

//     if (!mounted) return;

//     if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Could not launch WhatsApp. Please install WhatsApp or check the number.',
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _selectedBottomNavIndex);
//     _bottomNavScrollController = ScrollController();

//     // FIX: Initialize _bottomNavItemKeys here in initState
//     _bottomNavItemKeys =
//         List.generate(_bottomNavIcons.length, (index) => GlobalKey());

//     // Listener for PageView to update selected index
//     _pageController.addListener(() {
//       final double page = _pageController.page ?? 0.0;
//       final int newIndex = page.round();
//       if (newIndex != _selectedBottomNavIndex) {
//         setState(() {
//           _selectedBottomNavIndex = newIndex;
//         });
//       }
//       // Update indicator position immediately during page scroll for smooth animation
//       _updateIndicatorPosition();
//     });

//     // Initialize FAB position and initial indicator position after layout is built
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _updateFabPosition();
//       _updateIndicatorPosition(); // Set initial indicator position after initial layout
//     });
//   }

//   void _updateFabPosition() {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     final fabGroupHeight = 56.0 + 10.0 + 50.0;
//     final fabGroupWidth = 60.0;

//     final safeAreaTop = MediaQuery.of(context).padding.top;
//     final safeAreaBottom = MediaQuery.of(context).padding.bottom;

//     final customBottomNavBarOverallHeight =
//         kBottomNavigationBarHeight + 10 + 20;

//     final initialFabX = screenWidth - fabGroupWidth - 20;
//     final initialFabY = screenHeight -
//         safeAreaBottom -
//         customBottomNavBarOverallHeight -
//         fabGroupHeight -
//         110;

//     setState(() {
//       _fabPosition = Offset(initialFabX, initialFabY);
//     });
//   }

//   void _updateIndicatorPosition() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_selectedBottomNavIndex >= _bottomNavItemKeys.length ||
//           _bottomNavItemKeys[_selectedBottomNavIndex].currentContext == null ||
//           _bottomNavRowKey.currentContext == null || // Ensure the Row is rendered
//           !_bottomNavScrollController.hasClients) {
//         return;
//       }

//       final RenderBox selectedItemRenderBox = _bottomNavItemKeys[
//               _selectedBottomNavIndex]
//           .currentContext!
//           .findRenderObject() as RenderBox;

//       final RenderBox scrollContentRenderBox =
//           _bottomNavRowKey.currentContext!.findRenderObject() as RenderBox;

//       final Offset itemLocalOffsetInRow = selectedItemRenderBox.localToGlobal(
//         Offset.zero,
//         ancestor: scrollContentRenderBox,
//       );

//       final double itemWidth = selectedItemRenderBox.size.width;
//       final double itemHeight = selectedItemRenderBox.size.height;

//       setState(() {
//         _indicatorWidth = itemWidth * 0.7;
//         _indicatorHeight = itemHeight * 0.7;

//         _indicatorX =
//             itemLocalOffsetInRow.dx + (itemWidth / 2) - (_indicatorWidth / 2);
//       });

//       final double screenWidth = MediaQuery.of(context).size.width;
//       final double barHorizontalPadding = 20.0;
//       final double viewableAreaWidth = screenWidth - 2 * barHorizontalPadding;

//       final double itemCenterInScrollContent =
//           itemLocalOffsetInRow.dx + itemWidth / 2;

//       // Calculate the target scroll offset to center the item in the visible portion of the nav bar
//       final double targetScrollOffset =
//           itemCenterInScrollContent - (viewableAreaWidth / 2);

//       _bottomNavScrollController.animateTo(
//         targetScrollOffset.clamp(
//             0.0, _bottomNavScrollController.position.maxScrollExtent),
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _bottomNavScrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(
//           0xFFFFEBEE), // Your existing background color
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFFFEBEE),
//         elevation: 0,
//         toolbarHeight: 90.0,
//         leading: Align(
//           alignment: Alignment.centerLeft,
//           child: SizedBox(
//             width: 120.0,
//             height: 120.0,
//             child: Image.asset(
//               'assets/images/lotus_flower.png',
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         title: _selectedBottomNavIndex == 0
//             ? Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [
//                   Text(
//                     'Lipslay Marketplace',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22,
//                       fontFamily: 'Ubuntu',
//                     ),
//                   ),
//                   Text(
//                     'Live Your Best',
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 107, 107, 107),
//                       fontSize: 14,
//                       fontFamily: 'Ubuntu',
//                     ),
//                   ),
//                 ],
//               )
//             : Text(
//                 // Use the page titles for the app bar title for other tabs
//                 _pageTitles[_selectedBottomNavIndex],
//                 style: const TextStyle(
//                   color: Color.fromARGB(255, 214, 107, 107),
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Ubuntu',
//                   fontSize: 20,
//                 ),
//               ),
//         centerTitle: true,
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.notifications_none,
//                   size: 30,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const NotificationsPage(),
//                     ),
//                   );
//                 },
//               ),
//               const Positioned(
//                 right: 5,
//                 top: 5,
//                 child: CircleAvatar(
//                   radius: 8,
//                   backgroundColor: Colors.red,
//                   child: Text(
//                     '0', // Notification count (replace with genuine count if available)
//                     style: TextStyle(
//                       color:AppColors.white,
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           // Using PageView to display the content of the selected tab
//           PageView(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 _selectedBottomNavIndex = index;
//               });
//               _updateIndicatorPosition(); // Ensure indicator updates on swipe
//             },
//             // The PageView will display the widgets returned by these classes
//             children: _pages.sublist(0, _bottomNavIcons.length),
//           ),
//           Positioned(
//             left: _fabPosition.dx,
//             top: _fabPosition.dy,
//             child: GestureDetector(
//               onPanUpdate: (details) {
//                 setState(() {
//                   final screenWidth = MediaQuery.of(context).size.width;
//                   final screenHeight = MediaQuery.of(context).size.height;
//                   final safeAreaTop = MediaQuery.of(context).padding.top;
//                   final safeAreaBottom = MediaQuery.of(context).padding.bottom;

//                   final fabGroupHeight = 56.0 + 10.0 + 50.0;
//                   final fabGroupWidth = 60.0;

//                   final minX = 0.0;
//                   final maxX = screenWidth - fabGroupWidth;

//                   final minAppbarY =
//                       AppBar().preferredSize.height + safeAreaTop;

//                   // Get the overall height of the custom bottom navigation bar
//                   final customBottomNavBarOverallHeight =
//                       kBottomNavigationBarHeight +
//                           10 +
//                           20; // barHeight + bottom padding

//                   final maxBottomNavY = screenHeight -
//                       safeAreaBottom -
//                       customBottomNavBarOverallHeight -
//                       fabGroupHeight -
//                       10;

//                   double newDx = _fabPosition.dx + details.delta.dx;
//                   double newDy = _fabPosition.dy + details.delta.dy;

//                   newDx = newDx.clamp(minX, maxX);
//                   newDy = newDy.clamp(minAppbarY, maxBottomNavY);

//                   _fabPosition = Offset(newDx, newDy);
//                 });
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   FloatingActionButton(
//                     heroTag: 'chat_fab_main',
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const ChatbotPage()),
//                       );
//                     },
//                     backgroundColor: const Color.fromARGB(255, 190, 47, 94),
//                     child: const Icon(Icons.chat_bubble_outline,
//                         color:AppColors.white),
//                   ),
//                   const SizedBox(height: 10),
//                   FloatingActionButton(
//                     heroTag: 'whatsapp_fab_main',
//                     onPressed: _launchWhatsApp,
//                     backgroundColor:AppColors.white,
//                     elevation: 0,
//                     child: Image.asset(
//                       'assets/images/whatsapp_icon.png',
//                       width: 100,
//                       height: 100,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Custom floating, pill-shaped bottom navigation bar
//           _buildModernBottomNavBarWithCircles(),
//         ],
//       ),
//       bottomNavigationBar: _buildModernBottomNavBarWithCircles(), 
//     );
//   }

//   Widget _buildModernBottomNavBarWithCircles() {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double barHorizontalPadding =
//         20.0; 

//     final double itemWidth =
//         (screenWidth - 2 * barHorizontalPadding) / _visibleBottomNavItems;
//     final double barHeight =
//         kBottomNavigationBarHeight + 10; 
//     return Positioned(
//       bottom: 40, 
      
//       left: barHorizontalPadding,
//       right: barHorizontalPadding,
//       child: Container(
//         height: barHeight,
//         decoration: BoxDecoration(
//           color:AppColors.white,
//           borderRadius:
//               BorderRadius.circular(barHeight / 2), // Fully rounded ends
//           boxShadow: [
//             BoxShadow(
//               color:
//                   Colors.black.withOpacity(0.2), // Darker shadow for floating effect
//               spreadRadius: 2,
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             // The animated circular indicator (black filled circle with purple ring)
//             AnimatedPositioned(
//               duration: const Duration(milliseconds: 200),
//               curve: Curves.easeInOut,
//               left: _indicatorX,
//               top: (barHeight - _indicatorHeight) / 5, // Center vertically
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 150),
//                 curve: Curves.easeInOut,
//                 width: _indicatorWidth,
//                 height: _indicatorHeight,
               
//               ),
//             ),
//             // Scrollable navigation items
//             SingleChildScrollView(
//               controller: _bottomNavScrollController,
//               scrollDirection: Axis.horizontal,
//               physics: const ClampingScrollPhysics(), // Prevent overscroll bounce
//               child: Row(
//                 key: _bottomNavRowKey, // Assign GlobalKey to the Row
//                 children: List.generate(_bottomNavIcons.length, (index) {
//                   final icon = _bottomNavIcons[index];
//                   bool isSelected = _selectedBottomNavIndex == index;

//                   return GestureDetector(
//                     key: _bottomNavItemKeys[index], // Assign GlobalKey here
//                     onTap: () => _onBottomNavItemTapped(index),
//                     child: SizedBox(
//                       width: itemWidth, // Fixed width for each item (allows scrolling)
//                       height: barHeight,
//                       child: Center(
//                         child: Stack(
//                           clipBehavior: Clip.none, // Allow badge to overflow
//                           children: [
//                             Icon(
//                               icon,
//                               color: isSelected
//                                   ? const Color.fromARGB(255, 13, 13,
//                                       13) // White icon when selected
//                                   : Colors.grey, // Grey when unselected
//                               size: 26,
//                             ),
//                             // Apply badge only to Cart (shopping_bag_outlined) and Wishlist (favorite_outline)
//                             if (icon == Icons.shopping_bag_outlined) // For Cart
//                               ValueListenableBuilder<List<CartItem>>(
//                                 valueListenable:
//                                     cartService.items, // Uses your genuine service
//                                 builder: (context, cartItems, child) {
//                                   final int cartCount = cartItems.length;
//                                   return (cartCount > 0)
//                                       ? Positioned(
//                                           right: -5,
//                                           top: -5,
//                                           child: Container(
//                                             padding: const EdgeInsets.all(2),
//                                             decoration: const BoxDecoration(
//                                               color: Color.fromARGB(255, 148,
//                                                   41, 41), // Green badge color
//                                               // borderRadius: BorderRadius.circular(10),
//                                               // border: Border.all(color:AppColors.white, width: 1.5),
//                                             ),
//                                             constraints: const BoxConstraints(
//                                               minWidth: 16,
//                                               minHeight: 16,
//                                             ),
//                                             child: Text(
//                                               cartCount.toString(),
//                                               style: const TextStyle(
//                                                 color:AppColors.white,
//                                                 fontSize: 9,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           ),
//                                         )
//                                       : const SizedBox.shrink();
//                                 },
//                               ),
//                             if (icon == Icons.favorite_outline) // For Wishlist
//                               ValueListenableBuilder<List<WishlistItem>>(
//                                 valueListenable:
//                                     wishlistService.items, // Uses your genuine service
//                                 builder: (context, wishlistItems, child) {
//                                   final int wishlistCount =
//                                       wishlistItems.length;
//                                   return (wishlistCount > 0)
//                                       ? Positioned(
//                                           right: -5,
//                                           top: -5,
//                                           child: Container(
//                                             padding: const EdgeInsets.all(2),
//                                             decoration: BoxDecoration(
//                                               color: Colors.green, // Green badge color (consistent with cart)
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               border: Border.all(
//                                                   color:AppColors.white,
//                                                   width: 1.5),
//                                             ),
//                                             constraints: const BoxConstraints(
//                                               minWidth: 16,
//                                               minHeight: 16,
//                                             ),
//                                             child: Text(
//                                               wishlistCount.toString(),
//                                               style: const TextStyle(
//                                                 color:AppColors.white,
//                                                 fontSize: 9,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           ),
//                                         )
//                                       : const SizedBox.shrink();
//                                 },
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }