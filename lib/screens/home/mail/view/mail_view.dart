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
        .select<MailListProvider, MailModel?>((prov) => prov.currentMail);

    if (currentMail == null) {
      return const SizedBox();
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
