import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseManager {
  //insert data into firestore function
  final CollectionReference users =
      FirebaseFirestore.instance.collection('user');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> storeUserDetails(
    String ic,
    String name,
    String phoneno,
    String email,
    String password,
    String uid,
  ) async {
    return await users.doc(uid).set({
      'name': name,
      'ic': ic,
      'phoneno': phoneno,
      'email': email,
    });
  }
}
