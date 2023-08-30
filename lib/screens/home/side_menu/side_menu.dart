import 'package:email_client/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/ui_provider.dart';

import './button_navbar.dart';
import './content.dart';

class SideMenu extends StatelessWidget {
  final bool isDrawer;
  const SideMenu({super.key, this.isDrawer = false});

  @override
  Widget build(BuildContext context) {
    final sideMenuIsOpen =
        context.select<UIProvider, bool>((prov) => prov.sideMenuIsOpen);
    final isDesktop = Responsive.isDesktop(context);

    double width;
    if (sideMenuIsOpen && isDesktop || isDrawer) {
      width = 260;
    } else {
      width = 42;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: width,
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SideMenuContent(isDrawer),
          ),
          const ButtomNavBar()
        ],
      ),
    );
  }
}
