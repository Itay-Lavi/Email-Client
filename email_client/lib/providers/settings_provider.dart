import 'package:flutter/material.dart';

import '../data/local_storage.dart';

class SettingsProvider with ChangeNotifier {
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  SettingsProvider() {
    void init() {
      _darkMode = LocalStorage().getValue<bool>('theme') ?? false;
      notifyListeners();
    }

    try {
      init();
    } catch (_) {}
  }

  void controlTheme(bool value) {
    _darkMode = value;
    LocalStorage().setValue<bool>('theme', _darkMode);
    notifyListeners();
  }
}
