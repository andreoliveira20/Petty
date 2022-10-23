import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'petty.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE pet (id TEXT PRIMARY KEY, name TEXT, age TEXT, sex TEXT, breed TEXT, image Text, weight TEXT)');
        await db.execute(
            'CREATE TABLE vaccine (id TEXT PRIMARY KEY, vaccinename TEXT, petid TEXT)');
        await db.execute(
            'CREATE TABLE vaccinedate (id TEXT PRIMARY KEY, vaccineid TEXT, vaccinedate TEXT, vaccinedatelimit TEXT)');
        await db.execute(
            'CREATE TABLE user (id TEXT PRIMARY KEY, name TEXT, image TEXT)');
        await db.insert('user', {'id': '1', 'name': 'Usuario'});
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }

  static Future<void> deleteData(String table, String data) async {
    final db = await DbUtil.database();
    await db.delete(table, where: 'id= ?', whereArgs: [data]);
  }

  static Future<void> updateData(String table, dynamic data, String id) async {
    final db = await DbUtil.database();
    await db.update(table, data, where: 'id= ?', whereArgs: [data]);
  }
}
