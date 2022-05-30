import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_o_car_rental/app/routes.dart';
import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  static Route route() =>
      MaterialPageRoute(builder: (_) => const SplashScreen());
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigatetologin();
  }

  //function navigate login
  navigatetologin() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacementNamed(context, Routes.login);
    } else if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pushReplacementNamed(context, '/renterdashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        //padding: const EdgeInsets.all(200),
        child: SizedBox(
          height: 500,
          width: 500,
          child: LogoAsset(),
        ),
      ),
    );
  }
}
