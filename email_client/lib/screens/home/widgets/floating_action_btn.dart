import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/send_mail.dart';
import '../../../providers/mail/mail_ui.dart';

class HomeFloatingBtn extends StatelessWidget {
  const HomeFloatingBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void newMail() {
      context.read<MailUIProvider>().controlMailEditor(true);
      context.read<MailUIProvider>().updateMailData(
          mail: MailDataModel(from: '', to: [], subject: '', html: ''));
    }

    return FloatingActionButton(
      onPressed: newMail,
      child: const Icon(Icons.add),
    );
  }
}
