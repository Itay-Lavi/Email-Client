import 'package:email_client/gen/assets.gen.dart';
import 'package:email_client/providers/mail/list/filtered.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../providers/mail/list/provider.dart';
import '../../../responsive.dart';
import './header.dart';
import './listview.dart';

class Mailbox extends StatelessWidget {
  const Mailbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(right: borderSide)),
      width: Responsive.isAllMobile(context) ? double.infinity : 380,
      child: Column(
        children: [
          if (!Responsive.isMobile(context)) const MailBoxHeader(),
          Expanded(child: Consumer2<MailListProvider, FilteredMailListProvider>(
            builder: (context, mailListProv, filteredListProvider, _) {
              final mails = filteredListProvider.showFilteredMails
                  ? filteredListProvider.filteredMails
                  : mailListProv.mails;

              if (mails == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (mails.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.icons.noData.image(scale: 4),
                    const Text('No Emails Found!')
                  ],
                );
              }
              return MailBoxListView(mails);
            },
          )),
        ],
      ),
    );
  }
}
