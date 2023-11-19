import 'package:email_client/responsive.dart';
import 'package:flutter/material.dart';

import '../data/local_storage.dart';
import '../screens/auth/info_dialog.dart';

class UIProvider with ChangeNotifier {
  final BuildContext _context;
  UIProvider(this._context);

  bool _initialized = false;
  bool get initialized => _initialized;

  final bool _infoDialogShown = false;
  bool get infoDialogShown => _infoDialogShown;

  bool _sideMenuIsOpen = true;
  bool get sideMenuIsOpen => _sideMenuIsOpen;

  final GlobalKey<ScaffoldState> _homeScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get homeScaffoldKey => _homeScaffoldKey;

  void appInitialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  void firstCheckAndShowInfoDialog(BuildContext context) {
    final didShowInfoDialog =
        LocalStorage().getValue<bool>('didShowInfoDialog');
    if (didShowInfoDialog == null || !didShowInfoDialog) {
      showInfoDialog(context);
      LocalStorage().setValue<bool>('didShowInfoDialog', true);
    }
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
}
