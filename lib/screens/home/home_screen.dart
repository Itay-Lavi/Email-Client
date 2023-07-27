import 'package:email_client/models/mail_account.dart';
import 'package:email_client/providers/mail/mail_ui.dart';
import 'package:email_client/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/mail/accounts.dart';
import '../../providers/ui_provider.dart';
import '../../widgets/side_menu/side_menu.dart';
import '../splash_screen.dart';
import './mailbox/mailbox.dart';
import './mail/view/mail_view.dart';
import './mail/editor/mail_editor.dart';

//import 'package:flutter/foundation.dart' show kIsWeb;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final curAccount = context.select<MailAccountsProvider, MailAccountModel?>(
        (prov) => prov.currentAccount);
    final isLoading =
        context.select<UIProvider, bool>((prov) => prov.isLoading);
    final mailEditorIsOpen =
        context.select<MailUIProvider, bool>((prov) => prov.mailEditorIsOpen);

    if (isLoading) return const SplashScreen();

    if (curAccount == null) return const AuthScreen();

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SideMenu(),
          const Mailbox(),
          Expanded(
              child: mailEditorIsOpen ? const MailEditor() : const MailView())
        ],
      ),
    );
  }
}
