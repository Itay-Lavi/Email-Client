import 'package:flutter/material.dart';

class UIProvider with ChangeNotifier {
  bool _sideMenuIsOpen = true;
  bool get sideMenuIsOpen => _sideMenuIsOpen;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void controlSideMenu() {
    _sideMenuIsOpen = !_sideMenuIsOpen;
    notifyListeners();
  }

  void controlIsLoading(bool isLoadingState) {
    _isLoading = isLoadingState;
    notifyListeners();
  }
}
