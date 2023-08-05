import 'package:flutter/material.dart';

class ButtomNavBar extends StatelessWidget {
  const ButtomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.background;

    final btns = [
      IconButton(
          onPressed: () {},
          icon: const Icon(Icons.email_outlined),
          color: backgroundColor),
      IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings_outlined),
          color: backgroundColor)
    ];

    return Container(
        color: const Color.fromARGB(255, 16, 81, 133),
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
