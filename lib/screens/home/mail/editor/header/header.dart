// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:email_client/providers/mail/list/provider.dart';
import 'package:email_client/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:email_client/models/mail_account.dart';
import 'package:email_client/providers/mail/mail_ui.dart';
import 'package:email_client/widgets/btn_icon.dart';

import '../../../../../models/send_mail.dart';
import '../../../../../providers/mail/accounts.dart';
import 'custom_textfield.dart';

class MailEditorHeader extends StatelessWidget {
  final MailDataModel mailData;
  const MailEditorHeader(
    this.mailData, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mailUiProv = context.read<MailUIProvider>();
    final account = context.select<MailAccountsProvider, MailAccountModel>(
        (prov) => prov.currentAccount!);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: CustomTextField(
                controller: TextEditingController(text: account.email),
                prefixText: 'From: ',
                enabled: false,
                onChanged: (v) => {},
              ),
            ),
            if (!Responsive.isAllMobile(context))
              MailHeaderBtnIcon(
                  onTap: mailUiProv.controlMailEditor,
                  icon: Icons.delete_outline,
                  title: 'Discard'),
            if (!Responsive.isMobile(context))
              MailHeaderBtnIcon(
                  onTap: context.read<MailListProvider>().sendEmail,
                  icon: Icons.send,
                  title: 'Send')
          ]),
          CustomTextField(
              controller: TextEditingController(text: mailData.toToText()),
              prefixText: 'To: ',
              labelText: 'To',
              onChanged: (val) => mailUiProv.updateMailData(
                  updates: {'to': MailDataModel.toToList(val)})),
          CustomTextField(
            controller: TextEditingController(text: mailData.subject),
            prefixText: 'Subject: ',
            labelText: 'Subject',
            onChanged: (val) =>
                mailUiProv.updateMailData(updates: {'subject': val}),
          ),
        ],
      ),
    );
  }
}
