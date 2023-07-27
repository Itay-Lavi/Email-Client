import 'package:flutter/material.dart';

import '../../../config/global_var.dart';
import './header.dart';
import './listview.dart';

class Mailbox extends StatelessWidget {
  const Mailbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(right: borderSide)),
      width: 380,
      child: const Column(
        children: [
          MailBoxHeader(),
          Expanded(child: MailBoxListView()),
        ],
      ),
    );
  }
}
