import 'package:email_client/providers/mail/list/provider.dart';
import 'package:email_client/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../responsive.dart';

class ButtomNavBar extends StatelessWidget {
  const ButtomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void navigateToSettings() async {
      if (Responsive.isAllMobile(context)) {
        Navigator.of(context).pushNamed(SettingsScreen.routeName);
      } else {
        final selectedEmail = context.read<MailListProvider>().selectedMail;
        context.read<MailListProvider>().selectCurrentEmail(null);
        await showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text('Settings'),
                  content: Card(
                    child: SettingsList(),
                  ),
                ));
        // ignore: use_build_context_synchronously
        context.read<MailListProvider>().selectCurrentEmail(selectedEmail);
      }
    }

    const textColor = Colors.white;
    final btns = [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.email),
        color: textColor,
      ),
      IconButton(
        onPressed: navigateToSettings,
        icon: const Icon(Icons.settings_outlined),
        color: textColor,
      )
    ];

    return Container(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
        alignment: Alignment.centerLeft,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final sideMenuIsOpen = constraints.maxWidth > 80;

            return sideMenuIsOpen
                ? SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: btns,
                    ),
                  )
                : Column(
                    children: btns,
                  );
          },
        ));
  }
}
