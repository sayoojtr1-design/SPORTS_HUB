

import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String themeKey  = "theme";

  static Future<void> saveTheme(bool isDak) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDak);
  }

  static Future<bool> getTheme() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey) ?? false;

  }

}