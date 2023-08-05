import 'package:email_client/providers/mail/mail_ui.dart';
import 'package:email_client/screens/home/mail/editor/header/header.dart';
import 'package:email_client/screens/home/mail/editor/html_editor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mail/mail_list.dart';
import '../../../../models/send_mail.dart';
import '../../../../widgets/snackbar.dart';

class MailEditor extends StatelessWidget {
  const MailEditor({super.key});

  @override
  Widget build(BuildContext context) {
    void sendMail(MailDataModel mailData) async {
      if (!mailData.validate()) {
        showButtonSnackbar(context, 'Type emails correctly!');
        return;
      }

      try {
        await context.read<MailListProvider>().sendEmail(mailData);
        // ignore: use_build_context_synchronously
        context.read<MailUIProvider>().controlMailEditor(false);
      } catch (error) {
        showButtonSnackbar(context, 'An error occurred!');
      }
    }

    return Column(
      children: [
        MailEditorHeader(sendMail: sendMail),
        const Expanded(child: MailHtmlEditor())
      ],
    );
  }
}
