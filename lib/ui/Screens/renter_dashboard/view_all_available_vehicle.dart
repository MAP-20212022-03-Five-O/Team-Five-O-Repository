import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/home_appbar.dart';
import 'package:five_o_car_rental/viewmodel/vehicle_viewmodel.dart';

import 'package:flutter/material.dart';

import '../../../app/routes.dart';
import '../../../app/service_locator.dart';

class ViewAllVehicles extends StatefulWidget {
  const ViewAllVehicles({Key? key}) : super(key: key);

  @override
  State<ViewAllVehicles> createState() => _ViewAllVehiclesState();
  static Route route() =>
      MaterialPageRoute(builder: (_) => const ViewAllVehicles());
}

late final VehicleViewModel _vehicleViewModel = locator.get<VehicleViewModel>();

class _ViewAllVehiclesState extends State<ViewAllVehicles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: _vehicleViewModel.getAllVehicle(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final vehicle = snapshot.data;
                return ListView(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'Available Car',
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
                  ...vehicle!.docs.map((vehicle) {
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
                                    Navigator.pushNamed(
                                        context, Routes.carDetails,
                                        arguments: vehicle.id);
                                  },
                                )
                              ],
                            ),
                            onTap: () => Navigator.pushNamed(
                                context, Routes.carDetails,
                                arguments: vehicle.id)),
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
