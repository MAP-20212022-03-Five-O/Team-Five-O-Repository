import 'package:cloud_firestore/cloud_firestore.dart';

class Rent {
  final String? ownerid, renterid, vehicleId;
  final DateTime? startDate, endDate;
  final double? totalPayment;

  Rent(
      {this.ownerid,
      this.renterid,
      this.vehicleId,
      this.startDate,
      this.endDate,
      this.totalPayment});

  factory Rent.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Rent(
        ownerid: data['ownerid'],
        renterid: data['renterid'],
        vehicleId: data['vehicleId'],
        startDate: data['startDate'],
        endDate: data['endDate'],
        totalPayment: data['totalPayment']);
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerid': ownerid,
      'renterid': renterid,
      'vehicleId': vehicleId,
      'startDate': startDate,
      'endDate': endDate,
      'totalPayment': totalPayment
    };
  }
}
