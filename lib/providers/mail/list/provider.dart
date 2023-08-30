import 'dart:async';

import 'package:email_client/config/global_var.dart';
import 'package:email_client/data/databases/mail.dart';
import 'package:email_client/providers/mail/mail_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/helper.dart';
import '../../../models/mail_folder.dart';
import '../../../services/mail_api.dart';
import '../../../models/mail.dart';
import '../../../models/mail_account.dart';
import '../../../util/utils.dart';
import '../mailbox.dart';

part 'state.dart';

class MailListProvider with ChangeNotifier, MailListProviderState {
  final BuildContext _context;
  final MailBoxProvider? _mailBoxProvider;
  final MailAccountModel? _account;

  MailListProvider(this._context, this._mailBoxProvider, this._account) {
    void init() async {
      final db = await DatabaseHelper().database;
      _mailDb = MailDatabase(db);
      initializeEmails();
    }

    if (_account != null &&
        _mailBoxProvider != null &&
        _mailBoxProvider?.currentFolder != null) {
      init();
    }
  }

  Future<void> initializeEmails() async {
    final allEmails = await _mailDb!.getMailsByAccountAndFolder(
        _account!.email, _mailBoxProvider!.currentFolder!.id);

    if (allEmails.isNotEmpty) {
      _mails = [...allEmails];
      notifyListeners();
    }
    debounceOperation(getEmails('0:20'));
  }

  void selectCurrentEmail(MailModel? current) {
    _selectedMail = (_selectedMail == current) ? null : current;

    _context.read<MailUIProvider>().controlMailEditor(false);
    if (current != null && !current.isSeen) {
      flagEmail(current, [globalflags[1]], true);
      current.updateFlags([globalflags[1]], true);
    }
    notifyListeners();
  }

  void setAccountAndFolderUnseen(int folderCount) {
    _mailBoxProvider!.currentFolder!.setUnseenCount(folderCount);

    final totalUnseenCount =
        _mailBoxProvider!.totalUnseenCount(_mailBoxProvider!.folders!);
    _account!.setUnseenCount(totalUnseenCount);
  }

  Future<void> getEmails(String fetchSlice, [bool refresh = false]) async {
    Map<String, dynamic> body;
    List<MailModel> fetchedEmails;

    final currentFolder = _mailBoxProvider?.currentFolder;
    final callableFolderName =
        currentFolder?.callname ?? currentFolder?.name ?? 'inbox';

    final mailApi = MailApiService(
        account: _account!,
        folderName: callableFolderName,
        fetchSlice: fetchSlice);
    try {
      body = await mailApi.getMails();

      final response = body['response'] as List<dynamic>;
      setAccountAndFolderUnseen(body['unseenAmount']);
      fetchedEmails =
          response.map((email) => MailModel.fromMap(email)).toList();
      _mails ??= [];

      if (fetchedEmails.isEmpty) return notifyListeners();
      if (MailModel.areListsEqual(_mails!, fetchedEmails)) return;

      final maxFetchNum = int.parse(fetchSlice.split(':')[1]);
      if (maxFetchNum <= 20) {
        List<String?> fetchedEmailIds =
            fetchedEmails.map((mail) => mail.id).toList();
        _mails!.removeWhere((mail) => !fetchedEmailIds.contains(mail.id));
      }

      for (MailModel newMail in fetchedEmails) {
        int index = _mails!.indexWhere((mail) => mail.id == newMail.id);
        if (index != -1) {
          _mails![index] =
              newMail; // MailModel with matching ID found, update it
        } else {
          _mails!.add(newMail); // MailModel with matching ID not found, add it
        }
      }

      if (maxFetchNum <= 20 && currentFolder!.id != null) {
        _mailDb!.setMails(_mails!, _account!.email, currentFolder.id!);
      }
    } catch (_) {}

    notifyListeners();
  }

  Future<void> sendEmail() async {
    final emailData = _context.read<MailUIProvider>().mailData;
    emailData.from = _account!.email;

    final mailApi = MailApiService(account: _account!, emailData: emailData);
    _context.read<MailUIProvider>().controlMailEditor(false);

    try {
      await mailApi.sendMail();
    } catch (_) {}
  }

  Future<void> flagEmail(
      MailModel mail, List<String> flags, bool addFlags) async {
    final mailApi = MailApiService(account: _account!);
    mail.updateFlags(flags, addFlags);
    try {
      await mailApi.flagMail(mail.id!, flags, addFlags);
    } catch (e) {
      mail.updateFlags(flags, !addFlags);
    }
  }

  Future<void> moveEmail(MailModel mail, String specialUseAttrib) async {
    String? folderCallname;
    try {
      MailFolderModel? foundFolder =
          MailFolderModel.findFolderBySpecialUseAttribInList(
              _mailBoxProvider!.folders, specialUseAttrib);
      folderCallname = foundFolder?.callname;
    } catch (_) {}

    if (folderCallname == null) {
      return;
    }

    _mails!.remove(mail);
    notifyListeners();

    final mailApi =
        MailApiService(account: _account!, folderName: folderCallname);
    try {
      await mailApi.moveMailFolder(mail.id!, folderCallname);
    } catch (_) {}
  }

  Future<void> getEmailsByText(String text) async {
    _context.read<MailUIProvider>().controlShowFilteredMails(true);
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

    try {
      final body = await mailApi.getMailsByText(text);
      final response = body['response'] as List<dynamic>;
      final fetchedEmails =
          response.map((email) => MailModel.fromMap(email)).toList();

      _filteredMails = [...fetchedEmails];

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteEmail([MailModel? mail]) async {
    if (selectedMail == null && mail == null) return;
    moveEmail(mail ?? selectedMail!, specialUseAttribTypes[0]);
    selectCurrentEmail(null);
  }
}
