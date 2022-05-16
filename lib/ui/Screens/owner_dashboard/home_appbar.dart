import 'package:flutter/material.dart';

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
    ),
  );
}
