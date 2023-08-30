import 'package:flutter/material.dart';
//import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './providers/mail/accounts.dart';
import 'providers/mail/list/provider.dart';
import './providers/mail/mailbox.dart';
import './providers/ui_provider.dart';
import './screens/auth/auth_screen.dart';
import './screens/home/home_screen.dart';
import 'providers/mail/mail_ui.dart';

void main() {
  //setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MailUIProvider>(
            create: (_) => MailUIProvider(),
          ),
          ChangeNotifierProvider<UIProvider>(
            create: (ctx) => UIProvider(ctx),
          ),
          ChangeNotifierProvider<MailAccountsProvider>(
            create: (context) => MailAccountsProvider(context),
          ),
          ChangeNotifierProxyProvider<MailAccountsProvider, MailBoxProvider>(
            update: (context, mailAccountsProvider, __) =>
                MailBoxProvider(context, mailAccountsProvider),
            create: (context) => MailBoxProvider(context, null),
          ),
          ChangeNotifierProxyProvider2<MailAccountsProvider, MailBoxProvider,
              MailListProvider>(
            update: (context, mailAccountProvider, mailBoxProvider,
                    previousProv) =>
                MailListProvider(context, mailBoxProvider,
                    mailAccountProvider.currentAccount),
            create: (context) => MailListProvider(context, null, null),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Email Client',
            theme: ThemeData(
              textTheme:
                  GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              appBarTheme: const AppBarTheme(foregroundColor: Colors.white),
              useMaterial3: true,
            ),
            initialRoute: HomeScreen.routeName,
            routes: {
              HomeScreen.routeName: (context) => const HomeScreen(),
              AuthScreen.routeName: (context) => const AuthScreen()
            },
            onUnknownRoute: (RouteSettings settings) {
              return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (BuildContext context) => const HomeScreen());
            }));
  }
}
