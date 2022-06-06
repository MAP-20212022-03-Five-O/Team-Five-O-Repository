import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/app/app.dart';
import 'package:five_o_car_rental/services/vehicle_service.dart';
import 'package:five_o_car_rental/services/vehicle_service_abstract.dart';
import 'package:map_mvvm/map_mvvm.dart';

class AddVehicleViewModel extends Viewmodel {
  VehicleServiceAbstract get service => locator<VehicleServiceAbstract>();
  StreamSubscription? _streamListener;
  CollectionReference vehicle =
      FirebaseFirestore.instance.collection('vehicle');
  bool get isListeningToStream => _streamListener != null;
  String plateNo = '';
  String brand = '';
  String capacity = '';
  String carType = '';
  int manYear = 0000;
  double price = 0.00;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  Future<bool> addVehicle(
      plateNo, brand, capacity, carType, manYear, price) async {
    bool status = await service.addVehicle(
        plateNo, brand, capacity, carType, manYear, price);
    return status;
  }
}
