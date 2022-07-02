import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/ui/button_style.dart';
import 'package:five_o_car_rental/viewmodel/vehicle_viewmodel.dart';
import 'package:flutter/material.dart';

IconButton UpdateIcon(
    BuildContext context, QueryDocumentSnapshot<Object?> vehicle) {
  return IconButton(
    icon: const Icon(Icons.settings_outlined, color: Colors.black, size: 30),
    tooltip: 'Update Car',
    onPressed: () {
      Navigator.pushNamed(context, Routes.updateCar, arguments: vehicle.id);
    },
  );
}

IconButton DeleteIconButton(
    String? vehicleid,
    QueryDocumentSnapshot<Object?> vehicle,
    BuildContext context,
    Future<dynamic> _onDeleteCar(
        BuildContext context, VehicleViewModel viewmodel, String? vehicleid),
    VehicleViewModel viewmodel) {
  return IconButton(
    icon: const Icon(Icons.delete_outline_outlined,
        color: Colors.black, size: 30),
    tooltip: 'Delete Car',
    onPressed: () {
      vehicleid = vehicle.id;
      showAlertDialog(context).then((value) {
        if (value) {
          _onDeleteCar(context, viewmodel, vehicleid);
        }
      });
    },
  );
}

ElevatedButton AddCarButton(BuildContext context) {
  return ElevatedButton(
      style: raisedButtonStyle,
      child: const Text('Add New Car'),
      onPressed: () async {
        Navigator.pushNamed(context, Routes.addcar);
      });
}

Future<dynamic> showAlertDialog(BuildContext context) async {
  // set up the buttons
  Widget yesButton = TextButton(
    child: const Text("Yes"),
    onPressed: () {
      Navigator.pop(context, true);
    },
  );
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(context, false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Delete Car"),
    content: const Text("Are you sure to delete this car?"),
    actions: [
      yesButton,
      cancelButton,
    ],
  );

  // show the dialog
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
