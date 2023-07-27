import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/mail_folder.dart';
import '../../../providers/mail/mailbox.dart';

import './item.dart';
import 'inkwell_list_tile.dart';

class RecursiveFolderList extends StatelessWidget {
  final int level;

  const RecursiveFolderList({Key? key, this.level = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mailBoxProv = context.read<MailBoxProvider>();
    final currentFolderName = context.select<MailBoxProvider, String?>(
        (prov) => prov.currentFolder?.name ?? '');
    final folder = context.watch<MailFolderModel>();

    Widget buildFolderList(String parentName, List<MailFolderModel> folders,
        {int level = 0}) {
      return Column(
        children: folders.map((folder) {
          folder.callName = '$parentName/${folder.name}';
          return ChangeNotifierProvider.value(
              value: folder,
              child: Padding(
                padding: EdgeInsets.only(
                    left: level * 16), // Adjust the padding value as needed
                child: InkWellListTile(
                  onTap: () => mailBoxProv.setCurrentFolder(folder),
                  listTile: FolderListTile(
                    selected: folder.name == currentFolderName,
                  ),
                ),
              ));
        }).toList(),
      );
    }

    Widget buildRecursiveFolderList({int level = 0}) {
      return Column(
        children: [
          if (folder.children == null)
            InkWellListTile(
                onTap: () => mailBoxProv.setCurrentFolder(folder),
                listTile: ChangeNotifierProvider.value(
                  value: folder,
                  child: FolderListTile(
                    selected: folder.name == currentFolderName,
                  ),
                )),
          if (folder.children != null)
            buildFolderList(folder.name, folder.children!, level: level + 1),
        ],
      );
    }

    return buildRecursiveFolderList(level: level);
  }
}
