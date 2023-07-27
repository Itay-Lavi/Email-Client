import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/mail_api.dart';
import '../../models/mail_folder.dart';
import '../../providers/mail/accounts.dart';
import '../../providers/ui_provider.dart';

class MailBoxProvider extends ChangeNotifier {
  final BuildContext _context;
  final MailAccountsProvider? _accountProvider;
  List<MailFolderModel>? _folders;
  List<MailFolderModel>? get folders =>
      _folders != null ? [..._folders!] : null;

  MailFolderModel? currentFolder;

  MailBoxProvider(this._context, this._accountProvider) {
    if (_accountProvider != null && _accountProvider?.currentAccount != null) {
      getFolders();
    }
  }

  int totalUnseenCount(List<MailFolderModel> folders) {
    int totalCount = 0;
    for (final folder in folders) {
      totalCount += folder.unseenCount ?? 0;
      if (folder.children != null && folder.children!.isNotEmpty) {
        totalCount += totalUnseenCount(folder.children!);
      }
    }
    return totalCount;
  }

  void setCurrentFolder(MailFolderModel folder) {
    if (currentFolder != folder) {
      currentFolder = folder;
      _context.read<UIProvider>().controlIsLoading(false);
      notifyListeners();
    }
  }

  Future<void> getFolders() async {
    final mailApi = MailApi(account: _accountProvider!.currentAccount!);
    try {
      final response = await mailApi.getFolders();

      final fetchedFolders =
          response.map((folder) => MailFolderModel.fromMap(folder)).toList();

      _folders = [...fetchedFolders];
      MailFolderModel? inboxFolder;
      try {
        inboxFolder = _folders!.firstWhere(
            (folder) => folder.name.toLowerCase().contains('inbox'));
      } catch (_) {}

      setCurrentFolder(inboxFolder ?? _folders![0]);
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
