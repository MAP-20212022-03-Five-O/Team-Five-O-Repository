import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/Models/vehicle.dart';
import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/app/service_locator.dart';
import 'package:five_o_car_rental/ui/Screens/renter_dashboard/search_vehicle_list.dart';
import 'package:five_o_car_rental/viewmodel/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/map_mvvm.dart';

import '../../../app/routes.dart';
import '../../button_style.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(now);

class _ExploreTabState extends State<ExploreTab> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime? startDate = DateTime(2022);
  // String selectedValue = "Select car type";
  String carTypeValue = 'Sedan';
  String carLocValue = 'Kuala Lumpur';
  String? carType = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
            width: 350,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 208, 208, 233),
              border: Border.all(
                width: 2,
                color: const Color(0xff5D5FEF),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Form(
                child: Column(
              children: <Widget>[
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'Search Car',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    width: 320,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: DropdownButtonFormField<String>(
                      hint: const Text('Select Location'),
                      value: carLocValue,
                      decoration:
                          const InputDecoration(fillColor: Colors.black),
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          carLocValue = newValue!;
                        });
                      },
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
                const SizedBox(height: 20),
                Container(
                    width: 320,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: DropdownButtonFormField<String>(
                      hint: const Text('Select Car Type'),
                      value: carTypeValue,
                      decoration:
                          const InputDecoration(fillColor: Colors.black),
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          carTypeValue = newValue!;
                        });
                      },
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
                const SizedBox(height: 20),
                Container(
                    width: 320,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        labelText: "Rent Start Date",
                        hintText: 'Select Start Date',
                      ),
                      controller: startDateController,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());

                        startDate = await DatePicker.showDatePicker(context,
                            minTime:
                                DateTime.now().add(const Duration(days: 1)),
                            maxTime: DateTime(2030),
                            currentTime:
                                DateTime.now().add(const Duration(days: 1)));

                        startDateController.text =
                            DateFormat('dd-MM-yyyy').format(startDate!);
                      },
                    )),
                const SizedBox(height: 20),
                Container(
                    width: 320,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        labelText: "Rent End Date",
                        hintText: 'Select End Date',
                      ),
                      controller: endDateController,
                      onTap: () async {
                        DateTime? endDate = DateTime(2022);

                        FocusScope.of(context).requestFocus(FocusNode());

                        endDate = await DatePicker.showDatePicker(context,
                            minTime: startDate?.add(const Duration(days: 1)),
                            maxTime: DateTime(2030),
                            currentTime:
                                startDate?.add(const Duration(days: 1)));
                        //print(startDate);

                        endDateController.text =
                            DateFormat('dd-MM-yyyy').format(endDate!);
                      },
                    )),
                const SizedBox(height: 20),
                View<VehicleViewModel>(builder: (_, viewmodel) {
                  return ElevatedButton(
                      style: raisedButtonStyle,
                      child: const Text('Search Available Vehicles'),
                      onPressed: () async {
                        String vehicleLoc = carLocValue;
                        carType = carTypeValue;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchVehicleList(
                                carType: carType!, vehicleLoc: vehicleLoc)));
                      });
                }),
              ],
            )),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              style: raisedButtonStyle,
              child: const Text('View All Vehicles'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.viewAllVehicles);
              }),
        ],
      ),
    );
  }
}
