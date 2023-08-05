import 'package:email_client/data/databases/folder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/helper.dart';
import '../../services/mail_api.dart';
import '../../models/mail_folder.dart';
import '../../providers/mail/accounts.dart';
import '../../providers/ui_provider.dart';

class MailBoxProvider extends ChangeNotifier {
  final BuildContext _context;
  FolderDatabase? _folderDb;
  final MailAccountsProvider? _accountProvider;
  List<MailFolderModel>? _folders;
  List<MailFolderModel>? get folders =>
      _folders != null ? [..._folders!] : null;

  MailFolderModel? currentFolder;

  MailBoxProvider(this._context, this._accountProvider) {
    void init() async {
      final db = await DatabaseHelper().database;
      _folderDb = FolderDatabase(db);
      initializeFolders();
    }

    if (_accountProvider != null && _accountProvider?.currentAccount != null) {
      init();
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
    if (currentFolder == folder) {
      return;
    }
    currentFolder = folder;
    _context.read<UIProvider>().controlIsLoading(false);
    notifyListeners();
  }

  Future<void> initializeFolders() async {
    final allFolders = await _folderDb!
        .getFoldersByAccount(_accountProvider!.currentAccount!.email);
    if (allFolders.isNotEmpty) {
      _folders = [...allFolders];
      setCurrentFolder(getInboxFolder());
    }
    await getFolders();
  }

  Future<void> getFolders() async {
    final mailApi = MailApi(account: _accountProvider!.currentAccount!);
    try {
      final response = await mailApi.getFolders();

      final fetchedFolders =
          response.map((folder) => MailFolderModel.fromMap(folder)).toList();

      if (_folders != null &&
          MailFolderModel.areListsEqual(_folders!, fetchedFolders)) {
        return;
      }
      _folders = [...fetchedFolders];

      setCurrentFolder(getInboxFolder());

      if (_folders != null && _folders!.isNotEmpty) {
        _folderDb!
            .setMailFolders(_folders!, _accountProvider!.currentAccount!.email);
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  MailFolderModel getInboxFolder() {
    MailFolderModel? inboxFolder;
    try {
      inboxFolder = _folders!
          .firstWhere((folder) => folder.name.toLowerCase().contains('inbox'));
    } catch (_) {}
    return inboxFolder ?? _folders![0];
  }
}
