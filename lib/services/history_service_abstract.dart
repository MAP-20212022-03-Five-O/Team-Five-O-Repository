import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/history.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class HistoryServiceAbstract with ServiceStream {
  //get list of Renter History
  Stream<QuerySnapshot<Object?>> getRenterHistory();

  //get vehicle
  Stream<History> getHistoryDetails(String historyid);

  //give reviews
  Future<bool> addReviews(String historyid, String reviews);

  //get list of owner History
  Stream<QuerySnapshot<Object?>> getOwnerHistory();
}
