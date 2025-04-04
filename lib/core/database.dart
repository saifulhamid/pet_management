import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/adoption_model.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('adoption.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE adoptions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER,
        gender TEXT,
        numPets INTEGER
      )
    ''');
  }

  Future<void> insertAdoption(Adoption adoption) async {
    final db = await instance.database;
    await db.insert('adoptions', adoption.toMap());
  }

  Future<List<Adoption>> getAdoptions() async {
    final db = await instance.database;
    final result = await db.query('adoptions');
    return result.map((json) => Adoption.fromMap(json)).toList();
  }

  Future<void> deleteAdoption(int id) async {
    final db = await instance.database;
    await db.delete('adoptions', where: 'id = ?', whereArgs: [id]);
  }
}
