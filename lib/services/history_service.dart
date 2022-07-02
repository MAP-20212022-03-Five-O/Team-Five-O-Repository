import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:five_o_car_rental/Models/history.dart';
import 'package:five_o_car_rental/Models/sales.dart';

import 'history_service_abstract.dart';

class HistoryService extends HistoryServiceAbstract {
  final CollectionReference history =
      FirebaseFirestore.instance.collection('history');

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  //retrieve owner vehicle list
  @override
  Stream<QuerySnapshot<Object?>> getRenterHistory() {
    String renterid = _auth.currentUser!.uid;
    return history.where('renterid', isEqualTo: renterid).snapshots();
  }

  @override
  Stream<History> getHistoryDetails(String historyid) => history
      .doc(historyid)
      .snapshots()
      .map((event) => History.fromFirestore(event));

  @override
  Future<bool> addReviews(String historyid, String reviews) async {
    try {
      await history.doc(historyid).update({"reviews": reviews});
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Stream<QuerySnapshot<Object?>> getOwnerHistory() {
    String ownerid = _auth.currentUser!.uid;
    return history.where('ownerid', isEqualTo: ownerid).snapshots();
  }

  List<Sales> sales = [];
  Map<String, double> getBrandData() {
    Map<String, double> catMap = {};
    for (var item in sales) {
      if (catMap.containsKey(item.brand) == false) {
        catMap[item.brand] = 1;
      } else {
        catMap.update(item.brand, (int) => catMap[item.brand]! + 1);
      }
    }
    return catMap;
  }

  @override
  Stream<QuerySnapshot> getHistoryData() {
    String ownerid = _auth.currentUser!.uid;
    return history.where('ownerid', isEqualTo: ownerid).snapshots();
  }
}
