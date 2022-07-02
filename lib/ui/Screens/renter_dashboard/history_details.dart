import 'package:five_o_car_rental/Models/history.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/home_appbar.dart';
import 'package:five_o_car_rental/viewmodel/history_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewHistoryDetails extends StatefulWidget {
  const ViewHistoryDetails({Key? key, required this.historyid})
      : super(key: key);
  final String historyid;
  static Route route(String historyid) => MaterialPageRoute(
      builder: (_) => ViewHistoryDetails(historyid: historyid));

  @override
  State<ViewHistoryDetails> createState() => _ViewHistoryDetailsState();
}

late final HistoryViewModel _historyViewModel = locator.get<HistoryViewModel>();

class _ViewHistoryDetailsState extends State<ViewHistoryDetails> {
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
                          text: 'History Details',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                StreamBuilder<History>(
                    stream:
                        _historyViewModel.getHistoryDetails(widget.historyid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        History history = snapshot.data!;

                        String startDate =
                            DateFormat('dd-MM-yyyy').format(history.startDate!);
                        String endDate =
                            DateFormat('dd-MM-yyyy').format(history.endDate!);
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
                                          Text(history.brand!,
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
                                          Text(history.plateNo!,
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
                                          Text('${history.totalPayment!}',
                                              style: const TextStyle(
                                                  color: Colors.black))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
