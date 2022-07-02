import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/history.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class HistoryServiceAbstract with ServiceStream {
  //get list of owner vehicle
  Stream<QuerySnapshot<Object?>> getRenterHistory();

  //get vehicle
  Stream<History> getHistoryDetails(String historyid);
}
