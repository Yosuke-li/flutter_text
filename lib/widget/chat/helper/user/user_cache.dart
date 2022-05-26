import 'dart:convert';

import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/global/store.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/helpers/interfaces/i_test.dart';
import 'package:flutter_text/widget/chat/helper/user/user.dart';
import 'package:flutter_text/widget/chat/helper/user/user_db.dart';

class UserCache implements TestCache<User> {
  static const String _key = 'user';

  @override
  Future<void> deleteCache(int id) async {
    final List<User> allCache = await getAllCache();
    allCache.removeWhere((User element) => element.id == id);
    LocateStorage.setStringWithExpire(_key + '${GlobalStore.user?.id}',
        jsonEncode(allCache), const Duration(days: 1));
  }

  @override
  Future<List<User>> getAllCache() async {
    List<User> result = <User>[];
    final String? json =
        LocateStorage.getStringWithExpire(_key + '${GlobalStore.user?.id}');
    if (json != null && json.isNotEmpty == true) {
      result = User.listFromJson(jsonDecode(json));
    }
    return result;
  }

  @override
  Future<User?> getCache(int id) async {
    final List<User> allCache = await getAllCache();
    User? result;
    allCache.forEach((element) {
      if (element.id == id) {
        result = element;
      }
    });
    if (result == null) {
      result = await PostgresUser.getOneWithId(id);
      setCache(result!);
    }
    return result;
  }

  @override
  Future<void> setCache(User data) async {
    List<User> newList = <User>[];
    final List<User> allCache = await getAllCache();
    allCache.add(data);
    newList = ArrayHelper.unique<User>(
        listData: allCache, getKey: (User item) => item.id);
    LocateStorage.setStringWithExpire(_key + '${GlobalStore.user?.id}',
        jsonEncode(newList), const Duration(days: 1));
  }
}
