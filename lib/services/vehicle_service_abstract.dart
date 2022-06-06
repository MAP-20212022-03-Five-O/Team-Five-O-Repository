import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/user.dart';
import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class VehicleServiceAbstract with ServiceStream {
  Future<bool> addVehicle(String plateNo, String brand, String capacity,
      String carType, int manYear, double price);
  Stream<QuerySnapshot<Object?>> getOwnerVehicle(String userid);
  Stream<Vehicle> getVehicleDetails(String id);
  Future<bool> updateVehicle(String plateNo, String brand, String capacity,
      String carType, int manYear, double price, String vid);
  Future<bool> deleteVehicle(String vid);
}
