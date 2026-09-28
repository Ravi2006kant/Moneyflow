import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  brightness: .light,
  colorScheme: ColorScheme.light(
    secondary: Colors.green,
    surface: Colors.white,
    primary: Colors.green,
  ),
);

ThemeData darkmode = ThemeData(
  brightness: .dark,
  colorScheme: ColorScheme.dark(
    secondary: Colors.grey.shade900,
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
  ),
);
