import 'package:cloud_firestore/cloud_firestore.dart';

//User model
class User {
  final String ic, name, phoneno, email, uid;

  User(
      {required this.ic,
      required this.name,
      required this.phoneno,
      required this.email,
      required this.uid});
  //Data from firebase convert to class
  factory User.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return User(
        name: data['name'],
        ic: data['ic'],
        phoneno: data['phoneno'],
        email: data['email'],
        uid: snapshot.id);
  }

  //Convert to json
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ic': ic,
      'phoneno': phoneno,
      'email': email,
    };
  }
}
