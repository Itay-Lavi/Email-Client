import 'package:email_client/models/mail_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/mail_folder.dart';

const _textColor = Colors.white;

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
    final account = context.watch<MailAccountModel>();

    return _selectedBorder(
        selected,
        ListTile(
          title: Text(account.host,
              overflow: TextOverflow.clip,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: _textColor)),
          subtitle: Text(
            account.email,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: _textColor),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
              (account.unseenCount ?? 0) > 0
                  ? account.unseenCount.toString()
                  : '',
              style: const TextStyle(color: _textColor)),
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
    final folder = context.watch<MailFolderModel>();

    return _selectedBorder(
        selected,
        ListTile(
          title: Text(folder.name,
              overflow: TextOverflow.clip,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: _textColor)),
          trailing: Text(
              (folder.unseenCount ?? 0) > 0
                  ? folder.unseenCount.toString()
                  : '',
              style: const TextStyle(color: _textColor)),
        ));
  }
}
