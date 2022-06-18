import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/ui/app_bar.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:five_o_car_rental/viewmodel/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_mvvm/map_mvvm.dart';

class UpdateCarScreen extends StatefulWidget {
  const UpdateCarScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<UpdateCarScreen> createState() => _UpdateCarScreenState();
  static Route route(String vid) =>
      MaterialPageRoute(builder: (_) => UpdateCarScreen(id: vid));
}

late final VehicleViewModel _vehicleViewModel = locator.get<VehicleViewModel>();
late final BuildContext _context;

class _UpdateCarScreenState extends State<UpdateCarScreen> {
  final _key = GlobalKey<FormState>();
  FocusNode myFocusNode = FocusNode();

  TextEditingController vehicleLocController = TextEditingController();
  TextEditingController platenoController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController cartypeController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController manYearController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String? vehicleLoc;
  String? plateNo;
  String? brand;
  String? capacity;
  String? carType;
  int? manYear;
  double? price;
  String? vid;
  String carLocValue = 'Kuala Lumpur';
  String carTypeValue = 'Sedan';

  Future _onUpdateCar(BuildContext context, VehicleViewModel viewmodel) async {
    Vehicle vehicle = Vehicle(
        vehicleLoc: carLocValue,
        plateNo: plateNo,
        brand: brand,
        capacity: capacity,
        carType: carTypeValue,
        manYear: manYear,
        price: price);
    bool result = await viewmodel.updateVehicle(vehicle, vid);
    //print(result);
    if (result == true) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Car Succesfully Updated!')),
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
      child: StreamBuilder<Vehicle>(
          stream: _vehicleViewModel.getVehicleDetails(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Vehicle vehicle = snapshot.data!;
              return Scaffold(
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
                              child: DropdownButtonFormField<String>(
                                hint: const Text('Select Location'),
                                value: carLocValue,
                                decoration: const InputDecoration(
                                    fillColor: Colors.black),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                onChanged: (String? newValue) {},
                                onSaved: (newValue) => carLocValue = newValue!,
                                items: <String>[
                                  'Kuala Lumpur',
                                  'Selangor',
                                  'Negeri Sembilan',
                                  'Johor',
                                  'Perak',
                                  'Kedah',
                                  'Penang',
                                  'Perlis',
                                  'Pahang',
                                  'Terengganu',
                                  'Kelantan',
                                  'Melaka',
                                  'Sabah',
                                  'Sarawak',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                          Container(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: DropdownButtonFormField<String>(
                                hint: const Text('Select Car Type'),
                                value: carTypeValue,
                                decoration: const InputDecoration(
                                    fillColor: Colors.black),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                onChanged: (String? newValue) {},
                                onSaved: (newValue) => carTypeValue = newValue!,
                                items: <String>[
                                  'Sedan',
                                  'MPV',
                                  'Hatchback',
                                  'Pickup Trucks'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
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
                              controller: platenoController
                                ..text = '${vehicle.plateNo}',
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
                              controller: brandController
                                ..text = '${vehicle.brand}',
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
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Maximum capacity is Empty";
                                } else {
                                  return null;
                                }
                              },
                              controller: capacityController
                                ..text = '${vehicle.capacity}',
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
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Manufacture year is empty";
                                } else {
                                  manYear = int.parse(value);
                                  return null;
                                }
                              },
                              controller: manYearController
                                ..text = '${vehicle.manYear}',
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
                              controller: priceController
                                ..text = '${vehicle.price}',
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
                              child: View<VehicleViewModel>(
                                  builder: (_, viewmodel) {
                                return ElevatedButton(
                                  style: raisedButtonStyle,
                                  child: const Text('Update'),
                                  onPressed: () {
                                    if (_key.currentState!.validate()) {
                                      _key.currentState!.save();
                                      vid = widget.id;
                                      _onUpdateCar(context, viewmodel);
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
                      )));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
