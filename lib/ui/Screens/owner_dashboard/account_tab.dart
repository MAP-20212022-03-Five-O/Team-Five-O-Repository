import 'package:five_o_car_rental/Models/user.dart';
import 'package:five_o_car_rental/Services/auth_service.dart';
import 'package:five_o_car_rental/Services/database_manager.dart';
import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AccountTab extends StatefulWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  State<AccountTab> createState() => _AccountTabState();
}

late final UserViewModel _userViewModel = locator.get<UserViewModel>();
late final BuildContext _context;

class _AccountTabState extends State<AccountTab> {
  auth.User? user = auth.FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                width: 150,
                child: CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  child: const Text(
                    'AH',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'My Profile',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              //Use Streambuilder from User Model
              StreamBuilder<User>(
                  stream: _userViewModel.getUserDetails(user!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      User user = snapshot.data!;
                      return SizedBox(
                        height: 480,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                                color: Colors.blueGrey.withOpacity(0.3),
                                width: 2),
                          ),
                          color: Colors.white,
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Colors.blueGrey))),
                                  child: const Icon(Icons.person,
                                      color: Colors.blueGrey),
                                ),
                                title: const Text(
                                  "Full Name",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    const Icon(Icons.arrow_right,
                                        color: Colors.blueGrey),
                                    Text(user.name,
                                        style: const TextStyle(
                                            color: Colors.black))
                                  ],
                                ),
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Colors.blueGrey))),
                                  child: const Icon(Icons.badge,
                                      color: Colors.blueGrey),
                                ),
                                title: const Text(
                                  "IC Number",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    const Icon(Icons.arrow_right,
                                        color: Colors.blueGrey),
                                    Text(user.ic,
                                        style: const TextStyle(
                                            color: Colors.black))
                                  ],
                                ),
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Colors.blueGrey))),
                                  child: const Icon(Icons.phone,
                                      color: Colors.blueGrey),
                                ),
                                title: const Text(
                                  "Mobile Number",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    const Icon(Icons.arrow_right,
                                        color: Colors.blueGrey),
                                    Text(user.phoneno,
                                        style: const TextStyle(
                                            color: Colors.black))
                                  ],
                                ),
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Colors.blueGrey))),
                                  child: const Icon(Icons.mail,
                                      color: Colors.blueGrey),
                                ),
                                title: const Text(
                                  "Email Address",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    const Icon(Icons.arrow_right,
                                        color: Colors.blueGrey),
                                    Text(user.email,
                                        style: const TextStyle(
                                            color: Colors.black))
                                  ],
                                ),
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Colors.blueGrey))),
                                  child: const Icon(Icons.mail,
                                      color: Colors.blueGrey),
                                ),
                                title: const Text(
                                  "User Type",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    const Icon(Icons.arrow_right,
                                        color: Colors.blueGrey),
                                    Text(user.userType,
                                        style: const TextStyle(
                                            color: Colors.black))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              const SizedBox(height: 20),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                child: View<UserViewModel>(builder: (_, viewmodel) {
                  return ElevatedButton(
                      style: raisedButtonStyle,
                      child: const Text('Update Info'),
                      onPressed: () async {
                        Navigator.pushNamed(context, Routes.updateProfile);
                      });
                }),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                child: View<UserViewModel>(builder: (_, viewmodel) {
                  return ElevatedButton(
                      style: raisedButtonStyle,
                      child: const Text('Logout'),
                      onPressed: () async {
                        await viewmodel.signOut();
                        Navigator.popAndPushNamed(context, Routes.login);
                      });
                }),
              ),
            ],
          )),
    );
  }
}
