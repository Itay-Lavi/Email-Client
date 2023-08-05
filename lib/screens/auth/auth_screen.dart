import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/mail_account.dart';
import '../../providers/mail/accounts.dart';
import '../home/home_screen.dart';
import 'form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    void addAccount(
        {required String email,
        required String password,
        required String host}) async {
      final mailAccount =
          MailAccountModel(host: host, email: email, password: password);
      try {
        await context.read<MailAccountsProvider>().addMailAccount(mailAccount);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } catch (e) {
        print(e);
      }
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
