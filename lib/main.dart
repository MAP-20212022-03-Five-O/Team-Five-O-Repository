import 'package:flutter/material.dart';

import 'ui/Screens/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Five-O Car Rental',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
        });
  }
}
