import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlManager {
  static const _VERSION = 1;

  static const _NAME = 'my.db';

  static late Database _database;

  //初始化
  static Future<void> init() async {
    final dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, _NAME);
    _database = await openDatabase(path,
        version: _VERSION, onCreate: (Database db, int version) async {});
  }

  static Future<bool> isTableExits(String tableName) async {
    await getCurrentDatabase();
    final result = await _database.rawQuery(
        "select * from Sqlite_master where type= 'table' and name = '$tableName'");
    return result != null && result.isNotEmpty;
  }

  //获取当前数据库
  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  static void close() {
    _database.close();
  }
}
