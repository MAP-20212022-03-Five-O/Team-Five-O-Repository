import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:five_o_car_rental/Services/database_manager.dart';
import 'package:five_o_car_rental/services/vehicle_service_abstract.dart';

class VehicleService extends VehicleServiceAbstract {
  final CollectionReference vehicles =
      FirebaseFirestore.instance.collection('vehicle');
  auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  Vehicle vehicle = Vehicle();

  //Add new Car
  @override
  Future<bool> addVehicle(Vehicle vehicle) async {
    try {
      String userid = _auth.currentUser!.uid;
      await vehicles.doc().set(Vehicle(
              vehicleLoc: vehicle.vehicleLoc,
              plateNo: vehicle.plateNo,
              brand: vehicle.brand,
              capacity: vehicle.capacity,
              carType: vehicle.carType,
              manYear: vehicle.manYear,
              price: vehicle.price,
              userid: userid)
          .toMap());
    } catch (e) {
      return false;
    }
    return true;
  }

  //retrieve owner vehicle list
  @override
  Stream<QuerySnapshot<Object?>> getOwnerVehicle(String userid) {
    return vehicles.where('userid', isEqualTo: userid).snapshots();
  }

//retrieve vehicle details
  @override
  Stream<Vehicle> getVehicleDetails(String id) =>
      vehicles.doc(id).snapshots().map((event) => Vehicle.fromFirestore(event));

//update vehicle details
  @override
  Future<bool> updateVehicle(Vehicle vehicle, String vid) async {
    try {
      String userid = _auth.currentUser!.uid;
      await vehicles.doc(vid).update(Vehicle(
            vehicleLoc: vehicle.vehicleLoc,
            plateNo: vehicle.plateNo,
            brand: vehicle.brand,
            capacity: vehicle.capacity,
            carType: vehicle.carType,
            manYear: vehicle.manYear,
            price: vehicle.price,
            userid: userid,
          ).toMap());
    } catch (e) {
      return false;
    }
    return true;
  }

//delete vehicle
  @override
  Future<bool> deleteVehicle(String vid) async {
    try {
      await vehicles.doc(vid).delete();
    } catch (e) {
      return false;
    }
    return true;
  }

  //renter view all vehicle
  @override
  Stream<QuerySnapshot<Object?>> getAllVehicle() {
    return vehicles.snapshots();
  }

  //search vehicle list
  @override
  Stream<QuerySnapshot<Object?>> searchVehicle(
      String carType, String vehicleLoc) {
    return vehicles
        .where('carType', isEqualTo: carType)
        .where('vehicleLoc', isEqualTo: vehicleLoc)
        .snapshots();
  }
}
