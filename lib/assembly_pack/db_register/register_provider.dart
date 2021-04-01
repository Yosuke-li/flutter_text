import 'package:flutter_text/assembly_pack/database/base_db_provider.dart';
import 'package:flutter_text/model/db_register.dart';
import 'package:sqflite_common/sqlite_api.dart';

class RegisterProvider extends BaseDbProvider {
  final String name = 'User';

  final String id = 'id';
  final String account = 'account';
  final String password = 'password';
  final String updateTime = 'updateTime';
  final String createTime = 'createTime';

  RegisterProvider();

  //获取表名称
  @override
  String tableName() {
    return name;
  }

  @override
  String createTableString() {
    return 'create table $name ($id integer primary key, $account text not null, $password text not null, $updateTime integer not null, $createTime integer not null)';
  }

  ///查询数据
  Future<List<Map<String, dynamic>>> selectUser(int id) async {
    final db = await getDataBase();
    return db.rawQuery('select * from $name where id = $id');
  }

  //查询数据库所有
  Future<List<Map<String, dynamic>>> selectMapList() async {
    var db = await getDataBase();
    var result = await db.query(name);
    return result;
  }

  //获取数据库里所有user
  Future<List<DbRegister>> getAllUser() async {
    final userMapList = await selectMapList();
    final count = userMapList.length;
    final List<DbRegister> userList = <DbRegister>[];

    for (int i = 0; i < count; i++) {
      userList.add(DbRegister.fromJson(userMapList[i]));
    }
    return userList;
  }

  //根据id查询user
  Future<DbRegister> getUser(int id) async {
    final noteMapList = await selectUser(id); // Get 'Map List' from database
    DbRegister user = DbRegister.fromJson(noteMapList[id]);
    return user;
  }

  //增加数据
  Future<int> insertUser(DbRegister user) async {
    Database db = await getDataBase();
    final result = await db.insert(name, user.toMap());
    return result;
  }

  //更新数据
  Future<int> update(DbRegister register) async {
    final Database database = await getDataBase();
    final int result = await database.rawUpdate(
        'update $name set $password = ?,$updateTime = ? where $account= ?',
        [register.password, register.updateTime, register.account]);
    return result;
  }

  //删除数据
  Future<int> deleteUser(int id) async {
    final Database db = await getDataBase();
    final int result = await db.rawDelete('DELETE FROM $name WHERE $id = $id');
    return result;
  }

  //获取数据数量
  Future<int> getTableCountsV2() async {
    final userMapList = await selectMapList();
    final count = userMapList?.length ?? 0;
    return count;
  }
}
