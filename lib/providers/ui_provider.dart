import 'package:email_client/responsive.dart';
import 'package:flutter/material.dart';

class UIProvider with ChangeNotifier {
  final BuildContext _context;
  UIProvider(this._context);

  bool _sideMenuIsOpen = true;
  bool get sideMenuIsOpen => _sideMenuIsOpen;

  final GlobalKey<ScaffoldState> _homeScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get homeScaffoldKey => _homeScaffoldKey;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

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

  void controlIsLoading(bool isLoadingState) {
    _isLoading = isLoadingState;
    notifyListeners();
  }
}
