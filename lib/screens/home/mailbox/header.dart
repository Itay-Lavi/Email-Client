import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/global_var.dart';
import '../../../providers/mail/list/provider.dart';
import '../../../providers/mail/mailbox.dart';
import '../widgets/search_field.dart';

class MailBoxHeader extends StatelessWidget {
  const MailBoxHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: const Border(bottom: borderSide),
          color: Theme.of(context).colorScheme.background,
        ),
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                  child: SearchField(
                searchFieldController: TextEditingController(),
              )),
              const SizedBox(width: 5),
              Consumer<MailListProvider>(
                  builder: (context, mailProv, _) => IconButton(
                      onPressed: () => mailProv.getEmails(
                          '0:${mailProv.mails!.length}', true),
                      icon: const Icon(Icons.refresh))),
            ]),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<MailBoxProvider>(
                  builder: (ctx, mailProv, _) {
                    return Text(
                      mailProv.currentFolder?.name ?? 'inbox',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    );
                  },
                ),
                DropdownButton(items: const [], onChanged: (v) {})
              ],
            )
          ],
        ));
  }
}
