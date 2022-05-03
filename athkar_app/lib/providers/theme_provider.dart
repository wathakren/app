import 'package:wathakren/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider extends ChangeNotifier {
  Color kPrimary = Colors.brown;
  Color accentColor = Color(0xFFEEC373);
  Color textColor = Color(0xFF282018);
  Color appBarColor = Color(0xFFF4DFBA);
  Color elevationColor = Color(0xFFCA965C);
  ThemeProvider() {
    loadTheme();
  }

  setTheme({required Map<String, Color> colors}) {
    kPrimary = colors["_kPrimary"] ?? kPrimary;
    accentColor = colors["_accentColor"] ?? kPrimary;
    textColor = colors["_textColor"] ?? kPrimary;
    appBarColor = colors["_appBarColor"] ?? kPrimary;
    elevationColor = colors["_elevationColor"] ?? kPrimary;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: kPrimary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
    notifyListeners();
    saveTheme();
    notifyListeners();
  }

  void saveTheme() {
    sharedPreferences!.setStringList(
        "themeMap",
        [kPrimary, accentColor, textColor, appBarColor, elevationColor]
            .map((e) => e.value.toString())
            .toList());
  }

  void loadTheme() {
    List<String>? map = sharedPreferences!.getStringList("themeMap");
    if (map == null) {
      return;
    }
    kPrimary = Color(int.parse(map[0]));
    accentColor = Color(int.parse(map[1]));
    textColor = Color(int.parse(map[2]));
    appBarColor = Color(int.parse(map[3]));
    elevationColor = Color(int.parse(map[4]));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: kPrimary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
    notifyListeners();
  }
}
