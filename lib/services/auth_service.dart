import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:five_o_car_rental/services/auth_service_abstract.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'database_manager.dart';
import '../Models/user.dart';

// ignore: camel_case_types
class authService extends AuthServiceAbstract {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  final firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("user");
  //registration
  @override
  Future<String?> createAccount(String name, String ic, String phoneno,
      String email, String password, String userType) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User? user = result.user;
      await users.doc(user!.uid).set(User(
              name: name,
              ic: ic,
              phoneno: phoneno,
              email: email,
              uid: user.uid,
              userType: userType)
          .toMap());
    } on auth.FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }

  //login
  @override
  Future<User?> login(String _email, String _password) async {
    try {
      // auth.UserCredential userCredential = await _auth
      //     .signInWithEmailAndPassword(email: _email, password: _password);
      // print(userCredential);
      auth.UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: _email, password: _password);
      var userID = userCredential.user!.uid;
      print(userID);
      //  auth.User? user = userCredential.user;
      var doc = await firebaseFirestore.collection("user").doc(userID).get();
      return User.fromJson(doc.data()!, userID);
    } on auth.FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  //logout
  Future logout() async {
    await auth.FirebaseAuth.instance.signOut();
  }

  //reset password
  @override
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on auth.FirebaseAuthException catch (e) {
      print('Error: $e');
    }
  }

  @override
  Future<User?> getUserByID(String id) {
    return users.doc(id).get().then((value) => User.fromFirestore(value));
  }

  //get user details
  @override
  Stream<User> getUserDetails(String id) =>
      users.doc(id).snapshots().map((event) => User.fromFirestore(event));

  //update user details
  @override
  Future<bool> updateUserDetails(String name, String ic, String phoneno,
      String email, String userType, String uid) async {
    try {
      String userid = _auth.currentUser!.uid;
      await users.doc(userid).update(User(
            name: name,
            ic: ic,
            phoneno: phoneno,
            email: email,
            userType: userType,
            uid: userid,
          ).toMap());
    } catch (e) {
      return false;
    }
    return true;
  }
}
