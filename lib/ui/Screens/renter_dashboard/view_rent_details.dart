import 'package:five_o_car_rental/Models/rent.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/home_appbar.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:five_o_car_rental/viewmodel/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/map_mvvm.dart';

class ViewRentDetails extends StatefulWidget {
  const ViewRentDetails({Key? key, required this.rentid}) : super(key: key);
  final String rentid;
  static Route route(String rentid) =>
      MaterialPageRoute(builder: (_) => ViewRentDetails(rentid: rentid));
  @override
  State<ViewRentDetails> createState() => _ViewRentDetailsState();
}

late final VehicleViewModel _vehicleViewModel = locator.get<VehicleViewModel>();

class _ViewRentDetailsState extends State<ViewRentDetails> {
  @override
  Widget build(BuildContext context) {
    print(widget.rentid);
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
                          text: 'Rent Details',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                StreamBuilder<Rent>(
                    stream: _vehicleViewModel.getRentDetails(widget.rentid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Rent rent = snapshot.data!;

                        String startDate =
                            DateFormat('dd-MM-yyyy').format(rent.startDate!);
                        String endDate =
                            DateFormat('dd-MM-yyyy').format(rent.endDate!);
                        return Column(
                          children: [
                            SizedBox(
                              height: 400,
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
                                        child: const Icon(Icons.pin_outlined,
                                            color: Colors.blueGrey),
                                      ),
                                      title: const Text(
                                        "Brand",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          const Icon(Icons.arrow_right_outlined,
                                              color: Colors.blueGrey),
                                          Text(rent.brand!,
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
                                          Text(rent.plateNo!,
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
                                            Icons.directions_car_outlined,
                                            color: Colors.blueGrey),
                                      ),
                                      title: const Text(
                                        "Rental date",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          const Icon(Icons.arrow_right_outlined,
                                              color: Colors.blueGrey),
                                          Text('$startDate until $endDate',
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
                                        child: const Icon(Icons.groups_outlined,
                                            color: Colors.blueGrey),
                                      ),
                                      title: const Text(
                                        "Rent Payment",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          const Icon(Icons.arrow_right_outlined,
                                              color: Colors.blueGrey),
                                          Text('${rent.totalPayment!}',
                                              style: const TextStyle(
                                                  color: Colors.black))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            View<VehicleViewModel>(builder: (_, viewmodel) {
                              return ElevatedButton(
                                  style: raisedButtonStyle,
                                  child: const Text('Cancel Booking'),
                                  onPressed: () async {
                                    //print(widget.rentid);
                                    bool result = await viewmodel
                                        .cancelBooking(widget.rentid);
                                    if (result == true) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Rent Succesfully Canceled!')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Unsuccessful')),
                                      );
                                    }
                                  });
                            })
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
