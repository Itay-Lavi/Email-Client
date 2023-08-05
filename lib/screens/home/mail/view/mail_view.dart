import 'package:email_client/models/mail.dart';
import 'package:email_client/providers/mail/mail_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail.dart';
import 'header/header.dart';

class MailView extends StatelessWidget {
  const MailView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentMail = context
        .select<MailListProvider, MailModel?>((prov) => prov.selectedMail);

    if (currentMail == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset('assets/images/no_mail_selected.png'),
          ),
          Text(
            'No Mail Selected',
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      );
    }

    return Column(
      children: [
        MailHeader(currentMail),
        const Divider(),
        Expanded(child: MailViewDetail(currentMail))
      ],
    );
  }
}
