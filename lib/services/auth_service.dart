import 'package:firebase_auth/firebase_auth.dart';
import 'database_manager.dart';

class authService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //registration
  Future createAccount(String name, String ic, String phoneno, String email,
      String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseManager().storeUserDetails(
        ic,
        name,
        phoneno,
        email,
        password,
        user!.uid,
      );
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  //login
  Future login(String _email, String _password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }
}
