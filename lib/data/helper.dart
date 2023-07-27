import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    _database = await openDatabase(
      join(await getDatabasesPath(), 'mail_database.db'),
      onCreate: (db, version) async {
        await _createTables(db);
      },
      version: 1,
    );
    return _database!;
  }

  Future<void> _createTables(Database db) async {
    await db.execute(
      'CREATE TABLE accounts(email VARCHAR(255) PRIMARY KEY, jwt TEXT, host VARCHAR(100), unseen_count INTEGER)',
    );

    await db.execute(
      'CREATE TABLE folders(name VARCHAR(255) PRIMARY KEY, account_email VARCHAR(255), callname VARCHAR(255), favorite BOOLEAN)',
    );

    await db.execute(
      'CREATE TABLE mails(id INTEGER PRIMARY KEY, account_email VARCHAR(255), folder_name VARCHAR(255), from TEXT, to TEXT, subject TEXT, timestamp TEXT, seen BOOLEAN, html TEXT)',
    );
  }

  Future<void> closeDatabase() async {
    await _database!.close();
  }
}
//final dbHelper = DatabaseHelper();
  // final db = await dbHelper.database;
  //   return await db.insert('accounts', account.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);