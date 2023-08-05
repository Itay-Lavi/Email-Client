import 'package:email_client/models/mail_account.dart';
import 'package:sqflite/sqflite.dart';

import '../models.dart';

class AccountDatabase {
  final Database _db;

  AccountDatabase(this._db);

  Future<void> insertAccount(AccountDbModel account) async {
    await _db.insert(
      'accounts',
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateAccount(AccountDbModel account) async {
    await _db.update(
      'accounts',
      account.toMap(),
      where: 'email = ?',
      whereArgs: [account.email],
    );
  }

  Future<void> deleteAccount(String email) async {
    await _db.delete(
      'accounts',
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<List<MailAccountModel>> getAllAccounts() async {
    final List<Map<String, dynamic>> maps = await _db.query('accounts');

    return List.generate(maps.length, (i) {
      return MailAccountModel(
        email: maps[i]['email'],
        jwt: maps[i]['jwt'],
        host: maps[i]['host'],
        unseenCount: maps[i]['unseen_count'],
      );
    });
  }
}
