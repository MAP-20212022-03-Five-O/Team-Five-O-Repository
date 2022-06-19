import 'package:five_o_car_rental/ui/Screens/login/login_screen.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/addcar_screen.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/home_screen.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/update_profile.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/view_car_details.dart';
import 'package:five_o_car_rental/ui/Screens/register/register_screen.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/booking_tab.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/home_screen.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/search_vehicle_list.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/view_all_available_vehicle.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/view_car_details.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/view_rent_details.dart';
import 'package:five_o_car_rental/ui/Screens/resetPassword/reset_screen.dart';
import 'package:five_o_car_rental/ui/splash.dart';
import 'package:flutter/material.dart';

import '../ui/Screens/owner_dashboard/car_tab.dart';
import '../ui/Screens/owner_dashboard/update_car.dart';

class Routes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String renterHome = '/renterHome';
  static const String ownerHome = '/ownerHome';
  static const String resetpwd = '/resetpwd';
  static const String register = '/register';
  static const String carTab = '/carTab';
  static const String addcar = '/addcar';
  static const String carDetails = '/carDetails';
  static const String updateCar = '/updateCar';
  static const String updateProfile = '/updateProfile';
  static const String viewAllVehicles = '/viewAllVehicles';
  static const String bookingTab = '/bookingTab';
  static const String rentDetails = '/rentDetails';

  static Route<dynamic>? createRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return LoginPage.route();
      case renterHome:
        return RenterDashboard.route();
      case ownerHome:
        return OwnerDashboard.route();
      case splash:
        return SplashScreen.route();
      case resetpwd:
        return ResetPage.route();
      case register:
        return RegisterPage.route();
      case carTab:
        return CarTab.route();
      case addcar:
        return AddCar.route();
      case carDetails:
        return ViewDetailsScreen.route(settings.arguments.toString());
      case updateCar:
        return UpdateCarScreen.route(settings.arguments.toString());
      case updateProfile:
        return UpdateUserProfile.route();
      case viewAllVehicles:
        return ViewAllVehicles.route();
      case bookingTab:
        return BookingTab.route();
      case rentDetails:
        return ViewRentDetails.route(settings.arguments.toString());
    }
    return null;
  }
}
