import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlitecrudprovider/src/model/user.dart';

class DBHelper {
  static const _databaseName = 'Users.db';
  static const _databaseVersion = 1;

  DBHelper._();

  static final DBHelper instance = DBHelper._();
  static Database? _database;

  // Getter database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();

    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(path, 
      version: _databaseVersion,
      onCreate: _onCreateDatabase
    );
  }

  Future _onCreateDatabase(Database db, int version) async{
    await db.execute('CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT NOT NULL, email TEXT NOT NULL)');
  }

  Future<int> createUser(User user) async{
    final Database db = await database;

    int inserted = await db.insert('users', user.toJson());

    return inserted;
  }

  Future<List<User>> listUsers() async{
    final Database db = await database;
    
    final List<Map<String, Object?>> respDb = await db.query('users');

    return respDb.map((e) => User.fromJson(e)).toList();
  }
}
