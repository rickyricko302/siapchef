import 'package:siapchef/database/database_provider.dart';
import 'package:siapchef/model/database_model.dart';

class DatabaseController {
  final dbClient = DatabaseProvider.dbProvider;

  Future<int> addResep(DatabaseModel data) async {
    var sudahAda = await cekResep(data.title!);
    if (sudahAda) {
      return deleteResep(data);
    } else {
      final db = await dbClient.db;
      var res = await db.insert("resep", data.toJson());
      print("tambah");
      return res;
    }
  }

  Future<bool> cekResep(String title) async {
    final db = await dbClient.db;
    var res = await db.rawQuery("SELECT * FROM resep WHERE title = '$title';");
    return res.isNotEmpty;
  }

  Future<int> deleteResep(DatabaseModel data) async {
    final db = await dbClient.db;
    var res =
        await db.rawDelete("DELETE FROM resep WHERE title='${data.title}';");
    print("delete");
    return res;
  }

  Future getAllData() async {
    final db = await dbClient.db;
    var res = db.rawQuery("SELECT * FROM resep;");
    return res;
  }

  Future<void> closeDb() async {
    final db = await dbClient.db;
    db.close();
  }
}
