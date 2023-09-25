import 'package:flutter/material.dart';

import '../../../config/theme.dart';
import '../../../responsive.dart';
import 'header.dart';
import './listview.dart';

class Mailbox extends StatelessWidget {
  const Mailbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(right: borderSide)),
      width: Responsive.isAllMobile(context) ? double.infinity : 380,
      child: Column(
        children: [
          if (!Responsive.isMobile(context)) const MailBoxHeader(),
          const Expanded(child: MailBoxListView()),
        ],
      ),
    );
  }
}
