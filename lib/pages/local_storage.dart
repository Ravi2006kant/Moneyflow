
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  // Initialize SharedPreferences once at startup.
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Dark mode.
  static Future<bool> getDarkMode() async {
    return prefs.getBool('isDarkMode') ?? false;
  }

  static Future<void> setDarkMode(bool value) async {
    await prefs.setBool('isDarkMode', value);
  }

  // Onboarding.
  static Future<void> setIntroSeen() async {
    await prefs.setBool('hasSeenIntro', true);
  }

  static Future<bool> hasSeenIntro() async {
    return prefs.getBool('hasSeenIntro') ?? false;
  }

  // Username.
  static Future<bool> hasUserName() async {
    return prefs.containsKey('userName');
  }

  static Future<void> saveUserName(String name) async {
    await prefs.setString('userName', name);
  }

  static Future<String?> getUserName() async {
    return prefs.getString('userName');
  }
}
