import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/ui_provider.dart';

import './button_navbar.dart';
import './content.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final sideMenuIsOpen =
        context.select<UIProvider, bool>((prov) => prov.sideMenuIsOpen);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: sideMenuIsOpen ? 260 : 42,
      color: Theme.of(context).colorScheme.primary,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SideMenuContent(),
          ),
          ButtomNavBar()
        ],
      ),
    );
  }
}
