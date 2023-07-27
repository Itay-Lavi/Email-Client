import 'package:flutter/material.dart';

import '../../../../../providers/mail/mail_ui.dart';
import '../../../../../models/mail.dart';
import '../../../../../models/send_mail.dart';
import '../../../../../widgets/btn_icon.dart';

List<MailHeaderBtnIcon> btnActions(MailUIProvider uiProv, MailModel mail) {
  void setMailDataAndControlEditor(MailDataModel mailData) {
    uiProv.controlMailEditor(true);
    uiProv.setMailData(mailData);
  }

  List<String> getAddressList(Map<String, dynamic>? mail) {
    List<String> addressList = [];

    try {
      final addressArr = mail?['value'] as List<dynamic>;
      addressList =
          addressArr.map((value) => value['address'] as String? ?? '').toList();
    } catch (_) {}

    return addressList;
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
      onTap: () {
        // Handle delete action here
      },
      icon: Icons.delete_outlined,
      title: 'Delete',
    ),
  ];
}
