import 'package:email_client/providers/mail/mail_list.dart';
import 'package:email_client/providers/mail/mail_ui.dart';
import 'package:email_client/providers/ui_provider.dart';
import 'package:email_client/responsive.dart';
import 'package:email_client/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/mail_account.dart';
import '../../providers/mail/accounts.dart';
import '../auth/auth_screen.dart';
import 'side_menu/side_menu.dart';
import './mailbox/mailbox.dart';
import './mail/view/mail_view.dart';
import './mail/editor/mail_editor.dart';

//import 'package:flutter/foundation.dart' show kIsWeb;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '';

  @override
  Widget build(BuildContext context) {
    final mailEditorIsOpen =
        context.select<MailUIProvider, bool>((prov) => prov.mailEditorIsOpen);
    final selectedMail = context
        .select<MailListProvider, bool>((prov) => prov.selectedMail != null);
    final isMobile = Responsive.isMobile(context);

    final curAccount = context.select<MailAccountsProvider, MailAccountModel?>(
        (prov) => prov.currentAccount);
    final isLoading =
        context.select<UIProvider, bool>((prov) => prov.isLoading);

    Future.delayed(const Duration(seconds: 1), () {
      if (curAccount == null && !isLoading) {
        return Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
      }
    });

    return SafeArea(
      child: Scaffold(
        key: context.read<UIProvider>().homeScaffoldKey,
        drawer: const SideMenu(isDrawer: true),
        body: isLoading || curAccount == null
            ? const SplashScreen()
            : Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SideMenu(),
                      if (isMobile && !selectedMail)
                        const Expanded(child: Mailbox()),
                      if (!isMobile) const Mailbox(),
                      if (isMobile && selectedMail || !isMobile)
                        Expanded(
                            child: mailEditorIsOpen
                                ? const MailEditor()
                                : const MailView())
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
