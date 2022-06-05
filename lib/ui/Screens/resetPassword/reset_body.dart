// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_o_car_rental/viewmodel/resetpwd_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:five_o_car_rental/ui/app_bar.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:map_mvvm/map_mvvm.dart';

import '../../../app/routes.dart';

GestureDetector resetBody(BuildContext context) {
  final _key = GlobalKey<FormState>();
  String? email;
  Future _onReset(
      BuildContext context, ResetPasswordViewModel viewmodel) async {
    // Navigator.popAndPushNamed(context, Routes.login);
    bool result = await viewmodel.resetPassword(email);
    print(result);
    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect Email or Password!')),
      );
    } else {
      Navigator.popAndPushNamed(context, Routes.login);
    }
  }

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
                    onSaved: (newValue) => email = newValue,
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
                    child:
                        View<ResetPasswordViewModel>(builder: (_, viewmodel) {
                      return ElevatedButton(
                          style: raisedButtonStyle,
                          child: const Text('Reset Password'),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              _key.currentState!.save();
                              _onReset(context, viewmodel);
                            }
                          });
                    })),
              ],
            ))),
  );
}
