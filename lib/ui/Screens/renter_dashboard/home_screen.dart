import 'package:five_o_car_rental/ui/Screens/renter_dashboard/account_tab.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/booking_tab.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/explore_tab.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/home_appbar.dart';
import 'package:flutter/material.dart';

class RenterDashboard extends StatefulWidget {
  const RenterDashboard({Key? key}) : super(key: key);

  @override
  State<RenterDashboard> createState() => _RenterDashboardState();
}

class _RenterDashboardState extends State<RenterDashboard> {
  int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [
    const ExploreTab(),
    const BookingTab(),
    const RenterAccountTab(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: _pageIndex, // new
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Booking',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account')
        ],
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  void onTabTapped(int index) async {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

    setState(() {
      _pageIndex = index;
    });
  }

  //logout
  // Future<void> _signOut() async {
  //   await FirebaseAuth.instance.signOut();
  // }
}
