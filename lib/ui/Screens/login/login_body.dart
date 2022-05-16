import 'package:flutter/material.dart';
import 'package:five_o_car_rental/ui/Screens/login/button_style.dart';
import '../../../Services/auth_service.dart';
import 'app_bar.dart';

final _key = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
FocusNode myFocusNode = FocusNode();
final authService _auth = authService();

GestureDetector loginBody(BuildContext context) {
  return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Form(
          key: _key,
          child: ListView(
            children: <Widget>[
              const SizedBox(
                //image here
                height: 300,
                width: 300,
                child: LogoAsset(),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is empty";
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Enter Email',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? Colors.black
                              : Colors.black)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password";
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  onChanged: (value) {},
                  obscureText: true,
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? Colors.black
                              : Colors.black)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                  child: ElevatedButton(
                      style: raisedButtonStyle,
                      child: const Text('Login'),
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          dynamic result = await _auth.login(
                              emailController.text, passwordController.text);
                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Incorrect Email or Password!')),
                            );
                          } else {
                            print(result.toString());
                            emailController.clear();
                            passwordController.clear();

                            Navigator.pushReplacementNamed(
                                context, '/renterdashboard');
                          }
                        }
                      })),
              Row(
                children: <Widget>[
                  TextButton(
                    style: textButtonStyle,
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black87,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
      ));
}
