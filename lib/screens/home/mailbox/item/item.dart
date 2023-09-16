import 'package:email_client/providers/ui_provider.dart';
import 'package:email_client/screens/home/mailbox/item/trailing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/global_var.dart';
import '../../../../models/mail.dart';
import '../../../../providers/mail/list/provider.dart';
import '../../../../util/mail_logic.dart';

class MailBoxItem extends StatelessWidget {
  const MailBoxItem({super.key});

  @override
  Widget build(BuildContext context) {
    final mail = context.watch<MailModel>();

    String? fromAddress;
    String? fromName;
    try {
      fromAddress = getFromAddress(mail);
      fromName = getFromName(mail);
    } catch (_) {}
    if (fromName == null || fromName.isEmpty) fromName = fromAddress;
    int currentYear = DateTime.now().year;
    bool isCurrentYear = mail.timestamp.year == currentYear;

    MailModel? curMail = context
        .select<MailListProvider, MailModel?>((prov) => prov.selectedMail);
    bool mailIsSelected = curMail == mail;

    bool darkMode = context.select<UIProvider, bool>((prov) => prov.darkMode);

    Color? tileColor = mailIsSelected
        ? darkMode
            ? const Color.fromARGB(255, 94, 94, 94)
            : const Color.fromARGB(255, 229, 242, 253)
        : mail.isFlagged
            ? darkMode
                ? const Color.fromARGB(255, 93, 93, 54)
                : const Color.fromARGB(255, 255, 255, 202)
            : null;

    return Container(
      height: 70,
      decoration: const BoxDecoration(border: Border(top: borderSide)),
      child: ListTile(
          tileColor: tileColor,
          onTap: () =>
              context.read<MailListProvider>().selectCurrentEmail(mail),
          leading: CircleAvatar(
            child: Text(
              fromAddress![0] + fromAddress[1],
              maxLines: 1,
            ),
          ),
          title: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(
              fromName!,
              style: const TextStyle(fontSize: 18),
              maxLines: 1,
            ),
          ),
          subtitle: Text(
            mail.subject ?? 'none',
            style: TextStyle(
                color: mail.isSeen ? null : Colors.blue,
                fontWeight: mail.isSeen ? FontWeight.normal : FontWeight.bold),
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
          trailing: ItemTrailing(isCurrentYear: isCurrentYear)),
    );
  }
}
