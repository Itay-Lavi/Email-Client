// ignore_for_file: use_build_context_synchronously

import 'package:email_client/providers/mail/mail_ui.dart';
import 'package:flutter/material.dart';

import '../../models/mail_account.dart';
import '../../services/mail_api.dart';
import '../../widgets/flushbar.dart';

class SendEmailProvider with ChangeNotifier {
  final MailAccountModel? _account;
  final MailUIProvider? _mailUIProvider;

  SendEmailProvider(this._account, this._mailUIProvider);

  Future<void> sendEmail(BuildContext ctx) async {
    final emailData = _mailUIProvider!.mailData;
    emailData.from = _account!.email;

    final mailApi = MailApiService(account: _account!, emailData: emailData);

    try {
      await mailApi.sendMail();
      _mailUIProvider!.controlMailEditor(false);
    } catch (error) {
      if (error is ArgumentError) {
        showFlushBar(ctx, 'Error',
            'Unable to send email, ${error.message['response']}', Colors.red);
      } else {
        showFlushBar(ctx, 'Error', 'Unable to send email, $error', Colors.red);
      }
    }
  }
}
