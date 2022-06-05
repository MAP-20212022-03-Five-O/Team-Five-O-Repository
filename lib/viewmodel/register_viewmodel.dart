import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/services/auth_service_abstract.dart';
import 'package:map_mvvm/map_mvvm.dart';

class RegisterViewModel extends Viewmodel {
  AuthServiceAbstract get auth => locator<AuthServiceAbstract>();
  StreamSubscription? _streamListener;
  CollectionReference user = FirebaseFirestore.instance.collection('user');
  bool get isListeningToStream => _streamListener != null;
  String name = '';
  String ic = '';
  String phoneno = '';
  String email = '';
  String password = '';
  String userType = '';

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  Future<String?> signup(name, ic, phoneno, email, password, userType) async {
    String? status =
        await auth.createAccount(name, ic, phoneno, email, password, userType);
    return status;
  }
}
