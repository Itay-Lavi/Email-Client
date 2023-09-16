import 'package:flutter/material.dart';

class TitleListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const TitleListTile({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    const titleColor = Colors.white;
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: Icon(
          icon,
          color: titleColor,
        ),
        title: Text(title, overflow: TextOverflow.clip),
        titleTextStyle:
            Theme.of(context).textTheme.titleLarge!.apply(color: titleColor));
  }
}
