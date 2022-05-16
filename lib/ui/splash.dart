import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
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
    Navigator.pushReplacementNamed(context, '/login');
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