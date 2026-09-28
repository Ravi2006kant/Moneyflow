import 'package:flutter/material.dart';
import 'package:moneyflow/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;
  ThemeData _themeData = lightmode;

  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void triger() {
    isDarkMode = !isDarkMode;
    _themeData == lightmode ? _themeData = darkmode : _themeData = lightmode;
    notifyListeners();
  }
}
