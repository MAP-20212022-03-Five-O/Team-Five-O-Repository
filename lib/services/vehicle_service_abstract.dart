import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/rent.dart';

import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class VehicleServiceAbstract with ServiceStream {
  //add vehicle
  Future<bool> addVehicle(Vehicle vehicle);

  //get list of owner vehicle
  Stream<QuerySnapshot<Object?>> getOwnerVehicle(String ownerid);

  //get vehicle
  Stream<Vehicle> getVehicleDetails(String id);

  //update
  Future<bool> updateVehicle(Vehicle vehicle, String vid);

  //delete vehicle
  Future<bool> deleteVehicle(String vid);

  //display all vehicle
  Stream<QuerySnapshot<Object?>> getAllVehicle();

  //Search vehicle by car type and location
  Stream<QuerySnapshot<Object?>> searchVehicle(
    String carType,
    String vehicleLoc,
  );

  //rent vehicle
  Future<bool> rentVehicle(Vehicle vehicle, Rent rent);

  //view active rent
  Stream<QuerySnapshot<Object?>> getActiveRent();

  //view reserved vehicle
  Stream<QuerySnapshot<Object?>> getReservedVehicle();

  //get rent details
  Stream<Rent> getRentDetails(String id);
}
