import 'package:email_client/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/mail.dart';
import '../../../providers/mail/list/provider.dart';
import '../../../screens/home/mailbox/item/group_item_header.dart';
import '../../../screens/home/mailbox/item/item.dart';

import '../../../util/mail_logic.dart';
import './bottom_modal.dart';

class MailBoxListView extends StatefulWidget {
  final List<MailModel> mails;
  const MailBoxListView(this.mails, {super.key});

  @override
  State<MailBoxListView> createState() => _MailBoxListViewState();
}

double _scrollPosition = 0.0;

class _MailBoxListViewState extends State<MailBoxListView> {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: _scrollPosition);
  bool showFilteredMails = false;
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
    _scrollPosition = scrollController.position.pixels;
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !newEmailsIsLoading) {
      setState(() {
        newEmailsIsLoading = true;
      });

      try {
        await _loadMoreEmails();
      } catch (_) {}
      setState(() {
        newEmailsIsLoading = false;
      });
    }
  }

  Future<void> _loadMoreEmails() async {
    final mailListProv = context.read<MailListProvider>();
    final mails = mailListProv.mails;
    if (mails != null) {
      await debounceOperation(
          mailListProv.getEmails('${mails.length}:${mails.length + 20}'));
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<MailModel>> groupedEmails =
        groupAndSortEmails(widget.mails);

    return Column(
      children: [
        Expanded(
            child: RefreshIndicator(
          onRefresh: () =>
              context.read<MailListProvider>().getEmails('0:$defaultMaxFetch'),
          child: GroupListView(
            controller: scrollController,
            sectionsCount: groupedEmails.keys.toList().length,
            countOfItemInSection: (int section) {
              return groupedEmails.values.toList()[section].length;
            },
            itemBuilder: (BuildContext ctx, IndexPath i) {
              return ChangeNotifierProvider<MailModel>.value(
                  value: groupedEmails.values.toList()[i.section][i.index],
                  child: const MailBoxItem());
            },
            groupHeaderBuilder: (BuildContext _, int section) {
              DateFormat format = DateFormat('dd/MM/yyyy');
              final date = format.parse(groupedEmails.keys.toList()[section]);
              return GroupItemHeader(date);
            },
          ),
        )),
        BottomListviewModal(newEmailsIsLoading)
      ],
    );
  }
}
