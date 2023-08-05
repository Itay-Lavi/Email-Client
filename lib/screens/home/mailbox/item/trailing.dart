import 'package:email_client/providers/mail/mail_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../config/global_var.dart';
import '../../../../models/mail.dart';
import 'action_btn.dart';

class ItemTrailing extends StatelessWidget {
  const ItemTrailing({
    super.key,
    required this.isCurrentYear,
    required this.mail,
    required this.textStyle,
  });

  final bool isCurrentYear;
  final MailModel mail;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    void deleteItem() {
      context
          .read<MailListProvider>()
          .moveEmail(mail, specialUseAttribTypes[0]);
    }

    void flagItem() {
      bool addFlag = true;
      if (mail.isFlagged) {
        addFlag = false;
      }
      context
          .read<MailListProvider>()
          .flagEmail(mail, [globalflags[0]], addFlag);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemActionBtn(
                icon: Icons.flag_outlined,
                tooltip: 'Flag Item',
                onPressed: flagItem,
                selected: mail.isFlagged,
              ),
              ItemActionBtn(
                icon: Icons.delete_outline,
                tooltip: 'Delete Item',
                onPressed: deleteItem,
                selected: false,
              ),
            ],
          ),
        ),
        Text(
          '${isCurrentYear ? DateFormat.E().format(mail.timestamp) : ''}, ${isCurrentYear ? DateFormat.Md().format(mail.timestamp) : DateFormat.yMd().format(mail.timestamp)}',
          style: textStyle,
        ),
      ],
    );
  }
}
