import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'database_manager.dart';
import '../Models/user.dart';

class authService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  //registration
  Future createAccount(String name, String ic, String phoneno, String email,
      String password) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User? user = result.user;
      await DatabaseManager().storeUserDetails(User(
        ic: ic,
        name: name,
        phoneno: phoneno,
        email: email,
        uid: user!.uid,
      ));
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  //login
  Future login(String _email, String _password) async {
    try {
      auth.UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: _email, password: _password);
      auth.User? user = userCredential.user;
      return user;
    } on auth.FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }
}
