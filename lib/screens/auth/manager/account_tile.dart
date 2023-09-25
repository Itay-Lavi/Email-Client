import 'dart:async';

import 'package:email_client/providers/mail/accounts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/mail_account.dart';

class AccountTile extends StatelessWidget {
  final MailAccountModel account;
  const AccountTile(
    this.account, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void removeAccountHandler() async {
      final removeAccount = await showConfirmationDialog(context);

      if (removeAccount) {
        // ignore: use_build_context_synchronously
        context.read<MailAccountsProvider>().removeMailAccount(account);
      }
    }

    return ListTile(
      key: ValueKey(account.email),
      leading: CircleAvatar(child: Text(account.email[0])),
      title: FittedBox(fit: BoxFit.contain, child: Text(account.email)),
      trailing: IconButton(
          onPressed: removeAccountHandler,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          )),
    );
  }

  Future<bool> showConfirmationDialog(BuildContext context) {
    Completer<bool> completer = Completer<bool>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Account Removal'),
          content: Text(
              'Are you sure you want to remove ${account.email} \nfrom your accounts?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                return completer.complete(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
                return completer.complete(true);
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );

    return completer.future;
  }
}
