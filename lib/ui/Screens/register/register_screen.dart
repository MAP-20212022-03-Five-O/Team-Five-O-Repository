import 'package:flutter/material.dart';
import 'register_body.dart';

enum accountType { owner, renter }

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  //by default check owner
  accountType _type = accountType.owner;

  TextEditingController icController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //set value of the user type
  set type(value) => setState(() => _type = value);

  get type => _type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RegisterBody(this));
  }
}
