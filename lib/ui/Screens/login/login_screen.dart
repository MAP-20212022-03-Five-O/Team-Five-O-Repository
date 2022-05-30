import 'package:flutter/material.dart';
import 'login_body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
  static Route route() => MaterialPageRoute(builder: (_) => const LoginPage());
}

//login screen
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginBody());
  }
}
