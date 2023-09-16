import 'package:provider/provider.dart';

import 'mail/accounts.dart';
import 'mail/list/provider.dart';
import 'mail/mail_ui.dart';
import 'mail/mail_folder.dart';
import 'ui_provider.dart';

final providers = [
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
    update: (context, mailAccountsProvider, __) =>
        MailFolderProvider(context, mailAccountsProvider),
    create: (context) => MailFolderProvider(context, null),
  ),
  ChangeNotifierProxyProvider2<MailAccountsProvider, MailFolderProvider,
      MailListProvider>(
    update: (context, mailAccountProvider, mailBoxProvider, previousProv) =>
        MailListProvider(
            context, mailBoxProvider, mailAccountProvider.currentAccount),
    create: (context) => MailListProvider(context, null, null),
  ),
];
