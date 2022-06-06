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
  Future<bool> addVehicle(String plateNo, String brand, String capacity,
      String carType, int manYear, double price) async {
    try {
      String userid = _auth.currentUser!.uid;
      await vehicles.doc().set(Vehicle(
              plateNo: plateNo,
              brand: brand,
              capacity: capacity,
              carType: carType,
              manYear: manYear,
              price: price,
              userid: userid)
          .toMap());
    } catch (e) {
      return false;
    }
    return true;
  }

  //retrieve vehicle list
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
  Future<bool> updateVehicle(String plateNo, String brand, String capacity,
      String carType, int manYear, double price, String vid) async {
    try {
      String userid = _auth.currentUser!.uid;
      await vehicles.doc(vid).update(Vehicle(
            plateNo: plateNo,
            brand: brand,
            capacity: capacity,
            carType: carType,
            manYear: manYear,
            price: price,
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
}
