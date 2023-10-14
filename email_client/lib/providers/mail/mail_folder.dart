import 'package:email_client/data/databases/folder.dart';
import 'package:email_client/models/mail_account.dart';
import 'package:email_client/services/folder_api.dart';
import 'package:flutter/material.dart';

import '../../data/helper.dart';
import '../../models/mail_folder.dart';

class MailFolderProvider with ChangeNotifier {
  FolderDatabase? _folderDb;
  List<MailFolderModel>? _folders;
  List<MailFolderModel>? get folders =>
      _folders != null ? [..._folders!] : null;

  MailAccountModel? currentAccount;
  MailFolderModel? currentFolder;

  MailFolderProvider(this.currentAccount) {
    void init() async {
      final db = await DatabaseHelper().database;
      _folderDb = FolderDatabase(db);
      initializeFolders();
    }

    if (currentAccount != null) {
      init();
    }
  }

  Future<void> initializeFolders() async {
    final allFolders =
        await _folderDb!.getFoldersByAccount(currentAccount!.email);
    if (allFolders.isNotEmpty) {
      _folders = [...allFolders];
      setCurrentFolder(getInboxFolder());
    }
    getFolders();
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

  bool setCurrentFolder(MailFolderModel folder) {
    if (currentFolder == folder) {
      return false;
    }
    currentFolder = folder;
    notifyListeners();
    return true;
  }

  Future<void> getFolders() async {
    final folderApi = FolderApiService(account: currentAccount!);
    try {
      final response = await folderApi.getFolders();

      final fetchedFolders =
          response.map((folder) => MailFolderModel.fromMap(folder)).toList();

      if (_folders != null &&
          MailFolderModel.areListsEqual(_folders!, fetchedFolders)) {
        return;
      }
      _folders = [...fetchedFolders];

      if (_folders!.isNotEmpty) {
        _folderDb!.setMailFolders(_folders!, currentAccount!.email);
      }

      final folderHasSet = setCurrentFolder(getInboxFolder());
      if (folderHasSet) return;
      notifyListeners();
    } catch (_) {}
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
