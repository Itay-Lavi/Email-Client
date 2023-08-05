import 'package:email_client/models/mail_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/mail_folder.dart';

Widget _selectedBorder(bool selected, Widget widget) {
  return Container(
      decoration: BoxDecoration(
          border: selected
              ? const Border(left: BorderSide(color: Colors.white, width: 4))
              : null),
      margin: EdgeInsets.only(left: selected ? 2 : 6),
      padding: const EdgeInsets.only(left: 26),
      child: widget);
}

class AccountListTile extends StatelessWidget {
  final bool selected;

  @override
  const AccountListTile({
    super.key,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.background;
    final account = context.watch<MailAccountModel>();

    return _selectedBorder(
        selected,
        ListTile(
          title: Text(account.host,
              overflow: TextOverflow.clip,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: backgroundColor)),
          subtitle: Text(
            account.email,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
              (account.unseenCount ?? 0) > 0
                  ? account.unseenCount.toString()
                  : '',
              style: TextStyle(color: backgroundColor)),
        ));
  }
}

class FolderListTile extends StatelessWidget {
  final bool selected;
  @override
  const FolderListTile({
    super.key,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.background;
    final folder = context.watch<MailFolderModel>();

    return _selectedBorder(
        selected,
        ListTile(
          title: Text(folder.name,
              overflow: TextOverflow.clip,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: backgroundColor)),
          trailing: Text(
              (folder.unseenCount ?? 0) > 0
                  ? folder.unseenCount.toString()
                  : '',
              style: TextStyle(color: backgroundColor)),
        ));
  }
}
