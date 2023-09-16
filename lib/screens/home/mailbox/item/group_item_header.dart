import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../config/global_var.dart';
import '../../../../providers/ui_provider.dart';

class GroupItemHeader extends StatelessWidget {
  final DateTime date;
  const GroupItemHeader(this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    bool darkMode = context.select<UIProvider, bool>((prov) => prov.darkMode);
    return Container(
      decoration: BoxDecoration(
        color: darkMode
            ? Theme.of(context).colorScheme.secondary
            : const Color.fromARGB(255, 235, 235, 235),
        border: const Border(top: borderSide),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        '${DateFormat.E().format(date)}, ${DateFormat.yMMMd().format(date)}',
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
