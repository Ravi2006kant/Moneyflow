import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  brightness: .light,
  colorScheme: ColorScheme.light(surface: Colors.white, primary: Colors.green),
);

ThemeData darkmode = ThemeData(
  brightness: .dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade500,
    primary: Colors.grey.shade900,
  ),
);
