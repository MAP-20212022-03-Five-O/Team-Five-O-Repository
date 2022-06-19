import 'package:five_o_car_rental/app/routes.dart';
import 'package:five_o_car_rental/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';

PreferredSize appBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80.0),
    child: AppBar(
      title: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.cover,
        height: 150,
      ),
      centerTitle: true, // like this!
      backgroundColor: Colors.white,
      actions: <Widget>[
        View<UserViewModel>(builder: (_, viewmodel) {
          return IconButton(
            icon: const Icon(Icons.logout, color: Colors.black, size: 30),
            tooltip: 'Logout',
            onPressed: () {},
          );
        }),
      ],
    ),
  );
}
