import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/app_bar.dart';

import '../../models/mail_account.dart';
import '../../providers/mail/accounts.dart';
import '../../providers/mail/list/provider.dart';
import '../../providers/mail/mail_ui.dart';
import '../../providers/ui_provider.dart';
import '../../responsive.dart';
import '../../screens/splash_screen.dart';
import '../auth/auth_screen.dart';
import './mail/view/mail_view.dart';
import './mailbox/mailbox.dart';
import './side_menu/side_menu.dart';
import 'widgets/floating_action_btn.dart';
import 'mail/editor/mail_editor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '';

  @override
  Widget build(BuildContext context) {
    final mailEditorIsOpen =
        context.select<MailUIProvider, bool>((prov) => prov.mailEditorIsOpen);
    final mailIsSelected = context
        .select<MailListProvider, bool>((prov) => prov.selectedMail != null);

    final curAccount = context.select<MailAccountsProvider, MailAccountModel?>(
        (prov) => prov.currentAccount);
    final initialized =
        context.select<UIProvider, bool>((prov) => prov.initialized);

    final isAllMobile = Responsive.isAllMobile(context);
    final isMobile = Responsive.isMobile(context);

    Future.delayed(const Duration(seconds: 1), () {
      if (curAccount == null && initialized) {
        return Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
      }
    });

    return SafeArea(
      child: !initialized || curAccount == null
          ? const SplashScreen()
          : WillPopScope(
              onWillPop: () async {
                if (isAllMobile && mailIsSelected) {
                  context.read<MailListProvider>().selectCurrentEmail(null);
                  return false;
                }
                return true;
              },
              child: Scaffold(
                key: context.read<UIProvider>().homeScaffoldKey,
                appBar: isMobile ? const HomeAppBar() : null,
                drawer: const SideMenu(isDrawer: true),
                body: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isMobile) const SideMenu(),
                    if (isAllMobile && !mailIsSelected && !mailEditorIsOpen)
                      const Expanded(child: Mailbox()),
                    if (!isAllMobile) const Mailbox(),
                    if (!isAllMobile ||
                        (!mailEditorIsOpen && mailIsSelected) ||
                        mailEditorIsOpen)
                      Expanded(
                          child: mailEditorIsOpen
                              ? const MailEditor()
                              : const MailView())
                  ],
                ),
                floatingActionButton:
                    isAllMobile && !mailIsSelected && !mailEditorIsOpen
                        ? const HomeFloatingBtn()
                        : null,
              ),
            ),
    );
  }
}
