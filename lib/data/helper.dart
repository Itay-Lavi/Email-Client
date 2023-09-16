import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

const accountTableName = 'accounts';
const folderTableName = 'folders';
const emailsTableName = 'emails';
const emailsFoldersTableName = 'Email_Folders';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  DatabaseHelper.internal();

  Future<Database> _initDatabase() async {
    String mobilePath = '';
    if (kIsWeb) {
      // Set the database factory to use FFI implementation for web
      databaseFactory = databaseFactoryFfiWeb;
    } else {
      final appDir = await getApplicationDocumentsDirectory();
      mobilePath = join(appDir.path, 'mail_database.db');
    }

    _database = await databaseFactory.openDatabase(
        kIsWeb ? 'mail_database.db' : mobilePath,
        options: OpenDatabaseOptions(
          onCreate: (db, version) async {
            await _createTables(db);
          },
          version: 1,
        ));

    return _database!;
  }

  Future<void> _createTables(Database db) async {
    await db.execute(
      'CREATE TABLE $accountTableName(email VARCHAR(255) PRIMARY KEY, jwt TEXT, host VARCHAR(100), unseen_count INTEGER)',
    );

    await db.execute(
      '''CREATE TABLE $folderTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(255),
       account_email VARCHAR(255), favorite INTEGER, unseen_count INTEGER,
        special_use_attrib VARCHAR(255), parent_id INTEGER)''',
    );

    await db.execute(
      '''CREATE TABLE $emailsTableName(id VARCHAR(255) PRIMARY KEY, account_email VARCHAR(255), folder_id INTEGER,
       from_map TEXT, to_map TEXT, subject TEXT, timestamp VARCHAR(255), flags TEXT, html BLOB)''',
    );

    await db.execute('''
      CREATE TABLE $emailsFoldersTableName(
      folder_id INTEGER, email_id VARCHAR(255),
        FOREIGN KEY (folder_id) REFERENCES $folderTableName(id) ON DELETE CASCADE,
        FOREIGN KEY (email_id) REFERENCES $emailsTableName(id) ON DELETE CASCADE
      );
    ''');
  }

  Future<void> closeDatabase() async {
    await _database!.close();
  }
}
