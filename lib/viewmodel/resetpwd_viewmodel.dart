import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/services/auth_service_abstract.dart';
import 'package:five_o_car_rental/services/database_manager.dart';

import 'package:map_mvvm/map_mvvm.dart';
import '../app/service_locator.dart';

class ResetPasswordViewModel extends Viewmodel {
  AuthServiceAbstract get auth => locator<AuthServiceAbstract>();
  StreamSubscription? _streamListener;
  CollectionReference user = FirebaseFirestore.instance.collection('user');
  bool get isListeningToStream => _streamListener != null;
  String email = '';

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  Future<bool> resetPassword(email) async {
    var u = await user.where('email', isEqualTo: email).get();
    if (u.size > 0) {
      auth.resetPassword(email);
      return true;
    } else {
      return false;
    }
  }
}
