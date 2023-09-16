import 'package:email_client/responsive.dart';
import 'package:flutter/material.dart';

class MailHeaderBtnIcon extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String? title;

  const MailHeaderBtnIcon({
    super.key,
    required this.onTap,
    required this.icon,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return title != null
        ? TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onBackground,
              minimumSize: Size.zero,
            ),
            onPressed: onTap,
            icon: Icon(icon),
            label: Text(title!))
        : IconButton(
            onPressed: onTap,
            icon: Icon(icon,
                color: Responsive.isMobile(context)
                    ? null
                    : Theme.of(context).colorScheme.onBackground));
  }
}
