import 'package:firebase_auth/firebase_auth.dart';

class authService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
