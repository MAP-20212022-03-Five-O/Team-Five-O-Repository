import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/services/auth_service_abstract.dart';
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
  AuthServiceAbstract get _auth => locator<AuthServiceAbstract>();
  @override
  void initState() {
    super.initState();
    navigatetologin();
  }

  //function navigate login
  navigatetologin() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, Routes.login);
    } else {
      _auth.getUserByID(user.uid).then((value) {
        if (value!.userType == "owner") {
          Navigator.popAndPushNamed(context, Routes.ownerHome);
        } else {
          Navigator.popAndPushNamed(context, Routes.renterHome);
        }
      });
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
