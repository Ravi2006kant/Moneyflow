import 'package:flutter/material.dart';
import 'package:moneyflow/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  
  ThemeData _themeData = lightmode;

  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void triger() {
    if (_themeData == lightmode) {
      _themeData = darkmode;
    } else {
      _themeData = lightmode;
    }
    
  }
}
