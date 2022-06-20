import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:five_o_car_rental/Models/rent.dart';
import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:five_o_car_rental/Services/database_manager.dart';
import 'package:five_o_car_rental/services/vehicle_service_abstract.dart';

class VehicleService extends VehicleServiceAbstract {
  final CollectionReference vehicles =
      FirebaseFirestore.instance.collection('vehicle');
  final CollectionReference rents =
      FirebaseFirestore.instance.collection('rent');
  auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  Vehicle vehicle = Vehicle();

  //Add new Car
  @override
  Future<bool> addVehicle(Vehicle vehicle) async {
    try {
      String ownerid = _auth.currentUser!.uid;
      await vehicles.doc().set(Vehicle(
              vehicleLoc: vehicle.vehicleLoc,
              plateNo: vehicle.plateNo,
              brand: vehicle.brand,
              capacity: vehicle.capacity,
              carType: vehicle.carType,
              manYear: vehicle.manYear,
              price: vehicle.price,
              ownerid: ownerid,
              status: 'available')
          .toMap());
    } catch (e) {
      return false;
    }
    return true;
  }

  //retrieve owner vehicle list
  @override
  Stream<QuerySnapshot<Object?>> getOwnerVehicle(String ownerid) {
    return vehicles.where('ownerid', isEqualTo: ownerid).snapshots();
  }

//retrieve vehicle details
  @override
  Stream<Vehicle> getVehicleDetails(String id) =>
      vehicles.doc(id).snapshots().map((event) => Vehicle.fromFirestore(event));

//update vehicle details
  @override
  Future<bool> updateVehicle(Vehicle vehicle, String vid) async {
    try {
      String ownerid = _auth.currentUser!.uid;
      await vehicles.doc(vid).update(Vehicle(
            vehicleLoc: vehicle.vehicleLoc,
            plateNo: vehicle.plateNo,
            brand: vehicle.brand,
            capacity: vehicle.capacity,
            carType: vehicle.carType,
            manYear: vehicle.manYear,
            price: vehicle.price,
            ownerid: ownerid,
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
    return vehicles.where('status', isEqualTo: 'available').snapshots();
  }

  //renter search vehicle list
  @override
  Stream<QuerySnapshot<Object?>> searchVehicle(
      String carType, String vehicleLoc) {
    return vehicles
        .where('carType', isEqualTo: carType)
        .where('vehicleLoc', isEqualTo: vehicleLoc)
        .where('status', isEqualTo: 'available')
        .snapshots();
  }

  //rent vehicle
  @override
  Future<bool> rentVehicle(Vehicle vehicle, Rent rent) async {
    try {
      String renterid = _auth.currentUser!.uid;
      await rents.doc().set(Rent(
              ownerid: vehicle.ownerid,
              renterid: renterid,
              vehicleId: rent.vehicleId,
              startDate: rent.startDate,
              endDate: rent.endDate,
              totalPayment: rent.totalPayment,
              brand: rent.brand,
              plateNo: rent.plateNo) //aggregate rent and vehicle model
          //Rent.aggregate(vehicle, rent).toMap()
          .toMap());
      // update( { 'status '  :  'reserved'})
      await vehicles.doc(rent.vehicleId).update(Vehicle(
              vehicleLoc: vehicle.vehicleLoc,
              plateNo: vehicle.plateNo,
              brand: vehicle.brand,
              capacity: vehicle.capacity,
              carType: vehicle.carType,
              manYear: vehicle.manYear,
              price: vehicle.price,
              ownerid: vehicle.ownerid,
              status: 'reserved')
          .toMap());

      //update( { 'status '  :  'reserved'})
    } catch (e) {
      return false;
    }
    return true;
  }

  //retrieve owner vehicle list
  @override
  Stream<QuerySnapshot<Object?>> getActiveRent() {
    String renterid = _auth.currentUser!.uid;

    return rents.where('renterid', isEqualTo: renterid).snapshots();
  }

  //retrieve Rent details
  @override
  Stream<Rent> getRentDetails(String id) =>
      rents.doc(id).snapshots().map((event) => Rent.fromFirestore(event));

  //retrieve reserved vehicle list
  @override
  Stream<QuerySnapshot<Object?>> getReservedVehicle() {
    String ownerid = _auth.currentUser!.uid;

    return rents.where('ownerid', isEqualTo: ownerid).snapshots();
  }

  //cancel booking
  @override
  Future<bool> cancelBooking(String rentid) async {
    try {
      await rents.doc(rentid).delete();
    } catch (e) {
      return false;
    }
    return true;
  }
}
