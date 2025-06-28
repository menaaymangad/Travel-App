// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Custom text field widget
class CustomTextField extends StatelessWidget {
  /// Text field controller
  final TextEditingController? controller;

  /// Text field hint text
  final String hint;

  /// Text field label text
  final String label;

  /// Whether the text field is for password input
  final bool isPassword;

  /// Icon to display at the end of the text field
  final Widget? suffixIcon;

  /// Function to validate the text field input
  final String? Function(String?)? validator;

  /// Function to call when the text field value changes
  final void Function(String)? onChanged;

  /// Creates a new [CustomTextField] instance
  const CustomTextField({
    Key? key,
    this.controller,
    required this.hint,
    required this.label,
    this.isPassword = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: suffixIcon,
        // Use theme's InputDecorationTheme
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
