import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GroupItemHeader extends StatelessWidget {
  final DateTime date;
  const GroupItemHeader(this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 239, 239, 239),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        '${DateFormat.E().format(date)}, ${DateFormat.yMMMd().format(date)}',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
