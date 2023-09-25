// ignore_for_file: use_build_context_synchronously

import 'package:email_client/widgets/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/mail_account.dart';
import '../../../providers/mail/accounts.dart';

import '../../home/home_screen.dart';
import '../header.dart';
import './inputs.dart';

const defaultHost = 'gmail';

class AuthForm extends StatelessWidget {
  final void Function(bool) controlShowingAccounts;
  const AuthForm(this.controlShowingAccounts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mailAccountProv = context.watch<MailAccountsProvider>();
    final canPop =
        (Navigator.canPop(context) && mailAccountProv.currentAccount != null);

    Future<void> addAccount(MailAccountModel mailAccount) async {
      try {
        await mailAccountProv.addMailAccount(mailAccount);
      } catch (error) {
        if (error is ArgumentError) {
          showFlushBar(context, 'Invalid Credentials',
              error.message['response'], Colors.red);
        } else if ('$error'.contains('Exist')) {
          showFlushBar(context, 'Already Exists', 'Account is already added!',
              Colors.indigo);
        } else {
          showFlushBar(context, 'Error', 'An error occurred please try later',
              Colors.red);
        }
        return;
      }

      if (canPop) {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AuthHeader(true),
        FormInputs(
          addMailAccount: addAccount,
        ),
        if (mailAccountProv.mailAccounts.isNotEmpty) ...[
          const SizedBox(height: 15),
          TextButton.icon(
            label: const Text('Manage Accounts'),
            icon: const Icon(Icons.manage_accounts),
            onPressed: () => controlShowingAccounts(true),
          )
        ]
      ],
    );
  }
}
