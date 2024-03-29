import 'package:cloud_firestore/cloud_firestore.dart';

class Rent {
  final String? ownerid, renterid, vehicleId, brand, plateNo;
  final DateTime? startDate, endDate;
  final double? totalPayment;

  Rent(
      {this.ownerid,
      this.renterid,
      this.vehicleId,
      this.startDate,
      this.endDate,
      this.totalPayment,
      this.brand,
      this.plateNo});

  factory Rent.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return Rent(
        ownerid: data['ownerid'],
        renterid: data['renterid'],
        vehicleId: data['vehicleId'],
        startDate: DateTime.parse(data['startDate'].toDate().toString()),
        endDate: DateTime.parse(data['endDate'].toDate().toString()),
        totalPayment: data['totalPayment'],
        brand: data['brand'],
        plateNo: data['plateNo']);
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
      'plateNo': plateNo
    };
  }
}
