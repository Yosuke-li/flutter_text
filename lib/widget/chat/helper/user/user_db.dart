import 'dart:convert';

import 'package:flutter_text/utils/datetime_utils.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/widget/chat/helper/global/event.dart';
import 'package:flutter_text/widget/chat/helper/user/user.dart';
import 'package:postgres/postgres.dart';

part 'user_db_helper.dart';

class PostgresUser {
  ///表名
  static String name = 'user_db';

  static String columnId = 'id';
  static String columnName = 'name';
  static String columnImage = 'image';
  static String columnCreateTime = 'createTime';
  static String columnUpdateTime = 'updateTime';

  static PostgreSQLConnection connection = PostgreSQLConnection(
      DbGlobal.ip, DbGlobal.port, DbGlobal.database,
      username: DbGlobal.username, password: DbGlobal.password);

  static void init() async {
    await connection.open();
    Log.info('连接数据库');
    try {
      final bool isExits = await _isTableExits();
      if (isExits == false) {
        connection.execute('''
        CREATE TABLE $name (
        $columnId SERIAL PRIMARY KEY,$columnName TEXT NOT NULL,
        $columnCreateTime INTEGER NOT NULL,$columnUpdateTime INTEGER NOT NULL,
        $columnImage TEXT NOT NULL);
      ''');
      }
    } catch (e, s) {
      Log.error(e, stackTrace: s);
      rethrow;
    }
  }

  static Future<bool> _isTableExits() async {
    final List<Map<String, Map<String, dynamic>>> result =
        await connection.mappedResultsQuery('select * from $name');
    return result != null;
  }

  static Future<int> getMapList() async {
    final List<Map<String, Map<String, dynamic>>> result = await connection
        .mappedResultsQuery('SELECT * FROM $name order by $columnId ASC');
    return result?.length ?? 0;
  }

  //添加数据
  static Future<int> addUser(User user) async {
    final String sql = insert(name, user.toJson());
    final int res =
        await connection.execute(sql, substitutionValues: user.toJson());
    return res;
  }

  static Future<User> checkUser(User user) async {
    final List<Map<String, Map<String, dynamic>>> result = await connection
        .mappedResultsQuery('select * from $name where id = ${user.id}');

    if (result != null && result.isNotEmpty == true) {
      final User hasUser = User.fromJson(result[0]['$name']);
      if (hasUser.name == user.name) {
        hasUser.updateTime = DateTimeHelper.getLocalTimeStamp() ~/ 1000;
        updateUser(hasUser);
        return hasUser;
      }
      return null;
    } else {
      return null;
    }
  }

  //通过id查找user
  static Future<User> getOneWithId(int id) async {
    final List<Map<String, Map<String, dynamic>>> result = await connection
        .mappedResultsQuery('select * from $name where id = $id');

    if (result != null && result.isNotEmpty == true) {
      final User hasUser = User.fromJson(result[0]['$name']);
      return hasUser;
    } else {
      return null;
    }
  }

  //更新数据
  static Future<int> updateUser(User user) async {
    final String sql = update(
        name,
        user.toJson(),
        'WHERE $columnId = '
        '${user.id}');
    final int res =
        await connection.execute(sql, substitutionValues: user.toJson());
    return res;
  }
}
