import 'package:email_client/screens/settings_screen.dart';
import 'package:flutter/material.dart';

import '../../../responsive.dart';

class ButtomNavBar extends StatelessWidget {
  const ButtomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void navigateToSettings() {
      if (Responsive.isAllMobile(context)) {
        Navigator.of(context).pushNamed(SettingsScreen.routeName);
      } else {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text('Settings'),
                  content: Card(
                    child: SettingsList(),
                  ),
                ));
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
