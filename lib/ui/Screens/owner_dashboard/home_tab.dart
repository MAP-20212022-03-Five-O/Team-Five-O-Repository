import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Models/rent.dart';
import '../../../app/routes.dart';
import '../../../app/service_locator.dart';
import '../../../viewmodel/vehicle_viewmodel.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

late final VehicleViewModel _vehicleViewModel = locator.get<VehicleViewModel>();

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: _vehicleViewModel.getReservedVehicle(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final rent = snapshot.data!;

                return ListView(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'Reserved Vehicles',
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
                  ...rent.docs.map((rent) {
                    Rent rental = Rent.fromFirestore(rent);

                    return Card(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.amberAccent)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            title: Text(
                              rental.brand!,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Text('RM ${rental.totalPayment}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.arrow_right,
                                      color: Colors.black, size: 30),
                                  tooltip: 'View Rent',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.rentDetails,
                                        arguments: rent.id);
                                  },
                                )
                              ],
                            ),
                            onTap: () => Navigator.pushNamed(
                                context, Routes.rentDetails,
                                arguments: rent.id)),
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
