import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/history.dart';
import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/viewmodel/history_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

late final HistoryViewModel _historyViewModel = locator.get<HistoryViewModel>();

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: _historyViewModel.getRenterHistory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final history = snapshot.data!;
                return ListView(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'My Rent History',
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
                  ...history.docs.map((history) {
                    History h = History.fromFirestore(history);
                    return Card(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.amberAccent)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            title: Text(
                              h.brand!,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Text('RM ${h.totalPayment}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.visibility,
                                      color: Colors.black, size: 30),
                                  tooltip: 'End Rent',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.historyDetails,
                                        arguments: history.id);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.reviews_outlined,
                                      color: Colors.black, size: 30),
                                  tooltip: 'Add Review',
                                  onPressed: () {
                                    // showAlertDialog(context);
                                  },
                                ),
                              ],
                            ),
                            onTap: () => Navigator.pushNamed(
                                context, Routes.historyDetails,
                                arguments: history.id)),
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

  // _displayDialog(BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('What is your Lucky Number'),
  //           content: TextField(
  //             controller: _textFieldController,
  //             textInputAction: TextInputAction.go,
  //             keyboardType: TextInputType.numberWithOptions(),
  //             decoration: InputDecoration(hintText: "Enter your number"),
  //           ),
  //           actions: <Widget>[
  //             new FlatButton(
  //               child: new Text('Submit'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             )
  //           ],
  //         );
  //       });
