import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/objects/todo.dart';
import 'package:todo_app/services/app_exception.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider instance = SQLiteDbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB("todoDB.db");
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, filePath);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";

    await db.execute("CREATE TABLE $tableTodo ("
        "${TodoFields.id} $idType,"
        "${TodoFields.name} $textType,"
        "${TodoFields.status} $textType,"
        "${TodoFields.createdDate} $textType"
        ")");
  }

  Future<List<Map<String, Object>>> get(String table) async {
    final db = await instance.database;
    final results = await db.query(table, orderBy: "createdDate DESC");

    if (results.isNotEmpty) {
      return results;
    }
    // throw FetchDataException('Data is null - 404');
    return [];
  }

  Future<List<Map<String, Object>>> getWithParam(
      String table, String cell, dynamic value) async {
    final db = await instance.database;
    final results = await db.query(table,
        where: "$cell = ?", whereArgs: [value], orderBy: "createdDate DESC");

    if (results.isNotEmpty) {
      return results;
    }
    // throw FetchDataException('Data is null - 404');
    return [];
  }

  Future<int> create(String tableName, dynamic table) async {
    final db = await instance.database;
    final results = await db.insert(tableName, table.toJson());

    if (results != null) {
      return results;
    } else {
      throw FetchDataException('Error Crreate Task');
    }
  }

  Future<int> update(String tableName, dynamic table) async {
    final db = await instance.database;
    final results = await db.update(tableName, table.toJson(),
        where: "id = ?", whereArgs: [table.id]);

    if (results != null) {
      return results;
    } else {
      throw FetchDataException('Error Update Task');
    }
  }

  Future<int> delete(String tableName, dynamic table) async {
    final db = await instance.database;
    final results =
        await db.delete(tableName, where: "id = ?", whereArgs: [table.id]);

    if (results != null) {
      return results;
    } else {
      throw FetchDataException('Error Delete Task');
    }
  }

  Future closeDB() async {
    final db = await instance.database;
    db.close();
  }
}
