import 'dart:convert';

import 'package:flutter_text/global/store.dart';
import 'package:flutter_text/model/sql_user.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/helpers/interfaces/i_test.dart';

class LoginApi implements TestCache<SqlUser> {
  static const String _key = '_user_cache';

  @override
  Future<SqlUser?> getCache(int id) async {
    final List<SqlUser> allCache = await getAllCache();
    for (var e in allCache) {
      if (e.id == id) {
        return e;
      }
    }
    return null;
  }

  @override
  Future<void> setCache(SqlUser data) async {
    List<SqlUser> newList = <SqlUser>[];
    final List<SqlUser> allCache = await getAllCache();
    allCache.add(data);
    newList =
        ArrayHelper.unique<SqlUser>(listData: allCache, getKey: (SqlUser item) => item.id);

    LocateStorage.setString(_key, jsonEncode(newList));
  }

  @override
  Future<void> deleteCache(int id) async {
    final List<SqlUser> allCache = await getAllCache();
    allCache.removeWhere((element) => element.id == id);
    LocateStorage.setString(_key, jsonEncode(allCache));
  }

  @override
  Future<List<SqlUser>> getAllCache() async {
    List<SqlUser> result = <SqlUser>[];
    final String? json = LocateStorage.getString(_key);
    if (json != null && json.isNotEmpty == true) {
      result = SqlUser.listFromJson(jsonDecode(json));
    }
    return result;
  }
}
