// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'package:flutter/material.dart';

/// Navy color for minimalist theme
const Color KnavyColor = Color(0xFF223A5E);

/// Beige color for minimalist theme
const Color KbeigeColor = Color(0xFFF5F5DC);

/// Primary color for the app (now navy)
const Color KprimaryColor = KnavyColor;

/// Secondary color for the app
const Color KsecondaryColor = Color(0xff4a76a8);

/// Background color for the app
const Color KbackgroundColor = KbeigeColor;

/// Text color for the app
const Color KtextColor = KnavyColor;

/// Error color for the app
const Color KerrorColor = Color(0xffe64646);

/// Success color for the app
const Color KsuccessColor = Color(0xff4bb34b);

/// Warning color for the app
const Color KwarningColor = Color(0xffffa000);

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
