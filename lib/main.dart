import 'package:firebase_core/firebase_core.dart';
import 'package:five_o_car_rental/Services/database_manager.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/home_screen.dart';
import 'package:five_o_car_rental/ui/Screens/register/register_screen.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/home_screen.dart';
import 'package:five_o_car_rental/ui/Screens/resetPassword/reset_screen.dart';
import 'package:five_o_car_rental/ui/splash.dart';
import 'package:flutter/material.dart';
import 'ui/Screens/login/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<DatabaseManager>(create: (_) => DatabaseManager())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Five-O Car Rental',
            theme: ThemeData(scaffoldBackgroundColor: Colors.white),
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/reset': (context) => const ResetPage(),
              '/ownerdashboard': (context) => const OwnerDashboard(),
              '/renterdashboard': (context) => const RenterDashboard(),
            }));
  }
}
