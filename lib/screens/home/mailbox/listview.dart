import 'package:email_client/models/mail.dart';
import 'package:email_client/providers/mail/mail_list.dart';
import 'package:email_client/screens/home/mailbox/item/group_item_header.dart';
import 'package:email_client/screens/home/mailbox/item/item.dart';
import 'package:email_client/util/async.dart';
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../widgets/snackbar.dart';

class MailBoxListView extends StatefulWidget {
  const MailBoxListView({super.key});

  @override
  State<MailBoxListView> createState() => _MailBoxListViewState();
}

class _MailBoxListViewState extends State<MailBoxListView> {
  final ScrollController scrollController = ScrollController();
  List<MailModel>? mails = [];
  bool newEmailsIsLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !newEmailsIsLoading) {
      newEmailsIsLoading = true;
      showButtonSnackbar(context);
      try {
        await performAsyncOperation(context
            .read<MailListProvider>()
            .getEmails('${mails!.length}:${mails!.length + 30}'));
      } catch (_) {
      } finally {
        newEmailsIsLoading = false;
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mails = context.watch<MailListProvider>().mails;
    Map<String, List<MailModel>> groupedEmails = groupEmails();

    if (mails == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GroupListView(
        controller: scrollController,
        sectionsCount: groupedEmails.keys.toList().length,
        countOfItemInSection: (int section) {
          return groupedEmails.values.toList()[section].length;
        },
        itemBuilder: (BuildContext ctx, IndexPath i) =>
            MailBoxItem(groupedEmails.values.toList()[i.section][i.index]),
        groupHeaderBuilder: (BuildContext _, int section) {
          DateFormat format = DateFormat('dd/MM/yyyy');
          final date = format.parse(groupedEmails.keys.toList()[section]);
          return GroupItemHeader(date);
        },
        sectionSeparatorBuilder: (_, __) => const Divider(height: 1));
  }

  Map<String, List<MailModel>> groupEmails() {
    Map<String, List<MailModel>> groupedEmails = {};
    if (mails == null || mails!.isEmpty) {
      return groupedEmails;
    }

    for (MailModel mail in mails!) {
      String day = DateFormat('dd/MM/yyyy').format(mail.timestamp);
      if (groupedEmails.containsKey(day)) {
        groupedEmails[day]!.add(mail);
      } else {
        groupedEmails[day] = [mail];
      }
    }
    return groupedEmails;
  }
}
