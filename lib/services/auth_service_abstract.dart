import 'package:five_o_car_rental/Models/user.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class AuthServiceAbstract with ServiceStream {
  Future createAccount(String name, String ic, String phoneno, String email,
      String password, String userType);

  Future<User?> login(String _email, String _password);
}
