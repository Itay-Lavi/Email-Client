import 'package:flutter/material.dart';

import '../../models/send_mail.dart';

class MailUIProvider with ChangeNotifier {
  bool _mailActionsIsOpen = true;
  bool get mailActionsIsOpen => _mailActionsIsOpen;

  bool _mailEditorIsOpen = false;
  bool get mailEditorIsOpen => _mailEditorIsOpen;

  MailDataModel _mailData =
      MailDataModel(from: '', to: [], subject: '', html: '');
  MailDataModel get mailData => _mailData;

  void controlMailActions() {
    _mailActionsIsOpen = !_mailActionsIsOpen;
    notifyListeners();
  }

  void controlMailEditor([bool? state]) {
    _mailEditorIsOpen = state ??= !_mailEditorIsOpen;
    notifyListeners();
  }

  void setMailData(MailDataModel mailData) {
    _mailData = mailData;
    notifyListeners();
  }
}
