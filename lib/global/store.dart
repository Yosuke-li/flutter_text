import 'package:shared_preferences/shared_preferences.dart';

class LocateStorage {
  static SharedPreferences lStorage;

  //初始化
  static Future<SharedPreferences> init() async {
    lStorage = await SharedPreferences.getInstance();
    return lStorage;
  }

  //是否有这个val值为key的缓存
  static bool containsKey(String val) {
    return lStorage.containsKey(val);
  }

  //请理缓存
  static void clean({String key}) {
    if (key != null && key.isNotEmpty == true) {
      lStorage.remove(key);
    } else {
      lStorage.clear();
    }
  }

  //查看所有keys
  static void getAllKey() {
    final keys = lStorage.getKeys();
  }

  //查看所有keys
  static String getOneKey(String key) {
    final keys = lStorage.getKeys();
    if (keys != null && keys.isNotEmpty == true) {
      String hasKey = keys.firstWhere((element) => element.contains('$key '));
      return hasKey;
    }
    return null;
  }

  //设置String缓存
  static void setString(String key, String val) {
    lStorage.setString('$key', val);
  }

  //获取String缓存
  static String getString(String key) {
    final value = lStorage.getString('$key');
    return value;
  }

  //设置bool缓存
  static void setBool(String key, bool val) {
    lStorage.setBool('$key', val);
  }

  //获取bool缓存
  static bool getBool(String key) {
    final value = lStorage.getBool('$key');
    return value;
  }

  //设置int缓存
  static void setInt(String key, int val) {
    lStorage.setInt('$key', val);
  }

  //获取int缓存
  static int getInt(String key) {
    final value = lStorage.getInt('$key');
    return value;
  }

  //设置字符串数组
  static void setStringList(String key, List<String> lists) {
    lStorage.setStringList(key, lists);
  }

  //获取字符串数组
  static List<String> getStringList(String key) {
    final List<String> lists = lStorage.getStringList(key);
    return lists;
  }

  //设置String缓存
  static void setStringWithExpire(String key, String val, Duration expireTime) {
    final hasKey = getOneKey(key);
    if (hasKey != null) {
      clean(key: hasKey);
    }
    lStorage.setString('$key ${expireTime.inSeconds}', val);
  }

  //获取String缓存
  static String getStringWithExpire(String key) {
    final hasKey = getOneKey(key);
    final value = lStorage.getString('$hasKey');
    return value;
  }

  //设置bool缓存
  static void setBoolWithExpire(String key, bool val, Duration expireTime) {
    final hasKey = getOneKey(key);
    if (hasKey != null) {
      clean(key: hasKey);
    }
    lStorage.setBool('$key ${expireTime.inSeconds}', val);
  }

  //获取bool缓存
  static bool getBoolWithExpire(String key) {
    final hasKey = getOneKey(key);
    final value = lStorage.getBool('$hasKey');
    return value;
  }

  //设置int缓存
  static void setIntWithExpire(String key, int val, Duration expireTime) {
    final hasKey = getOneKey(key);
    if (hasKey != null) {
      clean(key: hasKey);
    }
    lStorage.setInt('$key ${expireTime.inSeconds}', val);
  }

  //获取int缓存
  static int getIntWithExpire(String key) {
    final hasKey = getOneKey(key);
    final value = lStorage.getInt('$hasKey');
    return value;
  }

  //设置字符串数组
  static void setStringListWithExpire(
      String key, List<String> lists, Duration expireTime) {
    final hasKey = getOneKey(key);
    if (hasKey != null) {
      clean(key: hasKey);
    }
    lStorage.setStringList('$key  ${expireTime.inSeconds}', lists);
  }

  //获取字符串数组
  static List<String> getStringListWithExpire(String key) {
    final hasKey = getOneKey(key);
    final List<String> lists = lStorage.getStringList(hasKey);
    return lists;
  }
}
