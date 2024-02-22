// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'package:flutter/material.dart';



// ignore: constant_identifier_names
const MaterialAccentColor KprimaryColor = Colors.blueAccent;
// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}
