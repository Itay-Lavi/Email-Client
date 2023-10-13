import 'package:email_client/providers/mail/send_email.dart';
import 'package:provider/provider.dart';

import 'mail/accounts.dart';
import 'mail/list/filtered.dart';
import 'mail/list/provider.dart';
import 'mail/mail_ui.dart';
import 'mail/mail_folder.dart';
import './settings_provider.dart';
import './ui_provider.dart';

final providers = [
  ChangeNotifierProvider<SettingsProvider>(
    create: (_) => SettingsProvider(),
  ),
  ChangeNotifierProvider<MailUIProvider>(
    create: (_) => MailUIProvider(),
  ),
  ChangeNotifierProvider<UIProvider>(
    create: (ctx) => UIProvider(ctx),
  ),
  ChangeNotifierProvider<MailAccountsProvider>(
    create: (context) => MailAccountsProvider(context),
  ),
  ChangeNotifierProxyProvider2<MailAccountsProvider, MailUIProvider,
          SendEmailProvider>(
      update: (context, accountProvider, mailUiProvider, previous) =>
          SendEmailProvider(accountProvider.currentAccount, mailUiProvider),
      create: (context) => SendEmailProvider(null, null)),
  ChangeNotifierProxyProvider<MailAccountsProvider, MailFolderProvider>(
    update: (context, accountProvider, previousProv) {
      if (accountProvider.currentAccount != previousProv?.currentAccount) {
        return MailFolderProvider(accountProvider.currentAccount);
      } else {
        return previousProv!;
      }
    },
    create: (context) => MailFolderProvider(null),
  ),
  ChangeNotifierProxyProvider3<MailAccountsProvider, MailFolderProvider,
      MailUIProvider, FilteredMailListProvider>(
    update: (context, accountProvider, mailBoxProvider, mailUiProvider,
            previousProv) =>
        FilteredMailListProvider(
            accountProvider.currentAccount, mailBoxProvider),
    create: (context) => FilteredMailListProvider(null, null),
  ),
  ChangeNotifierProxyProvider2<MailAccountsProvider, MailFolderProvider,
      MailListProvider>(
    update: (context, mailAccountProvider, mailBoxProvider, previousProv) {
      if (mailBoxProvider.currentFolder != previousProv?.currentFolder) {
        return MailListProvider(
            context, mailBoxProvider, mailAccountProvider.currentAccount);
      } else {
        return previousProv!;
      }
    },
    create: (context) => MailListProvider(context, null, null),
  ),
];
