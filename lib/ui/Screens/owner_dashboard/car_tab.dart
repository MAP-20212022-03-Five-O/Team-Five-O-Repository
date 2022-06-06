import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/viewmodel/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:map_mvvm/view.dart';

class CarTab extends StatefulWidget {
  const CarTab({Key? key}) : super(key: key);

  @override
  State<CarTab> createState() => _CarTabState();
  static Route route() => MaterialPageRoute(builder: (_) => const CarTab());
}

late final VehicleViewModel _vehicleViewModel = locator.get<VehicleViewModel>();
late final BuildContext _context;

class _CarTabState extends State<CarTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: _vehicleViewModel.getOwnerVehicle(),
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
                              text: 'My Car',
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
                        borderSide: BorderSide(color: Colors.amberAccent)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          title: Text(
                            v.brand!,
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text('RM ${v.price}'),
                          trailing: const Icon(
                            Icons.chevron_right,
                            size: 32,
                            color: Color.fromRGBO(118, 43, 46, 1),
                          ),
                          onTap: () => Navigator.pushNamed(
                              context, Routes.carDetails,
                              arguments: vehicle.id)),
                    ),
                  );
                }).toList(),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                    child: ElevatedButton(
                        style: raisedButtonStyle,
                        child: const Text('Add New Car'),
                        onPressed: () async {
                          Navigator.pushNamed(context, Routes.addcar);
                        })),
                const SizedBox(height: 20)
              ]);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
