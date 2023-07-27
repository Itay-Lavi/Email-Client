import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../config/global_var.dart';
import '../../../../models/mail.dart';
import '../../../../providers/mail/mail_list.dart';

class MailBoxItem extends StatelessWidget {
  final MailModel mail;
  const MailBoxItem(this.mail, {super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.black);

    String? fromAddress;
    String? fromName;
    try {
      fromAddress = mail.from?['value'][0]['address'] ?? 'none';
      fromName = mail.from?['value'][0]['name'];
    } catch (_) {}

    if (fromName == null || fromName.isEmpty) fromName = fromAddress;

    int currentYear = DateTime.now().year;
    bool isCurrentYear = mail.timestamp.year == currentYear;

    return Container(
      height: 70,
      decoration: const BoxDecoration(border: Border(top: borderSide)),
      child: ListTile(
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
              style: textStyle.copyWith(fontSize: 18),
              maxLines: 1,
            ),
          ),
          subtitle: Text(
            mail.subject ?? 'none',
            style: TextStyle(
                color: mail.seen ? Colors.black : Colors.blue,
                fontWeight: mail.seen ? FontWeight.normal : FontWeight.bold),
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
          trailing: Text(
            '${isCurrentYear ? DateFormat.E().format(mail.timestamp) : ''}, ${isCurrentYear ? DateFormat.Md().format(mail.timestamp) : DateFormat.yMd().format(mail.timestamp)}',
            style: textStyle,
          )),
    );
  }
}
