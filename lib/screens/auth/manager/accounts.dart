import 'package:email_client/providers/mail/accounts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../header.dart';
import 'account_tile.dart';

class AccountsManager extends StatelessWidget {
  final void Function(bool) controlShowingAccounts;
  const AccountsManager(this.controlShowingAccounts, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthHeader(false),
        Text('Manage Accounts', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Consumer<MailAccountsProvider>(builder: (context, accountProvider, __) {
          final accountsListTiles = accountProvider.mailAccounts
              .map(
                (account) => AccountTile(account),
              )
              .toList();
          return Column(
            children: accountsListTiles,
          );
        }),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () => controlShowingAccounts(false),
          icon: const Icon(Icons.add),
          label: const Text('Add New Account'),
        ),
      ],
    );
  }
}
