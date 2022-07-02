import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/sales.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/ui/Screens/owner_dashboard/home_appbar.dart';
import 'package:five_o_car_rental/viewmodel/history_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({Key? key}) : super(key: key);

  @override
  State<SalesReport> createState() => _SalesReportState();
  static Route route() =>
      MaterialPageRoute(builder: (_) => const SalesReport());
}

late final HistoryViewModel _historyViewModel = locator.get<HistoryViewModel>();

class _SalesReportState extends State<SalesReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            StreamBuilder<Object>(
              stream: _historyViewModel.getHistoryData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.requireData;
                  print("Data: $data");
                  getExpfromSanapshot(data);
                  return Expanded(
                    child: ListView(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: 'My Sales Report',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 100),
                          pieChartExampleOne()
                        ],
                      ),
                    ]),
                  );
                } else {
                  return const Expanded(
                      child: Center(child: Text("No data available.")));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  int key = 0;

  late List<Sales> _sales = [];

  Map<String, double> getCategoryData() {
    Map<String, double> catMap = {};
    for (var item in _sales) {
      print(item.brand);
      if (catMap.containsKey(item.brand) == false) {
        catMap[item.brand] = 1;
      } else {
        catMap.update(item.brand, (int) => catMap[item.brand]! + 1);
        // test[item.category] = test[item.category]! + 1;
      }
      print(catMap);
    }
    return catMap;
  }

  List<Color> colorList = [
    const Color.fromRGBO(82, 98, 255, 1),
    const Color.fromRGBO(46, 198, 255, 1),
    const Color.fromRGBO(123, 201, 82, 1),
    const Color.fromRGBO(255, 171, 67, 1),
    const Color.fromRGBO(252, 91, 57, 1),
    const Color.fromRGBO(139, 135, 130, 1),
  ];
  Widget pieChartExampleOne() {
    return PieChart(
      key: ValueKey(key),
      dataMap: getCategoryData(),
      initialAngleInDegree: 0,
      animationDuration: const Duration(milliseconds: 2000),
      chartType: ChartType.ring,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      ringStrokeWidth: 32,
      colorList: colorList,
      chartLegendSpacing: 32,
      chartValuesOptions: const ChartValuesOptions(
          showChartValuesOutside: true,
          showChartValuesInPercentage: true,
          showChartValueBackground: true,
          showChartValues: true,
          chartValueStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      centerText: 'Expense',
      legendOptions: const LegendOptions(
          showLegendsInRow: false,
          showLegends: true,
          legendShape: BoxShape.rectangle,
          legendPosition: LegendPosition.right,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    );
  }

  void getExpfromSanapshot(snapshot) {
    if (snapshot.docs.isNotEmpty) {
      _sales = [];
      for (int i = 0; i < snapshot.docs.length; i++) {
        var a = snapshot.docs[i];
        // print(a.data());
        Sales sale = Sales.fromJson(a.data());
        _sales.add(sale);
        // print(exp);
      }
    }
  }
}
