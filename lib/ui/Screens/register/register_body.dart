import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:five_o_car_rental/ui/app_bar.dart';
import '../../../services/auth_service.dart';

final _key = GlobalKey<FormState>();

TextEditingController icController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController phonenoController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
FocusNode myFocusNode = FocusNode();
final authService _auth = authService();

enum accountType { owner, renter }
accountType _type = accountType.owner;

GestureDetector registerBody(BuildContext context) {
  return GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: Scaffold(
        body: Form(
            key: _key,
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  //image here
                  height: 200,
                  width: 200,
                  child: LogoAsset(),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name is empty";
                      } else {
                        return null;
                      }
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                            color: myFocusNode.hasFocus
                                ? Colors.black
                                : Colors.black)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(12),
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "NRIC is empty";
                      } else if (value.length < 12) {
                        return "NRIC incomplete";
                      } else {
                        return null;
                      }
                    },
                    controller: icController,
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        hintText: 'NRIC',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'IC Number',
                        labelStyle: TextStyle(
                            color: myFocusNode.hasFocus
                                ? Colors.black
                                : Colors.black)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(11),
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone Number is empty";
                      } else {
                        return null;
                      }
                    },
                    controller: phonenoController,
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        hintText: 'Phoneno',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Phone Number',
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
                        return "Email is empty";
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Email Address',
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
                        return "Password is empty";
                      } else if (value.length < 8) {
                        return "Password must be atleast 8 characters";
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    controller: passwordController,
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
                // Row(
                //   children: [
                //     ListTile(
                //       title: const Text("Car Owner"),
                //       leading: Radio(
                //         value: accountType.owner,
                //         groupValue: _type,
                //         onChanged: (value) {
                //           // setState(() {
                //           //   accountType = value;
                //           // });
                //         },
                //         activeColor: Colors.green,
                //       ),
                //     ),
                //     ListTile(
                //       title: Text("Car Renter"),
                //       leading: Radio(
                //         value: accountType.renter,
                //         groupValue: _type,
                //         onChanged: (value) {
                //           // setState(() {
                //           //   val = value;
                //           // });
                //         },
                //         activeColor: Colors.green,
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                    child: ElevatedButton(
                      style: raisedButtonStyle,
                      child: const Text('Register'),
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          dynamic result = await _auth.createAccount(
                              icController.text,
                              nameController.text,
                              phonenoController.text,
                              emailController.text,
                              passwordController.text);

                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Invalid Email Address, Please Use Another Email!')),
                            );
                          } else {
                            print(result.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Account Registered! Login to continue')),
                            );
                            icController.clear();
                            nameController.clear();
                            phonenoController.clear();
                            emailController.clear();
                            passwordController.clear();
                            Navigator.pushReplacementNamed(context, '/login');
                          }
                        }
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Have an account?'),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black87,
                      ),
                      child: const Text(
                        'Login here',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              ],
            ))),
  );
}
