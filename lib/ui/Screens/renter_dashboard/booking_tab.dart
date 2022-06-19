import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/rent.dart';
import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/home_appbar.dart';
import 'package:five_o_car_rental/viewmodel/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';

class BookingTab extends StatefulWidget {
  const BookingTab({Key? key}) : super(key: key);

  @override
  State<BookingTab> createState() => _BookingTabState();
  static Route route() => MaterialPageRoute(builder: (_) => const BookingTab());
}

late final VehicleViewModel _vehicleViewModel = locator.get<VehicleViewModel>();

class _BookingTabState extends State<BookingTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: _vehicleViewModel.getActiveRent(),
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
                                text: 'My Bookings',
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
