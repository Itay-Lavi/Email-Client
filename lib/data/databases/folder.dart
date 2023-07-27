import 'package:sqflite/sqflite.dart';

import '../models.dart';

class FolderDatabase {
  final Database _db;

  FolderDatabase(this._db);

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

  Future<void> deleteFolder(String name) async {
    await _db.delete(
      'folders',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<List<FolderDbModel>> getFoldersByAccount(
    String accountEmail,
  ) async {
    final List<Map<String, dynamic>> maps = await _db.query('folders',
        where: 'account_email = ?', whereArgs: [accountEmail]);

    return List.generate(maps.length, (i) {
      return FolderDbModel(
        name: maps[i]['name'],
        accountEmail: maps[i]['account_email'],
        callname: maps[i]['callname'],
        favorite: maps[i]['favorite'] == 1,
      );
    });
  }
}
