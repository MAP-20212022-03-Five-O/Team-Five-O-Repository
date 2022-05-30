import 'package:cloud_firestore/cloud_firestore.dart';

//User model
class User {
  final String name, ic, phoneno, email, uid, userType;

  User(
      {required this.name,
      required this.ic,
      required this.phoneno,
      required this.email,
      required this.uid,
      required this.userType});
  //Data from firebase convert to class
  factory User.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return User(
        name: data['name'],
        ic: data['ic'],
        phoneno: data['phoneno'],
        email: data['email'],
        userType: data['userType'],
        uid: snapshot.id);
  }

  User.fromJson(Map<String, dynamic> map, this.uid)
      : name = map['name'],
        ic = map['ic'],
        phoneno = map['phoneno'],
        email = map['email'],
        userType = map['userType'];

  //Convert to json
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ic': ic,
      'phoneno': phoneno,
      'email': email,
      'userType': userType
    };
  }
}
