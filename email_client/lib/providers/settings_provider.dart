import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  SettingsProvider() {
    void init() async {
      final prefs = await SharedPreferences.getInstance();
      _darkMode = prefs.getBool('theme') ?? false;
      notifyListeners();
    }

    init();
  }

  void controlTheme(bool value) async {
    _darkMode = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', _darkMode);
    notifyListeners();
  }
}
