import 'package:flutter_text/assembly_pack/database/base_db_provider.dart';
import 'package:flutter_text/model/sql_user.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/utils.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDbProvider extends BaseDbProvider {
  ///表名
  final String name = 'UserInfo';

  final String columnId = "id";
  final String columnName = "name";
  final String columnDesc = "desc";

  UserDbProvider();

  //获取表名称
  @override
  String tableName() {
    return name;
  }

  //创建表操作
  @override
  String createTableString() {
    return '''
        create table $name (
        $columnId integer primary key,$columnName text not null,
        $columnDesc text not null)
      ''';
  }

  ///查询数据
  Future<List<Map<String, dynamic>>> selectUser(int id) async {
    final Database db = await getDataBase();
    return await db.rawQuery('select * from $name where $columnId = $id');
  }

  //查询数据库所有
  Future<List<Map<String, dynamic>>> selectMapList() async {
    final Database db = await getDataBase();
    final List<Map<String, dynamic>> result = await db.query(name);
    return result;
  }

  //获取数据库里所有user
  Future<List<SqlUser>> getAllUser() async {
    final List<Map<String, dynamic>> userMapList = await selectMapList();
    final int count = userMapList.length;
    final List<SqlUser> userList = <SqlUser>[];

    for (int i = 0; i < count; i++) {
      userList.add(SqlUser.fromMapObject(userMapList[i]));
    }
    return userList;
  }

  //根据id查询user
  Future<SqlUser> getUser(int id) async {
    final List<Map<String, dynamic>> noteMapList = await selectUser(id); // Get 'Map List' from database
    final SqlUser user = SqlUser.fromMapObject(noteMapList[id]);
    return user;
  }

  //增加数据
  Future<int> insertUser(SqlUser user) async {
    Database db = await getDataBase();
    final int result = await db.insert(name, user.toMap());
    return result;
  }

  //更新数据
  Future<int> update(SqlUser user) async {
    final Database database = await getDataBase();
    final int result = await database.rawUpdate(
        'update $name set $columnName = ?,$columnDesc = ? where $columnId= ?',
        [user.name, user.desc, user.id]);
    return result;
  }

  //删除数据
  Future<int> deleteUser(int id) async {
    final Database db = await getDataBase();
    final int result = await db.rawDelete('DELETE FROM $name WHERE $columnId = $id');
    return result;
  }

  //获取数据数量
  Future<int> getTableCounts() async {
    final Database database = await getDataBase();
    final List<Map<String, dynamic>> result =
        await database.rawQuery('select count(*) as counts from $name');
    return ArrayHelper.get(result, 0)!['counts'];
  }

  //获取数据数量
  Future<int> getTableCountsV2() async {
    final List<Map<String, dynamic>> userMapList = await selectMapList();
    final int count = userMapList.length;
    return count;
  }
}
