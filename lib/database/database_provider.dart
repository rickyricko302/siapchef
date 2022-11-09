import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database? database;

  Future<Database> get db async {
    if (database == null) {
      database = await openDatabase("resepDb", version: 1,
          onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE resep(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, url TEXT, img TEXT);");
      });
    }
    return database!;
  }
}
