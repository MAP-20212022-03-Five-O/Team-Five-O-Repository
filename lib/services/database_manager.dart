import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:five_o_car_rental/Models/vehicle.dart';
import '../Models/user.dart';

class DatabaseManager {
  //insert data into firestore function
  final CollectionReference users =
      FirebaseFirestore.instance.collection('user');
  auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  final CollectionReference vehicles =
      FirebaseFirestore.instance.collection('vehicle');

  //fetch data from firebase
  Stream<User>? get user {
    String userID = _auth.currentUser!.uid;
    return users
        .doc(userID)
        .snapshots()
        .map((event) => User.fromFirestore(event));
  }
}
