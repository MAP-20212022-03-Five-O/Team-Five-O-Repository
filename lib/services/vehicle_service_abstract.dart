import 'package:five_o_car_rental/Models/user.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class VehicleServiceAbstract with ServiceStream {
  Future<bool> addVehicle(String plateNo, String brand, String capacity,
      String carType, int manYear, double price);
}
