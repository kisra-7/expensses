import 'package:expenses_tracker/constants/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) {
  return ThemeProvider();
});

class ThemeProvider extends ChangeNotifier {
  bool isDark = true;
  ThemeProvider() {
    loadThemeData();
  }

  void loadThemeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool(Consts.themeKey) ?? true;
    notifyListeners();
  }

  void toggleTheme(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = val;
    notifyListeners();
    print(isDark.toString());
    prefs.setBool(Consts.themeKey, isDark);
  }
}
