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
    await db.execute('CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT NOT NULL, apellidos TEXT, email TEXT NOT NULL)');
  }

  // Método que crea un usuario en base de datos
  Future<int> createUser(User user) async{
    final Database db = await database;

    int inserted = await db.insert('users', user.toJson());

    return inserted;
  }

  // Método que lista todos los usuarios de base de datos
  Future<List<User>> listUsers() async{
    final Database db = await database;
    
    final List<Map<String, Object?>> respDb = await db.query('users');

    return respDb.map((e) => User.fromJson(e)).toList();
  }

  // Método que elimina un usuario de base de datos
  Future<void> deleteUser(int id) async{
    final Database db = await database;

    db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Método que actualiza un usuario existente
  Future<void> updateUser(User user) async{
    final Database db = await database;

    db.update('users', user.toJson(), where: 'id = ?', whereArgs: [user.id]);
  }
}
