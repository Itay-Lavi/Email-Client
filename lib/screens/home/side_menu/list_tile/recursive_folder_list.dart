import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/mail_folder.dart';
import '../../../../providers/mail/mailbox.dart';

import './item.dart';
import 'inkwell_list_tile.dart';

class RecursiveFolderList extends StatelessWidget {
  final int level;

  const RecursiveFolderList({Key? key, this.level = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mailBoxProv = context.read<MailBoxProvider>();
    final currentFolderName = context.select<MailBoxProvider, String?>(
      (prov) => prov.currentFolder?.name ?? '',
    );
    final folder = context.watch<MailFolderModel>();

    Widget buildFolderList(String parentName, List<MailFolderModel> folders) {
      return Column(
        children: folders.map((folder) {
          return ChangeNotifierProvider.value(
            value: folder,
            child: Padding(
              padding: EdgeInsets.only(left: (level + 1) * 16),
              child: InkWellListTile(
                onTap: () => mailBoxProv.setCurrentFolder(folder),
                listTile: FolderListTile(
                  selected: folder.name == currentFolderName,
                ),
              ),
            ),
          );
        }).toList(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (folder.name != '[Gmail]')
          InkWellListTile(
            onTap: () => mailBoxProv.setCurrentFolder(folder),
            listTile: ChangeNotifierProvider.value(
              value: folder,
              child: FolderListTile(
                selected: folder.name == currentFolderName,
              ),
            ),
          ),
        if (folder.children != null)
          buildFolderList(folder.name, folder.children!),
      ],
    );
  }
}
