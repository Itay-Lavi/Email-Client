import 'package:flutter/material.dart';

import '../../../config/global_var.dart';
import '../../../responsive.dart';
import 'header.dart';
import './listview.dart';

class Mailbox extends StatelessWidget {
  const Mailbox({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isAllMobile = Responsive.isAllMobile(context);

    return Container(
      decoration: const BoxDecoration(border: Border(right: borderSide)),
      width: isAllMobile ? double.infinity : 380,
      child: Column(
        children: [
          if (!isMobile) const MailBoxHeader(),
          const Expanded(child: MailBoxListView()),
        ],
      ),
    );
  }
}
