// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../constants/color.dart';

/// Custom button widget
class CustomButton extends StatelessWidget {
  /// Function to call when the button is pressed
  final VoidCallback function;

  /// Button text
  final String buttonName;

  /// Button color
  final Color color;

  /// Button text color
  final Color textColor;

  /// Button width
  final double width;

  /// Button height
  final double height;

  /// Button border radius
  final double borderRadius;

  /// Creates a new [CustomButton] instance
  const CustomButton({
    Key? key,
    required this.function,
    required this.buttonName,
    this.color = KnavyColor,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        ),
        child: Text(
          buttonName,
          style: TextStyle(
            color: textColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}
