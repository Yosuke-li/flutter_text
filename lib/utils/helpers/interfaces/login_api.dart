import 'dart:convert';

import 'package:flutter_text/global/store.dart';
import 'package:flutter_text/model/db_user.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/helpers/interfaces/i_test.dart';

class LoginApi implements TestCache<User> {
  static const String _key = '_user_cache';

  @override
  Future<User> getCache(int id) async {
    final List<User> allCache = await getAllCache();
    return allCache.firstWhere((User element) => element.id == id,
        orElse: () => null);
  }

  @override
  Future<void> setCache(User data) async {
    List<User> newList = <User>[];
    final List<User> allCache = await getAllCache();
    allCache.add(data);
    newList =
        ArrayHelper.unique<User>(listData: allCache, getKey: (item) => item.id);
    LocateStorage.setString(_key, jsonEncode(newList));
  }

  @override
  Future<void> deleteCache(int id) async {
    final List<User> allCache = await getAllCache();
    allCache.removeWhere((element) => element.id == id);
    LocateStorage.setString(_key, jsonEncode(allCache));
  }

  @override
  Future<List<User>> getAllCache() async {
    List<User> result = <User>[];
    String json = LocateStorage.getString(_key);
    if (json != null && json.isNotEmpty == true) {
      result = User.listFromJson(jsonDecode(json));
    }
    return result;
  }
}
