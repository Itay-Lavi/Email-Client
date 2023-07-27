// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:email_client/models/mail_account.dart';
import 'package:email_client/providers/mail/mail_ui.dart';
import 'package:email_client/widgets/btn_icon.dart';

import '../../../../../models/send_mail.dart';
import '../../../../../providers/mail/accounts.dart';
import 'custom_textfield.dart';

class MailEditorHeader extends StatelessWidget {
  final Function sendMail;
  const MailEditorHeader({
    Key? key,
    required this.sendMail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mailUiProv = context.watch<MailUIProvider>();
    final account = context.select<MailAccountsProvider, MailAccountModel>(
        (prov) => prov.currentAccount!);
    final MailDataModel mailData = mailUiProv.mailData;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: TextEditingController(text: account.email),
                  prefixText: 'From: ',
                  enabled: false,
                  onChanged: (val) => mailData.from = val,
                ),
              ),
              MailHeaderBtnIcon(
                  onTap: mailUiProv.controlMailEditor,
                  icon: Icons.delete_outline,
                  title: 'Discard'),
              MailHeaderBtnIcon(
                  onTap: () => sendMail(mailData),
                  icon: Icons.send,
                  title: 'Send')
            ],
          ),
          CustomTextField(
              controller: TextEditingController(text: mailData.toToText()),
              prefixText: 'To: ',
              labelText: 'To',
              onChanged: (val) => mailData.to = MailDataModel.toToList(val)),
          CustomTextField(
            controller: TextEditingController(text: mailData.subject),
            prefixText: 'Subject: ',
            labelText: 'Subject',
            onChanged: (val) => mailData.subject = val,
          ),
        ],
      ),
    );
  }
}
