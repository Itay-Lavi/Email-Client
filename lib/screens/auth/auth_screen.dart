import 'package:email_client/models/mail_account.dart';
import 'package:email_client/providers/mail/accounts.dart';
import 'package:email_client/screens/auth/form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  static const routeName = '/auth-screen';

  @override
  Widget build(BuildContext context) {
    void addAccount(
        {required String email,
        required String password,
        required String host}) {
      final mailAccount =
          MailAccountModel(host: host, email: email, password: password);
      context.read<MailAccountsProvider>().addMailAccount(mailAccount);
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 212, 234, 252),
              Colors.white,
              Color.fromARGB(255, 255, 238, 213)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          Align(alignment: Alignment.center, child: AuthForm(addAccount))
        ],
      ),
    );
  }
}
