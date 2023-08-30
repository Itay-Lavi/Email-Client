import 'package:email_client/data/helper.dart';
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
    await deleteFoldersByEmail(currentAccountEmail);

    Future<void> insertFoldersRecursively(List<MailFolderModel> folders,
        [int? parentId]) async {
      for (final folder in folders) {
        final folderId = await insertFolder(FolderDbModel(
            id: folder.id,
            name: folder.name,
            accountEmail: currentAccountEmail,
            favorite: folder.favorite ? 1 : 0,
            specialUseAttrib: folder.specialUseAttrib,
            unseenCount: folder.unseenCount,
            parentId: parentId));
        folder.id = folderId;

        if (folder.children == null || folder.children!.isEmpty) continue;

        await insertFoldersRecursively(folder.children!, folderId);
      }
    }

    insertFoldersRecursively(folders);
  }

  Future<int> insertFolder(FolderDbModel folder) async {
    return await _db.insert(
      folderTableName,
      folder.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateFolder(FolderDbModel folder) async {
    await _db.update(
      folderTableName,
      folder.toMap(),
      where: 'name = ?',
      whereArgs: [folder.name],
    );
  }

  Future<void> deleteFolderByName(String name) async {
    await _db.delete(
      folderTableName,
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> deleteFoldersByEmail(String email) async {
    await _db.delete(
      folderTableName,
      where: 'account_email = ?',
      whereArgs: [email],
    );
  }

  Future<List<MailFolderModel>> getFoldersByAccount(String accountEmail) async {
    final List<Map<String, dynamic>> fethcedFolders = await _db.query(
      folderTableName,
      where: 'account_email = ?',
      whereArgs: [accountEmail],
    );

    final List<FolderDbModel> dbFolders =
        fethcedFolders.map((map) => FolderDbModel.fromMap(map)).toList();

    Map<int, List<FolderDbModel>> folderMap = {};
    List<FolderDbModel> rootFolders = [];

    for (final dbFolder in dbFolders) {
      final parentId = dbFolder.parentId;

      if (parentId == null) {
        rootFolders.add(dbFolder);
      } else {
        folderMap[parentId] ??= [];
        folderMap[parentId]!.add(dbFolder);
      }
    }

    List<MailFolderModel> mailFolders = [];

    for (final rootFolder in rootFolders) {
      final finalFolderMap = _convertToMailFolder(rootFolder, folderMap);
      mailFolders.add(MailFolderModel.fromMap(finalFolderMap));
    }

    return mailFolders;
  }

  Map<String, dynamic> _convertToMailFolder(
      FolderDbModel dbFolder, Map<int, List<FolderDbModel>> folderMap) {
    final children = folderMap[dbFolder.id] ?? [];

    return {
      'id': dbFolder.id,
      "name": dbFolder.name,
      "specialUseAttrib": dbFolder.specialUseAttrib,
      "favorite": dbFolder.favorite,
      "unseenCount": dbFolder.unseenCount,
      "children": children
          .map((child) => _convertToMailFolder(child, folderMap))
          .toList(),
    };
  }
}
