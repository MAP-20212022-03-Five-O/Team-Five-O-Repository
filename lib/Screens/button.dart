import 'package:flutter/material.dart';

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: const Color(0xffFFFFFF),
  primary: const Color(0xff5D5FEF),
  minimumSize: const Size(40, 40),
  padding: const EdgeInsets.symmetric(horizontal: 40),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);
