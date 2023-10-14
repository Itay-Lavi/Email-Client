import 'dart:convert';

import 'package:email_client/data/helper.dart';
import 'package:email_client/models/mail.dart';
import 'package:sqflite/sqflite.dart';

import '../models.dart';

class MailDatabase {
  final Database _db;

  MailDatabase(this._db);

  static MailDbModel toMailDbModel(
      MailModel mail, String accountEmail, int folderId) {
    return MailDbModel(
        id: mail.id!,
        accountEmail: accountEmail,
        folderId: folderId,
        from: jsonEncode(mail.from),
        to: jsonEncode(mail.to),
        subject: mail.subject,
        html: mail.html,
        flags: jsonEncode(mail.flags),
        timestamp: mail.timestamp.toIso8601String());
  }

  Future<void> setMails(
      List<MailModel> mails, String accountEmail, int folderId) async {
    await deleteMailsByFolder(folderId);

    for (final mail in mails) {
      await insertMail(toMailDbModel(mail, accountEmail, folderId));
    }
  }

  Future<void> insertMail(MailDbModel mail) async {
    await _db.insert(
      emailsTableName,
      mail.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    await _db.insert(emailsFoldersTableName,
        {'folder_id': mail.folderId, 'email_id': mail.id},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateMail(MailDbModel mail) async {
    await _db.update(
      emailsTableName,
      mail.toMap(),
      where: 'id = ?',
      whereArgs: [mail.id],
    );
  }

  Future<void> deleteMail(String id) async {
    await _db.delete(
      emailsTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteMailsByFolder(int folderId) async {
    await _db.delete(
      emailsTableName,
      where: 'folder_id = ?',
      whereArgs: [folderId],
    );
  }

  Future<List<MailModel>> getMailsByAccountAndFolder(
      String accountEmail, int? folderId) async {
    if (folderId == null) return [];

    final List<Map<String, dynamic>> mailsMaps = await _db.rawQuery('''
SELECT E.* FROM $emailsTableName E
INNER JOIN $emailsFoldersTableName EF ON E.id = EF.email_id
WHERE E.account_email = ? AND EF.folder_id = ?
''', [accountEmail, folderId]);

    final List<MailDbModel> dbMails =
        mailsMaps.map((map) => MailDbModel.fromMap(map)).toList();

    return List.generate(dbMails.length, (i) {
      return MailModel.fromMap({
        "id": dbMails[i].id,
        "from": jsonDecode(dbMails[i].from),
        "to": dbMails[i].to != null ? jsonDecode(dbMails[i].to!) : null,
        "subject": dbMails[i].subject,
        "timestamp": dbMails[i].timestamp,
        "flags": dbMails[i].flags != null ? jsonDecode(dbMails[i].flags!) : [],
        "html": dbMails[i].html,
      });
    });
  }
}
