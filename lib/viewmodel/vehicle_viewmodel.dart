import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_o_car_rental/Models/rent.dart';
import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:five_o_car_rental/app/app.dart';
import 'package:five_o_car_rental/services/vehicle_service.dart';
import 'package:five_o_car_rental/services/vehicle_service_abstract.dart';
import 'package:map_mvvm/map_mvvm.dart';

class VehicleViewModel extends Viewmodel {
  VehicleServiceAbstract get service => locator<VehicleServiceAbstract>();
  StreamSubscription? _streamListener;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  // Add new vehicle
  Future<bool> addVehicle(Vehicle vehicle) async {
    bool status = await service.addVehicle(vehicle);
    return status;
  }

  //get all owner car
  Stream<QuerySnapshot<Object?>> getOwnerVehicle() {
    String userid = _auth.currentUser!.uid;
    return service.getOwnerVehicle(userid);
  }

  //get only selected car
  Stream<Vehicle> getVehicleDetails(String id) => service.getVehicleDetails(id);

//update vehicle details
  Future<bool> updateVehicle(Vehicle vehicle, vid) async {
    bool status = await service.updateVehicle(vehicle, vid);
    return status;
  }

  // delete vehicle
  Future<bool> deleteVehicle(vid) async {
    bool status = await service.deleteVehicle(vid);
    return status;
  }

  //get all vehicle
  Stream<QuerySnapshot<Object?>> getAllVehicle() {
    return service.getAllVehicle();
  }

  // Search vehicle
  Stream<QuerySnapshot<Object?>> getSearchVehicle(
      String carType, String vehicleLoc) {
    return service.searchVehicle(carType, vehicleLoc);
  }

  // Add new vehicle
  Future<bool> rentVehicle(Vehicle vehicle, Rent rent) async {
    bool status = await service.rentVehicle(vehicle, rent);
    return status;
  }

  //get all active rent
  Stream<QuerySnapshot<Object?>> getActiveRent() {
    return service.getActiveRent();
  }

  //get only selected rent
  Stream<Rent> getRentDetails(String id) => service.getRentDetails(id);
}
