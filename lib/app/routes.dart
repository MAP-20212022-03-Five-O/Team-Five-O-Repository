import 'package:five_o_car_rental/ui/Screens/login/login_screen.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/home_screen.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/home_screen.dart';
import 'package:five_o_car_rental/ui/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String renterHome = '/renterHome';
  static const String ownerHome = '/ownerHome';

  static Route<dynamic>? createRoute(settings) {
    switch (settings.name) {
      case login:
        return LoginPage.route();
      case renterHome:
        return RenterDashboard.route();
      case ownerHome:
        return OwnerDashboard.route();
      case splash:
        return SplashScreen.route();
    }
    return null;
  }
}
