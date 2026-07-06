
import 'package:e_store/services/theme_service.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  bool isDark = false;

  ThemeMode themeMode = ThemeMode.light;

  ThemeProvider(){
    loadTheme();

  }
  Future<void> loadTheme() async {
    isDark = await ThemeService.getTheme();
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  Future<void> toggleTheme(bool value) async{
    isDark = value;
    themeMode =isDark ? ThemeMode.dark : ThemeMode.light;

    await ThemeService.saveTheme(isDark);
    notifyListeners();

  }

}
