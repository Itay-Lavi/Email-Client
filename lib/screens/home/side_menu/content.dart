import 'package:email_client/models/send_mail.dart';
import 'package:email_client/providers/mail/mail_list.dart';
import 'package:email_client/providers/mail/mail_ui.dart';
import 'package:email_client/responsive.dart';
import 'package:email_client/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/mail_folder.dart';
import '../../../providers/mail/accounts.dart';
import '../../../providers/mail/mailbox.dart';

import '../../../providers/ui_provider.dart';
import './list_tile/inkwell_list_tile.dart';
import './list_tile/item.dart';
import './list_tile/recursive_folder_list.dart';
import './list_tile/title.dart';

class SideMenuContent extends StatelessWidget {
  const SideMenuContent({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.background;

    final accountProv = context.watch<MailAccountsProvider>();
    final folders = context.select<MailBoxProvider, List<MailFolderModel>>(
        (prov) => prov.folders ?? []);

    void onNewMailBtn() {
      context.read<MailUIProvider>().controlMailEditor(true);
      context
          .read<MailUIProvider>()
          .setMailData(MailDataModel(from: '', to: [], subject: '', html: ''));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<MailListProvider>(builder: (context, mailListProv, _) {
          final mailIsSelected = mailListProv.selectedMail != null;
          return (Responsive.isMobile(context) && mailIsSelected)
              ? IconButton(
                  color: backgroundColor,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => mailListProv.selectCurrentEmail(null))
              : const SizedBox();
        }),
        IconButton(
            color: backgroundColor,
            icon: const Icon(Icons.menu_outlined),
            onPressed: context.read<UIProvider>().controlSideMenu),
        Expanded(child: LayoutBuilder(builder: (context, constraints) {
          final sideMenuIsOpen = constraints.maxWidth > 250;

          return SingleChildScrollView(
            child: Column(
              children: [
                InkWellListTile(
                    onTap: onNewMailBtn,
                    padding: 8,
                    listTile: TitleListTile(
                      icon: Icons.add,
                      title: sideMenuIsOpen ? 'New mail' : '',
                    )),
                InkWellListTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(AuthScreen.routeName, arguments: ''),
                    padding: 8,
                    listTile: TitleListTile(
                      icon: Icons.account_circle_outlined,
                      title: sideMenuIsOpen ? 'Accounts' : '',
                    )),
                if (sideMenuIsOpen)
                  ...accountProv.mailAccounts.map(
                    (account) => InkWellListTile(
                        onTap: () => accountProv.setCurrentAccount(account),
                        listTile: ChangeNotifierProvider.value(
                            value: account,
                            child: AccountListTile(
                              selected: account.email ==
                                  accountProv.currentAccount?.email,
                            ))),
                  ),
                InkWellListTile(
                    onTap: () {},
                    padding: 8,
                    listTile: TitleListTile(
                      icon: Icons.folder_open_outlined,
                      title: sideMenuIsOpen ? 'Folders' : '',
                    )),
                if (sideMenuIsOpen && folders.isNotEmpty)
                  ...folders.map(
                    (folder) => ChangeNotifierProvider.value(
                        value: folder, child: const RecursiveFolderList()),
                  ),
                if (folders.isEmpty && Responsive.isDesktop(context))
                  CircularProgressIndicator(color: backgroundColor)
              ],
            ),
          );
        }))
      ],
    );
  }
}
