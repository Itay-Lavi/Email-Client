import 'package:flutter/material.dart';

import '../../../config/global_var.dart';
import '../../../responsive.dart';
import './header.dart';
import './listview.dart';

class Mailbox extends StatelessWidget {
  const Mailbox({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      decoration: const BoxDecoration(border: Border(right: borderSide)),
      width: isMobile ? double.infinity : 380,
      child: const Column(
        children: [
          MailBoxHeader(),
          Expanded(child: MailBoxListView()),
        ],
      ),
    );
  }
}
