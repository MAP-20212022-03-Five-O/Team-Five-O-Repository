import 'package:five_o_car_rental/Models/user.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/ui/app_bar.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:five_o_car_rental/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:map_mvvm/map_mvvm.dart';

class UpdateUserProfile extends StatefulWidget {
  const UpdateUserProfile({Key? key}) : super(key: key);

  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
  static Route route() =>
      MaterialPageRoute(builder: (_) => const UpdateUserProfile());
}

late final UserViewModel _userViewModel = locator.get<UserViewModel>();
late final BuildContext _context;

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  auth.User? user = auth.FirebaseAuth.instance.currentUser;
  final _key = GlobalKey<FormState>();
  FocusNode myFocusNode = FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController icController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? name;
  String? ic;
  String? phoneno;
  String? email;
  String? userType;
  String? uid;

  Future _onUpdateProfile(BuildContext context, UserViewModel viewmodel) async {
    bool result = await viewmodel.updateUserDetails(
        name, ic, phoneno, email, userType, uid);
    //print(result);
    if (result == true) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Succesfully Updated!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unsuccessful')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: StreamBuilder<User>(
          stream: _userViewModel.getUserDetails(user!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data!;
              return Scaffold(
                  body: Form(
                      key: _key,
                      child: ListView(
                        children: <Widget>[
                          const SizedBox(
                            //image here
                            height: 100,
                            width: 100,
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
                              controller: nameController..text = '${user.name}',
                              onSaved: (newValue) => name = newValue,
                              decoration: const InputDecoration(
                                counterText: '',
                                hintText: 'Full Name',
                                border: OutlineInputBorder(),
                                labelText: 'Enter Full Name',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
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
                              controller: icController..text = '${user.ic}',
                              onSaved: (newValue) => ic = newValue,
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
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
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                LengthLimitingTextInputFormatter(11),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Phone Number is empty";
                                } else {
                                  return null;
                                }
                              },
                              controller: phonenoController
                                ..text = '${user.phoneno}',
                              onSaved: (newValue) => phoneno = newValue,
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
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
                              readOnly: true,
                              controller: emailController
                                ..text = '${user.email}',
                              onSaved: (newValue) => email = newValue,
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
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
                          const SizedBox(height: 20),
                          Container(
                              height: 50,
                              padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child:
                                  View<UserViewModel>(builder: (_, viewmodel) {
                                return ElevatedButton(
                                  style: raisedButtonStyle,
                                  child: const Text('Update'),
                                  onPressed: () {
                                    if (_key.currentState!.validate()) {
                                      userType = user.userType;
                                      uid = user.uid;
                                      _key.currentState!.save();
                                      _onUpdateProfile(context, viewmodel);
                                    }
                                  },
                                );
                              })),
                          const SizedBox(height: 10),
                          Container(
                              height: 50,
                              padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: ElevatedButton(
                                style: raisedButtonStyle,
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )),
                        ],
                      )));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
