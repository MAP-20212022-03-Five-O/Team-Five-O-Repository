import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_o_car_rental/Models/history.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/services/history_service_abstract.dart';
import 'package:map_mvvm/map_mvvm.dart';

class HistoryViewModel extends Viewmodel {
  HistoryServiceAbstract get service => locator<HistoryServiceAbstract>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  //get all renter history
  Stream<QuerySnapshot<Object?>> getRenterHistory() {
    return service.getRenterHistory();
  }

  //get only selected history
  Stream<History> getHistoryDetails(String historyid) =>
      service.getHistoryDetails(historyid);

  Future<bool> addReviews(String historyid, String reviews) =>
      service.addReviews(historyid, reviews);

  //get all rent history
  Stream<QuerySnapshot<Object?>> getOwnerHistory() {
    return service.getOwnerHistory();
  }
}
