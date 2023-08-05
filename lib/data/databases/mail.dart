import 'package:email_client/models/mail.dart';
import 'package:sqflite/sqflite.dart';

import '../models.dart';

class MailDatabase {
  final Database _db;

  MailDatabase(this._db);

  Future<void> insertMail(MailDbModel mail) async {
    await _db.insert(
      'mails',
      mail.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateMail(MailDbModel mail) async {
    await _db.update(
      'mails',
      mail.toMap(),
      where: 'id = ?',
      whereArgs: [mail.id],
    );
  }

  Future<void> deleteMail(int id) async {
    await _db.delete(
      'mails',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<MailModel>> getMailsByAccountAndFolder(
      String accountEmail, String folderName) async {
    final List<Map<String, dynamic>> maps = await _db.query('mails',
        where: 'account_email = ? AND folder_name = ?',
        whereArgs: [accountEmail, folderName]);

    return List.generate(maps.length, (i) {
      return MailModel.fromMap({
        "id": maps[i]['id'],
        "from": maps[i]['from'],
        "to": maps[i]['to'],
        "subject": maps[i]['subject'],
        "timestamp": maps[i]['timestamp'],
        "flags": maps[i]['flags'],
        "html": maps[i]['html'],
      });
    });
  }
}
