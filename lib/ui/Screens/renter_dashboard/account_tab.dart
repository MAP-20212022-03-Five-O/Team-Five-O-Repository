import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:five_o_car_rental/ui/button_style.dart';

class RenterAccountTab extends StatefulWidget {
  const RenterAccountTab({Key? key}) : super(key: key);

  @override
  State<RenterAccountTab> createState() => _RenterAccountTabState();
}

class _RenterAccountTabState extends State<RenterAccountTab> {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = const AssetImage('../assets/images/profile.png');
    Image image = Image(image: assetImage);

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
                child: image,
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
              SizedBox(
                height: 380,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                        color: Colors.blueGrey.withOpacity(0.3), width: 2),
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
                                      width: 1.0, color: Colors.blueGrey))),
                          child:
                              const Icon(Icons.person, color: Colors.blueGrey),
                        ),
                        title: const Text(
                          "Full Name",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: const <Widget>[
                            Icon(Icons.arrow_right, color: Colors.blueGrey),
                            Text("Ahmad bin Abu",
                                style: TextStyle(color: Colors.black))
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
                                      width: 1.0, color: Colors.blueGrey))),
                          child:
                              const Icon(Icons.badge, color: Colors.blueGrey),
                        ),
                        title: const Text(
                          "IC Number",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: const <Widget>[
                            Icon(Icons.arrow_right, color: Colors.blueGrey),
                            Text("xxxxxx-xx-xxxx",
                                style: TextStyle(color: Colors.black))
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
                                      width: 1.0, color: Colors.blueGrey))),
                          child:
                              const Icon(Icons.phone, color: Colors.blueGrey),
                        ),
                        title: const Text(
                          "Mobile Number",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: const <Widget>[
                            Icon(Icons.arrow_right, color: Colors.blueGrey),
                            Text("013-4567890",
                                style: TextStyle(color: Colors.black))
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
                                      width: 1.0, color: Colors.blueGrey))),
                          child: const Icon(Icons.mail, color: Colors.blueGrey),
                        ),
                        title: const Text(
                          "Email Address",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: const <Widget>[
                            Icon(Icons.arrow_right, color: Colors.blueGrey),
                            Text("ahmadabu@gmail.com",
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                child: ElevatedButton(
                    style: raisedButtonStyle,
                    child: const Text('Logout'),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, '/login');
                    }),
              )
            ],
          )),
    );
  }
}
