import 'package:cloud_firestore/cloud_firestore.dart';

class Sales {
  final String ownerid, renterid, vehicleId, brand, plateNo, reviews;
  final DateTime? startDate, endDate;
  final double? totalPayment;

  Sales({
    required this.ownerid,
    required this.renterid,
    required this.vehicleId,
    this.startDate,
    this.endDate,
    this.totalPayment,
    required this.brand,
    required this.plateNo,
    required this.reviews,
  });

  factory Sales.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return Sales(
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

  factory Sales.fromJson(Map<String, dynamic> json) {
    return Sales(
      ownerid: json['ownerid'],
      renterid: json['renterid'],
      vehicleId: json['vehicleId'],
      startDate: DateTime.parse(json['startDate'].toDate().toString()),
      endDate: DateTime.parse(json['endDate'].toDate().toString()),
      totalPayment: json['totalPayment'],
      brand: json['brand'],
      plateNo: json['plateNo'],
      reviews: json['reviews'],
    );
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
