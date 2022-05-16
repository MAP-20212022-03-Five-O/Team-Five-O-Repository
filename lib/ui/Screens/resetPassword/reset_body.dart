// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:five_o_car_rental/ui/app_bar.dart';
import 'package:five_o_car_rental/ui/button_style.dart';

GestureDetector resetBody(BuildContext context) {
  final _key = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  return GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: Scaffold(
        body: Form(
            key: _key,
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  //image here
                  height: 250,
                  width: 250,
                  child: LogoAsset(),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'Reset Password',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Enter Email'),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                    child: ElevatedButton(
                        style: raisedButtonStyle,
                        child: const Text('Reset Password'),
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: emailController.text);
                              emailController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Confirmation Email has been sent')),
                              );
                              Navigator.pushReplacementNamed(context, '/login');
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'There is no account registered under this email')),
                                );
                              } else if (e.code == 'invalid-email') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Invalid Email Input')),
                                );
                              } else {
                                return null;
                              }
                            }
                          }
                        })),
              ],
            ))),
  );
}
