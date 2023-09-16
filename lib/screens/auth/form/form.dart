// ignore_for_file: use_build_context_synchronously

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
        color: Theme.of(context).colorScheme.background,
        surfaceTintColor: const Color.fromARGB(255, 220, 239, 255),
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FormHeader(),
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
