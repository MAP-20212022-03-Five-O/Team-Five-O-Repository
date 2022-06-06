import 'dart:async';

import 'package:five_o_car_rental/Models/user.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/services/auth_service_abstract.dart';
import 'package:map_mvvm/map_mvvm.dart';

class UserViewModel extends Viewmodel {
  AuthServiceAbstract get auth => locator<AuthServiceAbstract>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  //retrieve user details
  Stream<User> getUserDetails(String id) => auth.getUserDetails(id);

  //logout
  Future<void> signOut() async {
    await auth.logout();
  }

  //update user details
  Future<bool> updateUserDetails(
      name, ic, phoneno, email, userType, uid) async {
    bool status =
        await auth.updateUserDetails(name, ic, phoneno, email, userType, uid);
    return status;
  }
}
