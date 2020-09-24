import 'package:flutter_text/assembly_pack/database/sql_manager.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDbProvider {
  bool isTableExits = false;

  createTableString();

  tableName();

  tableBaseString(String sql) {
    return sql;
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  ///函数对父类进行初始化
  prepare(name, String createSql) async {
    isTableExits = await SqlManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await SqlManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  open() async {
    if (!isTableExits) {
      await prepare(tableName(), createTableString());
    }
    return SqlManager.getCurrentDatabase();
  }
}
