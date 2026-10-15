import 'package:flutter/material.dart';
import 'package:moneyflow/pages/local_storage.dart';
import 'package:moneyflow/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode;
  late ThemeData _themeData;

  ThemeProvider({required bool initialTheme})
      : isDarkMode = initialTheme {
    _themeData = isDarkMode ? darkmode : lightmode;
  }

  ThemeData get themeData => _themeData;

  Future<void> trigger() async {
    final bool newMode = !isDarkMode;

    // Save the new preference.
    await LocalStorage.setDarkMode(newMode);

    // Update the current state.
    isDarkMode = newMode;
    _themeData = isDarkMode ? darkmode : lightmode;

    // Notify listening widgets.
    notifyListeners();
  }
}
