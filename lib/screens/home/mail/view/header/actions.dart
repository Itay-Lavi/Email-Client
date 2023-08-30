import 'package:email_client/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/global_var.dart';
import '../../../../../providers/mail/list/provider.dart';
import '../../../../../providers/mail/mail_ui.dart';
import '../../../../../models/mail.dart';
import '../../../../../models/send_mail.dart';
import '../../../../../util/mail_logic.dart';
import '../../../../../widgets/btn_icon.dart';

const _minActionsWidth = 530;

class MailHeaderActions extends StatelessWidget {
  const MailHeaderActions({super.key});

  @override
  Widget build(BuildContext context) {
    final mail = context.watch<MailModel>();
    final mailUIProvider = context.read<MailUIProvider>();

    List<Widget> btnActions(bool showText) {
      void setMailDataAndControlEditor(MailDataModel mailData) {
        mailUIProvider.controlMailEditor(true);
        mailUIProvider.updateMailData(mail: mailData);
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
          title: showText ? 'Reply' : null,
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
          title: showText ? 'Reply All' : null,
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
          title: showText ? 'Forward' : null,
        ),
        MailHeaderBtnIcon(
          onTap: () => context
              .read<MailListProvider>()
              .flagEmail(mail, [globalflags[0]], !mail.isFlagged),
          icon: mail.isFlagged ? Icons.flag : Icons.flag_outlined,
          title: showText ? 'Flag' : null,
        ),
        MailHeaderBtnIcon(
          onTap: context.read<MailListProvider>().deleteEmail,
          icon: Icons.delete_outlined,
          title: showText ? 'Delete' : null,
        ),
      ];
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final showText =
            width > _minActionsWidth && !Responsive.isMobile(context);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: btnActions(showText),
        );
      },
    );
  }
}
