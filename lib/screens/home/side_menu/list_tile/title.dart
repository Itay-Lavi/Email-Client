import 'package:flutter/material.dart';

class TitleListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const TitleListTile({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.background;
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: Icon(
          icon,
          color: backgroundColor,
        ),
        title: Text(title, overflow: TextOverflow.clip),
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .apply(color: backgroundColor));
  }
}
