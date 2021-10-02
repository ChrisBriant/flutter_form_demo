import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBProvider with ChangeNotifier {
    static Future<Database> database() async {
    
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath,'exerscises.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE exerscises(id TEXT PRIMARY KEY,exersizeName TEXT,reps INTEGER, weight REAL, weekday INTEGER, iscardio INTEGER);');
      },
      version: 1
    );
  } 

  static Future<void> insert(String table, Map<String,Object> data) async {
    final db = await DBProvider.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBProvider.database();
    return db.query(table);
  }


  Future<List<Map<String, dynamic>>> getExersizes() async {
    final db = await DBProvider.database();
    notifyListeners();
    return db.query('exerscises');
  }

  Future<int> getRowCount(String table) async {
    final db = await DBProvider.database();
    //sql.Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $table;')
      .then(
         (record) => record.length 
      );
      return 0;
    //);
    //return count;
    //return int.parse(db.rawQuery('SELECT COUNT(*) FROM $table;'));
  }

}