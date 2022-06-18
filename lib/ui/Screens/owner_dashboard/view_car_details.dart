import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:five_o_car_rental/app/app.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/home_appbar.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';

import '../../../viewmodel/vehicle_viewmodel.dart';

class ViewDetailsScreen extends StatefulWidget {
  const ViewDetailsScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  static Route route(String vid) =>
      MaterialPageRoute(builder: (_) => ViewDetailsScreen(id: vid));

  @override
  State<ViewDetailsScreen> createState() => _ViewDetailsScreenState();
}

late final VehicleViewModel _vehicleViewModel = locator.get<VehicleViewModel>();
late final BuildContext _context;

class _ViewDetailsScreenState extends State<ViewDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 20),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'Car Details',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                StreamBuilder<Vehicle>(
                    stream: _vehicleViewModel.getVehicleDetails(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Vehicle vehicle = snapshot.data!;
                        return SizedBox(
                          height: 660,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                  color: Colors.blueGrey.withOpacity(0.3),
                                  width: 2),
                            ),
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Colors.blueGrey))),
                                    child: const Icon(Icons.pin_outlined,
                                        color: Colors.blueGrey),
                                  ),
                                  title: const Text(
                                    "Location",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      const Icon(Icons.arrow_right_outlined,
                                          color: Colors.blueGrey),
                                      Text(vehicle.vehicleLoc!,
                                          style: const TextStyle(
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Colors.blueGrey))),
                                    child: const Icon(Icons.pin_outlined,
                                        color: Colors.blueGrey),
                                  ),
                                  title: const Text(
                                    "Plate Number",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      const Icon(Icons.arrow_right_outlined,
                                          color: Colors.blueGrey),
                                      Text(vehicle.plateNo!,
                                          style: const TextStyle(
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Colors.blueGrey))),
                                    child: const Icon(
                                        Icons.directions_car_outlined,
                                        color: Colors.blueGrey),
                                  ),
                                  title: const Text(
                                    "Car Brand/Model",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      const Icon(Icons.arrow_right_outlined,
                                          color: Colors.blueGrey),
                                      Text(vehicle.brand!,
                                          style: const TextStyle(
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Colors.blueGrey))),
                                    child: const Icon(Icons.groups_outlined,
                                        color: Colors.blueGrey),
                                  ),
                                  title: const Text(
                                    "Maximum Capacity",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      const Icon(Icons.arrow_right_outlined,
                                          color: Colors.blueGrey),
                                      Text(vehicle.capacity!,
                                          style: const TextStyle(
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Colors.blueGrey))),
                                    child: const Icon(Icons.groups_outlined,
                                        color: Colors.blueGrey),
                                  ),
                                  title: const Text(
                                    "Car Type",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      const Icon(Icons.arrow_right_outlined,
                                          color: Colors.blueGrey),
                                      Text(vehicle.carType!,
                                          style: const TextStyle(
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Colors.blueGrey))),
                                    child: const Icon(Icons.date_range_outlined,
                                        color: Colors.blueGrey),
                                  ),
                                  title: const Text(
                                    "Manufacture Year",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      const Icon(Icons.arrow_right_outlined,
                                          color: Colors.blueGrey),
                                      Text(vehicle.manYear.toString(),
                                          style: const TextStyle(
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Colors.blueGrey))),
                                    child: const Icon(
                                        Icons.attach_money_outlined,
                                        color: Colors.blueGrey),
                                  ),
                                  title: const Text(
                                    "Price/day",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      const Icon(Icons.arrow_right_outlined,
                                          color: Colors.blueGrey),
                                      Text("RM${vehicle.price}",
                                          style: const TextStyle(
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ],
            )),
      ),
    );
  }
}
