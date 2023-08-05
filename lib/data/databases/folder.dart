import 'dart:convert';

import 'package:email_client/models/mail_folder.dart';
import 'package:sqflite/sqflite.dart';

import '../models.dart';

class FolderDatabase {
  final Database _db;

  FolderDatabase(this._db);

  Future<void> setMailFolders(
    List<MailFolderModel> folders,
    String currentAccountEmail,
  ) async {
    await deleteFolderByEmail(currentAccountEmail);

    for (int i = 0; i < folders.length; i++) {
      // Convert children MailFolderModel instances to JSON string
      String? childrenJson;
      if (folders[i].children != null) {
        List<Map<String, dynamic>> childrenList =
            folders[i].children!.map((child) => child.toMap()).toList();
        childrenJson = json.encode(childrenList);
      }

      // Insert the current folder and its children into the database
      await insertFolder(FolderDbModel(
        name: folders[i].name,
        accountEmail: currentAccountEmail,
        favorite: folders[i].favorite ? 1 : 0,
        unseenCount: folders[i].unseenCount,
        childrenJson: childrenJson,
      ));
    }
  }

  Future<void> insertFolder(FolderDbModel folder) async {
    await _db.insert(
      'folders',
      folder.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateFolder(FolderDbModel folder) async {
    await _db.update(
      'folders',
      folder.toMap(),
      where: 'name = ?',
      whereArgs: [folder.name],
    );
  }

  Future<void> deleteFolderByName(String name) async {
    await _db.delete(
      'folders',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> deleteFolderByEmail(String email) async {
    await _db.delete(
      'folders',
      where: 'account_email = ?',
      whereArgs: [email],
    );
  }

  Future<List<MailFolderModel>> getFoldersByAccount(
    String accountEmail,
  ) async {
    final List<Map<String, dynamic>> maps = await _db.query('folders',
        where: 'account_email = ?', whereArgs: [accountEmail]);

    return List.generate(maps.length, (i) {
      //print('from db ${maps[i]}');
      final jsonChildren = maps[i]['children_json'] as String?;

      List<dynamic>? children;
      if (jsonChildren != null) {
        children = jsonDecode(jsonChildren);
      }

      return MailFolderModel.fromMap({
        "name": maps[i]['name'],
        "callname": maps[i]['callname'],
        "specialUseAttrib": maps[i]['special_use_attrib'],
        "favorite": maps[i]['favorite'] == 1,
        "unseenCount": maps[i]['unseen_count'] ?? 0,
        "children": children
      });
    });
  }
}
