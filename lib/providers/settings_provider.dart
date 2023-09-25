import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  void controlTheme(bool value) {
    _darkMode = value;
    notifyListeners();
  }
}
