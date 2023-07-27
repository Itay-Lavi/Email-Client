import 'package:email_client/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './providers/mail/accounts.dart';
import './providers/mail/mailbox.dart';
import './providers/mail/mail_list.dart';
import './providers/ui_provider.dart';
import './screens/home/home_screen.dart';
import 'providers/mail/mail_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Email Client',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider<MailUIProvider>(
          create: (_) => MailUIProvider(),
        ),
        ChangeNotifierProvider<UIProvider>(
          create: (_) => UIProvider(),
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
          update: (context, mailAccountProvider, mailBoxProvider, __) =>
              MailListProvider(
                  context, mailBoxProvider, mailAccountProvider.currentAccount),
          create: (context) => MailListProvider(context, null, null),
        ),
      ], child: const HomeScreen()),
      routes: {
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        AuthScreen.routeName: (ctx) => const AuthScreen()
      },
    );
  }
}
