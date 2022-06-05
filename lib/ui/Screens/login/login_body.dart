import 'package:flutter/material.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:map_mvvm/map_mvvm.dart';
import '../../../Services/auth_service.dart';
import '../../../viewmodel/login_viewmodel.dart';
import '../../app_bar.dart';

class LoginBody extends StatefulWidget {
  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _key = GlobalKey<FormState>();

  FocusNode myFocusNode = FocusNode();

  String? email;

  String? password;

  Future<void Function()?> _onSignIn(
      BuildContext context, LoginViewModel viewmodel) async {
    await viewmodel.signIn(email, password);
    viewmodel.navigator(context);
    dynamic result = await viewmodel.signIn(email, password);
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect Email or Password!')),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
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
                onSaved: (newValue) => email = newValue,
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
                onSaved: (newValue) => password = newValue,
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
                child: View<LoginViewModel>(builder: (_, viewmodel) {
                  return ElevatedButton(
                      style: raisedButtonStyle,
                      child: const Text('Login'),
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          _onSignIn(context, viewmodel);
                        }
                      });
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
                    Navigator.pushReplacementNamed(context, '/reset');
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
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
