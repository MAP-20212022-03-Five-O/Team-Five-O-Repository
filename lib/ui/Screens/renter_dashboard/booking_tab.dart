import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/rent.dart';
import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/home_appbar.dart';
import 'package:five_o_car_rental/viewmodel/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';

class BookingTab extends StatefulWidget {
  const BookingTab({Key? key}) : super(key: key);

  @override
  State<BookingTab> createState() => _BookingTabState();
  static Route route() => MaterialPageRoute(builder: (_) => const BookingTab());
}

late final VehicleViewModel _vehicleViewModel = locator.get<VehicleViewModel>();

bool _visible = false;

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
                    // kira hari
                    DateTime dateTimeNow = DateTime.now();
                    var difference =
                        rental.endDate?.difference(dateTimeNow).inDays;
                    int days = difference! + 1;
                    print(days);
                    if (days <= 1) {
                      _visible = true;
                    } else {
                      _visible = false;
                    }

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
                                View<VehicleViewModel>(builder: (_, viewmodel) {
                                  return Visibility(
                                    visible: _visible,
                                    child: IconButton(
                                      icon: const Icon(Icons.no_crash_outlined,
                                          color: Colors.black, size: 30),
                                      tooltip: 'End Rent',
                                      onPressed: () {
                                        showAlertDialog(context)
                                            .then((value) async {
                                          if (value) {
                                            Rent rentObj = Rent(
                                                ownerid: rental.ownerid,
                                                vehicleId: rental.vehicleId,
                                                startDate: rental.startDate,
                                                endDate: rental.endDate,
                                                totalPayment:
                                                    rental.totalPayment,
                                                brand: rental.brand,
                                                plateNo: rental.plateNo);

                                            bool result = await viewmodel
                                                .endRent(rentObj, rent.id);
                                            await viewmodel.updateCancelVehicle(
                                                rental.vehicleId!);
                                            if (result == true) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Rent Has Been Ended!')),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content:
                                                        Text('Unsuccessful')),
                                              );
                                            }
                                          }
                                        });
                                      },
                                    ),
                                  );
                                })
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

Future<dynamic> showAlertDialog(BuildContext context) async {
  // set up the buttons
  Widget yesButton = TextButton(
    child: Text("Yes"),
    onPressed: () {
      Navigator.pop(context, true);
    },
  );
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context, false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("End Rent"),
    content: Text("Are you sure want to end this rent?"),
    actions: [
      yesButton,
      cancelButton,
    ],
  );

  // show the dialog
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
