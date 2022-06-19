import 'package:five_o_car_rental/Models/rent.dart';
import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/home_appbar.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:five_o_car_rental/viewmodel/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/map_mvvm.dart';

class RentConfirmation extends StatefulWidget {
  String vehicleId;
  DateTime startDate, endDate;
  double price;
  RentConfirmation(
      {Key? key,
      required this.endDate,
      required this.startDate,
      required this.vehicleId,
      required this.price})
      : super(key: key);

  @override
  State<RentConfirmation> createState() => _RentConfirmationState();
}

late final VehicleViewModel _vehicleViewModel = locator.get<VehicleViewModel>();

class _RentConfirmationState extends State<RentConfirmation> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

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
                          text: 'Booking Confirmation',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                StreamBuilder<Vehicle>(
                    stream:
                        _vehicleViewModel.getVehicleDetails(widget.vehicleId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String startDate =
                            DateFormat('dd-MM-yyyy').format(widget.startDate);
                        String endDate =
                            DateFormat('dd-MM-yyyy').format(widget.endDate);

                        Vehicle vehicle = snapshot.data!;
                        return Column(
                          children: [
                            SizedBox(
                              height: 500,
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                      leading: Container(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                      leading: Container(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                      leading: Container(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
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
                                        "Rent Date",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          const Icon(Icons.arrow_right_outlined,
                                              color: Colors.blueGrey),
                                          Text("${startDate} until ${endDate}",
                                              style: const TextStyle(
                                                  color: Colors.black))
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                      leading: Container(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
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
                                        "Total Payment",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          const Icon(Icons.arrow_right_outlined,
                                              color: Colors.blueGrey),
                                          Text("RM${widget.price}",
                                              style: const TextStyle(
                                                  color: Colors.black))
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                      leading: Container(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
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
                                        "Pickup Location",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          const Icon(Icons.arrow_right_outlined,
                                              color: Colors.blueGrey),
                                          Text("${vehicle.vehicleLoc}",
                                              style: const TextStyle(
                                                  color: Colors.black))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                View<VehicleViewModel>(builder: (_, viewmodel) {
                                  return ElevatedButton(
                                      style: raisedButtonStyle,
                                      child: const Text('Confirm'),
                                      onPressed: () async {
                                        Vehicle vehicleObj = Vehicle(
                                            vehicleLoc: vehicle.vehicleLoc,
                                            plateNo: vehicle.plateNo,
                                            brand: vehicle.brand,
                                            capacity: vehicle.capacity,
                                            carType: vehicle.carType,
                                            manYear: vehicle.manYear,
                                            price: vehicle.price,
                                            ownerid: vehicle.ownerid,
                                            status: vehicle.status);
                                        String vehicleId = widget.vehicleId;
                                        DateTime startDate = widget.startDate;
                                        DateTime endDate = widget.endDate;
                                        double payment = widget.price;

                                        Rent rentObj = Rent(
                                            vehicleId: vehicleId,
                                            startDate: startDate,
                                            endDate: endDate,
                                            totalPayment: payment,
                                            brand: vehicle.brand,
                                            plateNo: vehicle.plateNo);

                                        bool result = await viewmodel
                                            .rentVehicle(vehicleObj, rentObj);
                                        if (result == true) {
                                          int count = 0;
                                          Navigator.popUntil(context, (route) {
                                            return count++ == 3;
                                          });

                                          // Navigator.pushReplacementNamed(
                                          //     context, Routes.bookingTab);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Rent Succesfully Booked!')),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text('Unsuccessful')),
                                          );
                                        }
                                      });
                                }),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                    style: raisedButtonStyle,
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                const SizedBox(height: 20),
              ],
            )),
      ),
    );
  }
}
