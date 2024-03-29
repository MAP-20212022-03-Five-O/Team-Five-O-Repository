import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/history.dart';
import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/viewmodel/history_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:map_mvvm/view.dart';

import '../../button_style.dart';

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
                double? sum = 0;

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
                    sum = sum! + h.totalPayment!;

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
                                    _displayDialog(context, history.id).then;
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
                  const SizedBox(height: 120),
                  Center(
                    child: Align(
                      child: Container(
                        width: 350,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff5D5FEF),
                              offset: Offset(10.0, 10.0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text("Total Spent: RM" + sum.toString(),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        ),
                      ),
                    ),
                  )
                ]);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

TextEditingController _textFieldController = TextEditingController();
_displayDialog(BuildContext context, String historyid) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Your Reviews'),
          content: TextField(
            controller: _textFieldController,
            textInputAction: TextInputAction.go,
            decoration: const InputDecoration(hintText: "Enter Your Reviews"),
          ),
          actions: <Widget>[
            View<HistoryViewModel>(builder: (_, viewmodel) {
              return ElevatedButton(
                style: raisedButtonStyle,
                child: const Text('Submit'),
                onPressed: () async {
                  await viewmodel.addReviews(
                      historyid, _textFieldController.text);
                  Navigator.of(context).pop();
                },
              );
            })
          ],
        );
      });
}
