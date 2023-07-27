import 'dart:async';

import 'package:email_client/providers/mail/mail_ui.dart';
import 'package:email_client/models/send_mail.dart';
import 'package:email_client/util/async.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/mail_api.dart';
import '../../models/mail.dart';
import '../../models/mail_account.dart';
import '../mail/mailbox.dart';

class MailListProvider extends ChangeNotifier {
  final BuildContext _context;
  final MailBoxProvider? _mailBoxProvider;
  MailAccountModel? account;
  List<MailModel>? _mails;
  List<MailModel>? get mails => _mails != null ? [..._mails!] : null;

  MailModel? _currentMail;
  MailModel? get currentMail => _currentMail;

  MailListProvider(this._context, this._mailBoxProvider, this.account) {
    if (_mailBoxProvider != null &&
        account != null &&
        _mailBoxProvider?.currentFolder != null) {
      performAsyncOperation(getEmails('0:20'));
    }
  }

  void selectCurrentEmail(MailModel? current) {
    _currentMail = (_currentMail == current) ? null : current;
    if (_currentMail != null) {
      _context.read<MailUIProvider>().controlMailEditor(false);
    }
    notifyListeners();
  }

  void setAccountAndFolderUnseen(int folderCount) {
    _mailBoxProvider!.currentFolder!.setUnseenCount(folderCount);

    final totalUnseenCount =
        _mailBoxProvider!.totalUnseenCount(_mailBoxProvider!.folders!);
    account!.setUnseenCount(totalUnseenCount);
  }

  Future<void> getEmails(String fetchSlice, [bool refresh = false]) async {
    Map<String, dynamic> body;
    List<MailModel> fetchedEmails;

    final currentFolder = _mailBoxProvider?.currentFolder;
    final callableFolderName =
        currentFolder?.callName ?? currentFolder?.name ?? 'inbox';

    final mailApi = MailApi(
        account: account!,
        folderName: callableFolderName,
        fetchSlice: fetchSlice);
    try {
      body = await mailApi.getMails();

      final response = body['response'] as List<dynamic>;
      fetchedEmails =
          response.map((email) => MailModel.fromMap(email)).toList();

      _mails ??= [];
      if (fetchedEmails.isNotEmpty) {
        if (refresh) {
          //if refresh is true, update deleted messages
          List<String?> fetchedEmailIds =
              fetchedEmails.map((mail) => mail.id).toList();
          _mails!.removeWhere((mail) => !fetchedEmailIds.contains(mail.id));
        }

        for (MailModel newMail in fetchedEmails) {
          int index = _mails!.indexWhere((mail) => mail.id == newMail.id);
          if (index != -1) {
            // MailModel with matching ID found, update it
            _mails![index] = newMail;
          } else {
            // MailModel with matching ID not found, add it
            _mails!.add(newMail);
          }
        }
      }

      setAccountAndFolderUnseen(body['unseenAmount']);
    } catch (_) {}

    notifyListeners();
  }

  Future<void> sendEmail(MailDataModel emailData) async {
    emailData.from = account!.email;
    final mailApi = MailApi(account: account!, emailData: emailData);

    try {
      await mailApi.sendMail();
    } catch (e) {
      print(e);
    }
  }
}

// Future<void> flagEmail(String messageId, String flag) {

// }
