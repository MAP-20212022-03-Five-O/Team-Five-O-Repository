import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/home_appbar.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/view_car_details.dart';
import 'package:five_o_car_rental/viewmodel/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../app/routes.dart';
import '../owner_dashboard/home_appbar.dart';

class SearchVehicleList extends StatefulWidget {
  String carType, vehicleLoc;
  DateTime startDate, endDate;
  int duration;
  SearchVehicleList({
    Key? key,
    required this.carType,
    required this.vehicleLoc,
    required this.startDate,
    required this.endDate,
    required this.duration,
  }) : super(key: key);

  // final String carType, vehicleLoc;
  // static Route route(String carType, String vehicleLoc, DateTime startDate,
  //         DateTime endDate) =>
  //     MaterialPageRoute(
  //         builder: (_) => SearchVehicleList(
  //               carType: carType,
  //               vehicleLoc: vehicleLoc,
  //               startDate: startDate,
  //               endDate: endDate,
  //             ));

  @override
  State<SearchVehicleList> createState() => _SearchVehicleListState();
}

late final VehicleViewModel _vehicleViewModel = locator.get<VehicleViewModel>();
late final BuildContext _context;

class _SearchVehicleListState extends State<SearchVehicleList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: _vehicleViewModel.getSearchVehicle(
              widget.carType,
              widget.vehicleLoc,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final vehicle = snapshot.data!;
                return ListView(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'Search Results',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50)
                    ],
                  ),
                  ...vehicle.docs.map((vehicle) {
                    Vehicle v = Vehicle.fromFirestore(vehicle);
                    return Card(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.amberAccent)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            title: Text(
                              v.brand!,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Text('RM ${v.price}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.arrow_right,
                                      color: Colors.black, size: 30),
                                  tooltip: 'View Car',
                                  onPressed: () {
                                    String vehicleId;
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewCarDetails(
                                                    carType: widget.carType,
                                                    vehicleLoc:
                                                        widget.vehicleLoc,
                                                    startDate: widget.startDate,
                                                    endDate: widget.endDate,
                                                    vehicleId: vehicle.id,
                                                    duration:
                                                        widget.duration)));
                                  },
                                )
                              ],
                            ),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ViewCarDetails(
                                        carType: widget.carType,
                                        vehicleLoc: widget.vehicleLoc,
                                        startDate: widget.startDate,
                                        endDate: widget.endDate,
                                        vehicleId: vehicle.id,
                                        duration: widget.duration)))),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20)
                ]);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
