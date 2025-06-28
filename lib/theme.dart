import 'package:flutter/material.dart';
import 'constants/color.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: KnavyColor,
    secondary: KbeigeColor,
    surface: KbeigeColor,
    background: KbeigeColor,
    error: KerrorColor,
    onPrimary: Colors.white,
    onSecondary: KnavyColor,
    onSurface: KnavyColor,
    onBackground: KnavyColor,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: KbeigeColor,
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    backgroundColor: KnavyColor,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: KnavyColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: KnavyColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: KnavyColor.withOpacity(0.2)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: KnavyColor, width: 2),
    ),
    labelStyle: TextStyle(
      color: KnavyColor,
      fontFamily: 'Roboto',
    ),
    hintStyle: TextStyle(
      color: KnavyColor.withOpacity(0.5),
      fontFamily: 'Roboto',
    ),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    elevation: 2,
    margin: const EdgeInsets.all(12),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: KnavyColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    bodyLarge: TextStyle(
      color: KnavyColor,
      fontSize: 18,
      fontFamily: 'Roboto',
    ),
    bodyMedium: TextStyle(
      color: KnavyColor,
      fontSize: 16,
      fontFamily: 'Roboto',
    ),
    labelLarge: TextStyle(
      color: KnavyColor,
      fontSize: 14,
      fontFamily: 'Roboto',
    ),
  ),
);
