import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String ic, name, phoneno, email, uid;

  User(
      {required this.ic,
      required this.name,
      required this.phoneno,
      required this.email,
      required this.uid});

  factory User.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return User(
        name: data['name'],
        ic: data['ic'],
        phoneno: data['phoneno'],
        email: data['email'],
        uid: snapshot.id);
  }
}
