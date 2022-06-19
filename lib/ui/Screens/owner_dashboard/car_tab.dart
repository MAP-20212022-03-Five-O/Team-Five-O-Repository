import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/viewmodel/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:map_mvvm/view.dart';

import 'cartab_component.dart';

class CarTab extends StatefulWidget {
  const CarTab({Key? key}) : super(key: key);

  @override
  State<CarTab> createState() => _CarTabState();
  static Route route() => MaterialPageRoute(builder: (_) => const CarTab());
}

late final VehicleViewModel _vehicleViewModel = locator.get<VehicleViewModel>();

class _CarTabState extends State<CarTab> {
  @override
  Widget build(BuildContext context) {
    String? vehicleid;

    Future _onDeleteCar(BuildContext context, VehicleViewModel viewmodel,
        String? vehicleid) async {
      bool result = await viewmodel.deleteVehicle(vehicleid);
      if (result == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Car Succesfully Deleted!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unsuccessful')),
        );
      }
    }

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
                              UpdateIcon(context, vehicle),
                              View<VehicleViewModel>(builder: (_, viewmodel) {
                                return DeleteIconButton(vehicleid, vehicle,
                                    context, _onDeleteCar, viewmodel);
                              }),
                            ],
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
                    child: AddCarButton(context)),
                const SizedBox(height: 20)
              ]);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
