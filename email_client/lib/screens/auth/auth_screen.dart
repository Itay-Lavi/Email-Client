import 'package:email_client/providers/mail/accounts.dart';
import 'package:email_client/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'manager/accounts.dart';
import 'form/form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showAccounts = true;

  void controlShowingAccounts(bool value) {
    setState(() {
      showAccounts = value;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<UIProvider>().firstCheckAndShowInfoDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.background;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 212, 234, 252),
              backgroundColor,
              const Color.fromARGB(255, 255, 238, 213)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: SizedBox(
                    width: 400,
                    child: Card(
                        color: backgroundColor,
                        surfaceTintColor: backgroundColor,
                        elevation: 12,
                        child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Consumer<MailAccountsProvider>(
                              builder: (context, accountProvider, _) {
                                final anyAccountsExists =
                                    accountProvider.mailAccounts.isNotEmpty;

                                return anyAccountsExists && showAccounts
                                    ? AccountsManager(controlShowingAccounts)
                                    : AuthForm(controlShowingAccounts);
                              },
                            )))),
              ))
        ],
      ),
    );
  }
}
