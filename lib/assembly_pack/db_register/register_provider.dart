import 'package:flutter_text/assembly_pack/database/base_db_provider.dart';
import 'package:flutter_text/model/db_register.dart';

class RegisterProvider extends BaseDbProvider {
  final name = 'User';

  final String id = "id";
  final String account = "account";
  final String password = "password";
  final String updateTime = "updateTime";
  final String createTime = "createTime";

  RegisterProvider();

  //获取表名称
  @override
  tableName() {
    return name;
  }

  @override
  createTableString() {
    return 'create table $name ($id integer primary key, $account text not null, $password text not null, $updateTime integer not null, $createTime integer not null)';
  }

  ///查询数据
  Future selectUser(int id) async {
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
    var userMapList = await selectMapList();
    var count = userMapList.length;
    List<DbRegister> userList = List<DbRegister>();

    for (int i = 0; i < count; i++) {
      userList.add(DbRegister.fromJson(userMapList[i]));
    }
    return userList;
  }

  //根据id查询user
  Future<DbRegister> getUser(int id) async {
    var noteMapList = await selectUser(id); // Get 'Map List' from database
    var user = DbRegister.fromJson(noteMapList[id]);
    return user;
  }

  //增加数据
  Future<int> insertUser(DbRegister user) async {
    var db = await getDataBase();
    var result = await db.insert(name, user.toMap());
    return result;
  }

  //更新数据
  Future<int> update(DbRegister register) async {
    var database = await getDataBase();
    var result = await database.rawUpdate(
        "update $name set $password = ?,$updateTime = ? where $account= ?",
        [register.password, register.updateTime, register.account]);
    return result;
  }

  //删除数据
  Future<int> deleteUser(int id) async {
    var db = await getDataBase();
    var result = await db.rawDelete('DELETE FROM $name WHERE $id = $id');
    return result;
  }

  //获取数据数量
  Future<int> getTableCountsV2() async {
    final userMapList = await selectMapList();
    final count = userMapList?.length ?? 0;
    return count;
  }
}
