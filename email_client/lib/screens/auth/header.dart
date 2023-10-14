import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/mail/accounts.dart';
import '../home/home_screen.dart';

class AuthHeader extends StatelessWidget {
  final bool showImage;
  const AuthHeader(this.showImage, {super.key});

  @override
  Widget build(BuildContext context) {
    final mailAccountProv = context.watch<MailAccountsProvider>();
    final canPop =
        (Navigator.canPop(context) && mailAccountProv.currentAccount != null);

    void goBack() {
      if (canPop) {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    }

    return Stack(
      children: [
        if (showImage)
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo.png',
              width: 100,
              height: 100,
              alignment: Alignment.center,
            ),
          ),
        if (mailAccountProv.currentAccount != null)
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: goBack,
              icon: const Icon(Icons.arrow_back),
            ),
          ),
      ],
    );
  }
}
