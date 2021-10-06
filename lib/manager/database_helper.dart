import 'package:flutter/foundation.dart';
import 'package:news_flutter_app/model/table_enum.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelper {
  String _databaseName = 'quick_news.db';
  String _dbpwd = '!i&t=U\$0';
  static Database? _database;

  static final DatabaseHelper _databaseHelper =
      DatabaseHelper._createInstance();

  DatabaseHelper._createInstance();

  static DatabaseHelper getInstance() => _databaseHelper;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, _databaseName);
    // Open/create the database at a given path
    var appDatabase = await openDatabase(path,
        version: 1, onCreate: _createTable, password: _dbpwd);
    return appDatabase;
  }

  void _createTable(Database db, int newVersion) async {
    //create table
    await db.execute(
        'CREATE TABLE ${describeEnum(TableEnum.Article)}(id INTEGER PRIMARY KEY, '
        'author TEXT, title TEXT, description TEXT, publishedAt TEXT,'
        'url TEXT, urlToImage TEXT, content TEXT )');

    await db.execute(
        'CREATE TABLE ${describeEnum(TableEnum.Source)}(sourceId INTEGER PRIMARY KEY, '
        'id TEXT, name TEXT )');

  }


  // Insert Operation:
  Future<int> insert(String tableName, dynamic obj) async {
    Database? db = await this.database;
    var result = await db!.insert(tableName, obj.toDBJson());
    return result;
  }

  // Update Operation:
  Future<int> update(String tableName, dynamic obj, {var id}) async {
    Database? db = await this.database;
    var result = await db!
        .update(tableName, obj.toDBJson(), where: 'ID = ?', whereArgs: [id]);
    return result;
  }

  /// @return the items found
  Future<List<Map<String, dynamic>>> getMapList(String tableName,
  {bool? distinct,
      List<String>? columns,
      String? where,
      List<dynamic>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset}) async {
    Database? db = await this.database;

    var result = await db!.query(tableName,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
    return result;
  }

  Future<void> deleteRecords(List<String> tableList) async {
    Database? db = await this.database;
    var result;
    for (int i = 0; i < tableList.length; i++) {
      result = await db!.rawQuery('DELETE FROM ${tableList[i]}');
    }
    return result;
  }


}
