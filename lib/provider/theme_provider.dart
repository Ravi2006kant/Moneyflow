import 'package:flutter/material.dart';
import 'package:moneyflow/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;
  ThemeData _themeData = lightmode;

  Future<void> savetheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isdarkmode') ?? false;
  }

  ThemeData get themeData {
    return isDarkMode ? darkmode : lightmode;
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //button
  Future<void> triger() async {
    isDarkMode = !isDarkMode;
    final pref = await SharedPreferences.getInstance();

    await pref.setBool('isdarkmode', isDarkMode);

    _themeData == lightmode ? _themeData = darkmode : _themeData = lightmode;
    notifyListeners();
  }
}
