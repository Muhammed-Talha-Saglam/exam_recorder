import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    // get the database location of the device
    final dbPath = await sql.getDatabasesPath();

    // open the database named "records" at the given location
    // and if it is the first time, create the database and exams table
    return sql.openDatabase(
      path.join(dbPath, "records.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE exams(id TEXT PRIMARY KEY, name TEXT, correct INTEGER , wrong INTEGER , date Text) ");
      },
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    // get the database
    final db = await DBHelper.database();
    // insert the data to the table
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    // get the database
    final db = await DBHelper.database();
    // return the rows in the table
    return db.query(table);
  }

  static Future<void> delete(String table, String id) async {
    // get the database
    final db = await DBHelper.database();

    // delete the row with the given id from the table "expenditure"
    // this return the number of rows deleted
    var count = await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
