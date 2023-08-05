import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/global_var.dart';
import '../../../../../providers/mail/mail_list.dart';
import '../../../../../providers/mail/mail_ui.dart';
import '../../../../../models/mail.dart';
import '../../../../../models/send_mail.dart';
import '../../../../../util/mail_logic.dart';
import '../../../../../widgets/btn_icon.dart';

List<MailHeaderBtnIcon> btnActions(
    BuildContext context, MailUIProvider uiProv, MailModel mail) {
  void setMailDataAndControlEditor(MailDataModel mailData) {
    uiProv.controlMailEditor(true);
    uiProv.setMailData(mailData);
  }

  void deleteMail() {
    final mailProv = context.read<MailListProvider>();
    mailProv.selectCurrentEmail(null);
    mailProv.moveEmail(mail, specialUseAttribTypes[0]);
  }

  return [
    MailHeaderBtnIcon(
      onTap: () {
        setMailDataAndControlEditor(MailDataModel(
          from: '',
          to: getAddressList(mail.from),
          subject: mail.subject ?? 'null',
          html: mail.html ?? '',
        ));
      },
      icon: Icons.reply_outlined,
      title: 'Reply',
    ),
    MailHeaderBtnIcon(
      onTap: () {
        setMailDataAndControlEditor(MailDataModel(
          from: '',
          to: [...getAddressList(mail.from), ...getAddressList(mail.to)],
          subject: mail.subject ?? 'null',
          html: mail.html ?? '',
        ));
      },
      icon: Icons.reply_all_outlined,
      title: 'Reply All',
    ),
    MailHeaderBtnIcon(
      onTap: () {
        setMailDataAndControlEditor(MailDataModel(
          from: '',
          to: [],
          subject: mail.subject ?? 'null',
          html: mail.html ?? '',
        ));
      },
      icon: Icons.forward_outlined,
      title: 'Forward',
    ),
    MailHeaderBtnIcon(
      onTap: deleteMail,
      icon: Icons.delete_outlined,
      title: 'Delete',
    ),
  ];
}
