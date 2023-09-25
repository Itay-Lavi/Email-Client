import 'package:provider/provider.dart';

import 'mail/accounts.dart';
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
  ChangeNotifierProxyProvider<MailAccountsProvider, MailFolderProvider>(
    update: (context, mailAccountsProvider, previousProv) {
      if (mailAccountsProvider.currentAccount != previousProv?.currentAccount) {
        return MailFolderProvider(context, mailAccountsProvider.currentAccount);
      } else {
        return previousProv!;
      }
    },
    create: (context) => MailFolderProvider(context, null),
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
