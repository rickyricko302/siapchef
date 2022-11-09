import 'package:siapchef/database/database_controller.dart';
import 'package:siapchef/model/database_model.dart';

class DbRepository {
  final DatabaseController databaseController = DatabaseController();

  Future insertResep(DatabaseModel data) => databaseController.addResep(data);
  Future cekResep(String title) => databaseController.cekResep(title);
  Future closeDb() => databaseController.closeDb();
  Future getAllData() => databaseController.getAllData();
}
