import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/global_var.dart';
import '../../../providers/mail/mail_list.dart';
import '../../../providers/mail/mailbox.dart';

class MailBoxHeader extends StatelessWidget {
  const MailBoxHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(border: Border(bottom: borderSide)),
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Search'),
                )),
                const SizedBox(width: 5),
                Consumer<MailListProvider>(
                  builder: (context, prov, _) => IconButton(
                      onPressed: () => context
                          .read<MailListProvider>()
                          .getEmails('0:${prov.mails!.length}', true),
                      icon: const Icon(Icons.refresh)),
                ),
                const SizedBox(width: 5),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.select_all)),
              ],
            ),
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
