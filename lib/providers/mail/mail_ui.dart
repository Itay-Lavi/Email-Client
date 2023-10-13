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
    if (_mailEditorIsOpen == state) return;
    _mailEditorIsOpen = state ??= !_mailEditorIsOpen;
    notifyListeners();
  }

  void updateMailData({MailDataModel? mail, Map<String, dynamic>? updates}) {
    if (mail != null) {
      _mailData = mail;
    }
    if (updates != null) {
      _mailData = _mailData.copyWith(
        from: updates['from'] ?? _mailData.from,
        to: updates['to'] ?? _mailData.to,
        subject: updates['subject'] ?? _mailData.subject,
        html: updates['html'] ?? _mailData.html,
      );
    }
  }
}
