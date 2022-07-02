import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  final String? ownerid, renterid, vehicleId, brand, plateNo, reviews;
  final DateTime? startDate, endDate;
  final double? totalPayment;

  History({
    this.ownerid,
    this.renterid,
    this.vehicleId,
    this.startDate,
    this.endDate,
    this.totalPayment,
    this.brand,
    this.plateNo,
    this.reviews,
  });

  factory History.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return History(
        ownerid: data['ownerid'],
        renterid: data['renterid'],
        vehicleId: data['vehicleId'],
        startDate: DateTime.parse(data['startDate'].toDate().toString()),
        endDate: DateTime.parse(data['endDate'].toDate().toString()),
        totalPayment: data['totalPayment'],
        brand: data['brand'],
        plateNo: data['plateNo'],
        reviews: data['reviews']);
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerid': ownerid,
      'renterid': renterid,
      'vehicleId': vehicleId,
      'startDate': startDate,
      'endDate': endDate,
      'totalPayment': totalPayment,
      'brand': brand,
      'plateNo': plateNo,
      'reviews': reviews
    };
  }
}
