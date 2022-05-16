import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/user.dart';

class DatabaseManager {
  //insert data into firestore function
  final CollectionReference users =
      FirebaseFirestore.instance.collection('user');

  // Store user details
  Future<void> storeUserDetails(User user) async {
    return await users.doc(user.uid).set(user.toMap());
  }
}
