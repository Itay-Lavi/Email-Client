import 'package:flutter/material.dart';

class MailHeaderBtnIcon extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;

  const MailHeaderBtnIcon({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 84, 84, 84),
          minimumSize: Size.zero,
        ),
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(title));
  }
}
