import 'package:email_client/responsive.dart';
import 'package:flutter/material.dart';

class UIProvider with ChangeNotifier {
  final BuildContext _context;
  UIProvider(this._context);

  bool _initialized = false;
  bool get initialized => _initialized;

  bool _sideMenuIsOpen = true;
  bool get sideMenuIsOpen => _sideMenuIsOpen;

  bool _darkMode = false;
  bool get darkMode => _darkMode;

  final GlobalKey<ScaffoldState> _homeScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get homeScaffoldKey => _homeScaffoldKey;

  void appInitialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  void controlSideMenu() {
    if (!Responsive.isDesktop(_context)) {
      return controlDrawer();
    }
    _sideMenuIsOpen = !_sideMenuIsOpen;

    notifyListeners();
  }

  void controlDrawer() {
    if (!_homeScaffoldKey.currentState!.isDrawerOpen) {
      _homeScaffoldKey.currentState!.openDrawer();
    } else if (_homeScaffoldKey.currentState!.isDrawerOpen) {
      _homeScaffoldKey.currentState!.closeDrawer();
    }
  }

  void controlTheme(bool value) {
    _darkMode = value;
    notifyListeners();
  }
}
