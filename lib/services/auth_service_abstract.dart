import 'package:five_o_car_rental/Models/user.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class AuthServiceAbstract with ServiceStream {
  Future<String?> createAccount(String name, String ic, String phoneno,
      String email, String password, String userType);
  Future<User?> login(String _email, String _password);
  Future<void> resetPassword(String email);
  Future<User?> getUserByID(String id);
  Stream<User> getUserDetails(String id);
  Future logout();

  //update profile
  Future<bool> updateUserDetails(
    String name,
    String ic,
    String phoneno,
    String email,
    String userType,
    String uid,
  );
}
