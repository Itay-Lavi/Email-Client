import 'package:email_client/providers/mail/list/provider.dart';
import 'package:email_client/responsive.dart';
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
  });

  final bool isCurrentYear;

  @override
  Widget build(BuildContext context) {
    final mail = context.watch<MailModel>();
    void flagItem() {
      context
          .read<MailListProvider>()
          .flagEmail(mail, [globalflags[0]], !mail.isFlagged);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (!Responsive.isAllMobile(context))
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
                  onPressed: () =>
                      context.read<MailListProvider>().deleteEmail(mail),
                  selected: false,
                ),
              ],
            ),
          ),
        Text(
          '${isCurrentYear ? '${DateFormat.E().format(mail.timestamp)},' : ''} ${isCurrentYear ? DateFormat.Md().format(mail.timestamp) : DateFormat.yMd().format(mail.timestamp)}',
        ),
      ],
    );
  }
}
