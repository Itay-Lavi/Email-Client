import 'package:flutter/material.dart';

import '../../../models/mail.dart';
import '../../../models/mail_account.dart';
import '../../../models/mail_folder.dart';
import '../../../services/mail_api.dart';
import '../mail_folder.dart';

class FilteredMailListProvider with ChangeNotifier {
  final MailAccountModel? _account;
  final MailFolderProvider? _mailBoxProvider;

  FilteredMailListProvider(this._account, this._mailBoxProvider);

  List<MailModel>? _filteredMails;
  List<MailModel>? get filteredMails =>
      _filteredMails != null ? [..._filteredMails!] : null;

  bool _showFilteredMails = false;
  bool get showFilteredMails => _showFilteredMails;

  void controlShowFilteredMails([bool? state]) {
    if (_showFilteredMails == state) return;
    _showFilteredMails = state ??= !_showFilteredMails;
    notifyListeners();
  }

  Future<void> getFilteredEmails(String text) async {
    controlShowFilteredMails(true);
    _filteredMails = null;
    notifyListeners();

    MailFolderModel? folderAll =
        MailFolderModel.findFolderBySpecialUseAttribInList(
            _mailBoxProvider!.folders!, 'All');

    if (folderAll?.callname == null &&
        _mailBoxProvider?.currentFolder?.callname == null) {
      throw 'please try again later!';
    } else {
      folderAll ??= _mailBoxProvider?.currentFolder;
    }

    final mailApi = MailApiService(
      account: _account!,
      folderName: folderAll!.callname,
    );

    final body = await mailApi.getMailsByText(text);
    final response = body['response'] as List<dynamic>;
    final fetchedEmails =
        response.map((email) => MailModel.fromMap(email)).toList();

    _filteredMails = [...fetchedEmails];

    notifyListeners();
  }
}
