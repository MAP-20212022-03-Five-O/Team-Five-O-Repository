import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/account_tab.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/car_tab.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/history_tab.dart';
import 'package:five_o_car_rental/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'home_appbar.dart';
import 'home_tab.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({Key? key}) : super(key: key);

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
  static Route route() =>
      MaterialPageRoute(builder: (_) => const OwnerDashboard());
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [
    const HomeTab(),
    const CarTab(),
    const HistoryTab(),
    const AccountTab(),
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
            height: 150,
          ),
          centerTitle: true, // like this!
          backgroundColor: Colors.white,
          actions: <Widget>[
            View<UserViewModel>(builder: (_, viewmodel) {
              return IconButton(
                icon: const Icon(Icons.logout, color: Colors.black, size: 30),
                tooltip: 'Logout',
                onPressed: () {
                  viewmodel.signOut();
                  Navigator.popAndPushNamed(context, Routes.login);
                },
              );
            }),
          ],
        ),
      ),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Car',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
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
