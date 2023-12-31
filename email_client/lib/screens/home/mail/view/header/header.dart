import 'package:email_client/providers/mail/mail_ui.dart';
import 'package:email_client/responsive.dart';
import 'package:email_client/screens/home/mail/view/header/details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/mail.dart';
import '../../../../../widgets/btn_icon.dart';
import 'actions.dart';

class MailHeader extends StatelessWidget {
  final MailModel mail;
  const MailHeader(this.mail, {super.key});

  @override
  Widget build(BuildContext context) {
    final mailActionsIsOpen =
        context.select<MailUIProvider, bool>((prov) => prov.mailActionsIsOpen);
    final mailUIProvider = context.read<MailUIProvider>();

    final expandedBtn = MailHeaderBtnIcon(
        onTap: mailUIProvider.controlMailActions,
        title: mailActionsIsOpen ? 'Close Menu' : 'Open Menu',
        icon: mailActionsIsOpen ? Icons.arrow_upward : Icons.arrow_downward);

    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: mailActionsIsOpen
          ? Column(
              children: [
                if (!Responsive.isMobile(context))
                  ChangeNotifierProvider.value(
                      value: mail, child: const MailHeaderActions()),
                const SizedBox(height: 5),
                Text(mail.subject ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: HeaderMailDetails(mail)),
                    expandedBtn,
                  ],
                )
              ],
            )
          : Align(alignment: Alignment.bottomRight, child: expandedBtn),
    );
  }
}
