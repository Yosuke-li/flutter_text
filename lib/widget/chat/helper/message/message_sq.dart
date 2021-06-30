import 'package:flutter_text/assembly_pack/database/base_db_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'message_model.dart';

class ChatMsgDbProvider extends BaseDbProvider {
  ///表名
  final String name = 'ChatMsg';

  final String columnId = 'id';
  final String columnName = 'name';
  final String columnToId = 'toId';
  final String columnMsg = 'msg';
  final String columnImage = 'image';
  final String columnTopic = 'topic';
  final String columnTime = 'time';
  final String columnType = 'type';

  ChatMsgDbProvider();

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
        $columnToId integer not null, $columnMsg text not null, 
        $columnImage text not null, $columnTopic text not null, 
        $columnType text not null, $columnTime int not null)
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

  //获取数据库里所有
  Future<List<MessageModel>> getAllUser() async {
    final List<Map<String, dynamic>> msgMap = await selectMapList();
    final int count = msgMap.length;
    final List<MessageModel> msgs = <MessageModel>[];

    for (int i = 0; i < count; i++) {
      msgs.add(MessageModel.fromJson(msgMap[i]));
    }
    return msgs;
  }

  //删除数据
  Future<int> deleteUser(int id) async {
    final Database db = await getDataBase();
    final int result =
        await db.rawDelete('DELETE FROM $name WHERE $columnId = $id');
    return result;
  }

  //获取数据数量
  Future<int> getTableCountsV2() async {
    final List<Map<String, dynamic>> userMapList = await selectMapList();
    final int count = userMapList.length;
    return count;
  }
}
