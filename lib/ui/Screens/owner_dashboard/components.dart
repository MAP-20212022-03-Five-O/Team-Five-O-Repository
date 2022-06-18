import 'package:flutter/material.dart';

import '../../app_bar.dart';
import '../../button_style.dart';

FocusNode myFocusNode = FocusNode();

TextStyle labelStyle() {
  return TextStyle(color: myFocusNode.hasFocus ? Colors.black : Colors.black);
}

ElevatedButton cancelButton(BuildContext context) {
  return ElevatedButton(
    style: raisedButtonStyle,
    child: const Text('Cancel'),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}

Container cancelButtonContainer(BuildContext context) {
  return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
      child: cancelButton(context));
}

InputDecoration emailDecoration() {
  return InputDecoration(
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      hintText: 'Email',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      labelText: 'Email Address',
      labelStyle: labelStyle());
}

InputDecoration phonenoDecoration() {
  return InputDecoration(
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      hintText: 'Phoneno',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      labelText: 'Phone Number',
      labelStyle: labelStyle());
}

InputDecoration icDecoration() {
  return InputDecoration(
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      hintText: 'NRIC',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      labelText: 'IC Number',
      labelStyle: labelStyle());
}

InputDecoration nameDecoration() {
  return const InputDecoration(
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    counterText: '',
    hintText: 'Full Name',
    border: OutlineInputBorder(),
    labelText: 'Enter Full Name',
  );
}

SizedBox logoSizeBox() {
  return const SizedBox(
    //image here
    height: 100,
    width: 100,
    child: LogoAsset(),
  );
}

Center circularProgressIndicator() =>
    const Center(child: CircularProgressIndicator());
