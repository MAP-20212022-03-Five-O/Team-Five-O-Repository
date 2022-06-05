import 'dart:async';

import 'package:five_o_car_rental/services/auth_service_abstract.dart';
import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';

import '../Models/user.dart';
import '../app/routes.dart';
import '../app/service_locator.dart';

class LoginViewModel extends Viewmodel {
  AuthServiceAbstract get auth => locator<AuthServiceAbstract>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  String email = '';
  String password = '';
  late User? currUser;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  Future signIn(email, password) async => await update(() async {
        try {
          currUser = await auth.login(email, password);
        } on Failure {
          rethrow;
        }
      });

  void navigator(BuildContext context) {
    if (currUser?.userType == "renter") {
      Navigator.popAndPushNamed(context, Routes.renterHome);
    } else if (currUser?.userType == "owner") {
      Navigator.popAndPushNamed(context, Routes.ownerHome);
    } else {
      Navigator.popAndPushNamed(context, Routes.login);
    }
  }
}
