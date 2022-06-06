import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:five_o_car_rental/Services/database_manager.dart';
import 'package:five_o_car_rental/services/vehicle_service_abstract.dart';

class VehicleService extends VehicleServiceAbstract {
  final CollectionReference vehicles =
      FirebaseFirestore.instance.collection('vehicle');
  auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  //registration
  @override
  Future<bool> addVehicle(String plateNo, String brand, String capacity,
      String carType, int manYear, double price) async {
    try {
      String userid = _auth.currentUser!.uid;
      await DatabaseManager().storeVehicleDetails(Vehicle(
          plateNo: plateNo,
          brand: brand,
          capacity: capacity,
          carType: carType,
          manYear: manYear,
          price: price,
          userid: userid));
    } catch (e) {
      return false;
    }
    return true;
  }
}
