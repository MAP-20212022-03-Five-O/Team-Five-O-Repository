import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/ui/app_bar.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:five_o_car_rental/viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:flutter/services.dart';

import '../../../viewmodel/vehicle_viewmodel.dart';

class AddCar extends StatefulWidget {
  const AddCar({Key? key}) : super(key: key);

  @override
  State<AddCar> createState() => _AddCarState();
  static Route route() => MaterialPageRoute(builder: (_) => const AddCar());
}

class _AddCarState extends State<AddCar> {
  final _key = GlobalKey<FormState>();
  FocusNode myFocusNode = FocusNode();

  String? plateNo;
  String? brand;
  String? capacity;
  String? carType;
  int? manYear;
  double? price;

  Future _onAddCar(BuildContext context, VehicleViewModel viewmodel) async {
    bool result = await viewmodel.addVehicle(
        plateNo, brand, capacity, carType, manYear, price);
    //print(result);
    if (result == true) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Car Succesfully Added!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unsuccessful')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Form(
              key: _key,
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    //image here
                    height: 100,
                    width: 100,
                    child: LogoAsset(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      maxLength: 8,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Plate Number is empty";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) => plateNo = newValue,
                      decoration: const InputDecoration(
                        counterText: '',
                        hintText: 'Plate Number',
                        border: OutlineInputBorder(),
                        labelText: 'Enter Plate Number',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Car Brand/Model is empty";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) => brand = newValue,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Car Brand/Model',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Maximum capacity is Empty";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) => capacity = newValue,
                      decoration: const InputDecoration(
                        hintText: 'Maximum Capacity',
                        counterText: '',
                        border: OutlineInputBorder(),
                        labelText: 'Enter Maximum Capacity',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Car Type is empty";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) => carType = newValue,
                      decoration: const InputDecoration(
                        hintText: 'Car Type',
                        border: OutlineInputBorder(),
                        labelText: 'Enter Car Type',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Manufacture year is empty";
                        } else {
                          manYear = int.parse(value);
                          return null;
                        }
                      },
                      onSaved: (newValue) => manYear,
                      decoration: const InputDecoration(
                        hintText: 'Manufacture Year',
                        border: OutlineInputBorder(),
                        labelText: 'Enter Manufacture Year',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,1}')),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Price is empty";
                        } else {
                          price = double.parse(value);
                          return null;
                        }
                      },
                      onSaved: (newValue) => price,
                      decoration: const InputDecoration(
                        hintText: 'Price/Day',
                        border: OutlineInputBorder(),
                        labelText: 'Enter Price/Day (RM)',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                      child: View<VehicleViewModel>(builder: (_, viewmodel) {
                        return ElevatedButton(
                          style: raisedButtonStyle,
                          child: const Text('Submit'),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              _key.currentState!.save();
                              _onAddCar(context, viewmodel);
                            }
                          },
                        );
                      })),
                  const SizedBox(height: 10),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )),
                ],
              ))),
    );
  }
}
