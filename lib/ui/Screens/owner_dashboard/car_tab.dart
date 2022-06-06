import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/viewmodel/addvehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:map_mvvm/view.dart';

class CarTab extends StatefulWidget {
  const CarTab({Key? key}) : super(key: key);

  @override
  State<CarTab> createState() => _CarTabState();
  static Route route() => MaterialPageRoute(builder: (_) => const CarTab());
}

class _CarTabState extends State<CarTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(height: 15),
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
              const SizedBox(height: 30),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                  child: ElevatedButton(
                      style: raisedButtonStyle,
                      child: const Text('Add New Car'),
                      onPressed: () async {
                        Navigator.pushNamed(context, Routes.addcar);
                      })),
            ],
          )),
    );
  }
}
