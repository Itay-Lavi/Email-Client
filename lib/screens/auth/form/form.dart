import 'package:email_client/widgets/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/mail_account.dart';
import '../../../providers/mail/accounts.dart';

import '../../home/home_screen.dart';
import './header.dart';
import './inputs.dart';

const defaultHost = 'gmail';

class AuthForm extends StatelessWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mailAccountProv = context.read<MailAccountsProvider>();
    final canPop =
        (Navigator.canPop(context) && mailAccountProv.currentAccount != null);

    Future<void> addAccount(MailAccountModel mailAccount) async {
      try {
        await mailAccountProv.addMailAccount(mailAccount);
      } on ArgumentError catch (error) {
        // ignore: use_build_context_synchronously
        showFlushBar(context, 'Invalid Credentials', error.message['response'],
            Colors.red);
        return;
      }

      await Future.delayed(const Duration(milliseconds: 300), () {
        if (canPop) {
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }
      });
    }

    return SizedBox(
      width: 400,
      child: Card(
        surfaceTintColor: const Color.fromARGB(255, 220, 239, 255),
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormHeader(canPop),
              FormInputs(
                addMailAccount: addAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
