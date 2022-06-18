import 'package:cloud_firestore/cloud_firestore.dart';

//Vehicle model
class Vehicle {
  final String? vehicleLoc, plateNo, brand, capacity, carType, userid;
  final int? manYear;
  final double? price;

  Vehicle({
    this.vehicleLoc,
    this.plateNo,
    this.brand,
    this.capacity,
    this.carType,
    this.manYear,
    this.price,
    this.userid,
  });
  //Data from firebase convert to class
  factory Vehicle.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Vehicle(
      vehicleLoc: data['vehicleLoc'],
      plateNo: data['plateNo'],
      brand: data['brand'],
      capacity: data['capacity'],
      carType: data['carType'],
      price: data['price'],
      manYear: data['manYear'],
      userid: data['uid'],
    );
  }

  Vehicle.fromJson(Map<String, dynamic> map, this.userid)
      : vehicleLoc = map['vehicleLoc'],
        plateNo = map['plateNo'],
        brand = map['brand'],
        capacity = map['capacity'],
        carType = map['carType'],
        price = map['price'],
        manYear = map['manYear'];

  //Convert to json
  Map<String, dynamic> toMap() {
    return {
      'vehicleLoc': vehicleLoc,
      'plateNo': plateNo,
      'brand': brand,
      'capacity': capacity,
      'carType': carType,
      'price': price,
      'manYear': manYear,
      'userid': userid
    };
  }
}
