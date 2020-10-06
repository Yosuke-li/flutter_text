import 'package:common_utils/common_utils.dart';
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
    LogUtil.v(keys.toString(), tag: 'debug: ${DateTime.now()} getAllKey ');
  }

  //设置String缓存
  static void setString(String key, String val) {
    lStorage.setString('$key', val);
    LogUtil.v(val, tag: 'debug: ${DateTime.now()} setString $key');
  }

  //获取String缓存
  static String getString(String key) {
    final value = lStorage.getString('$key');
    LogUtil.v(value, tag: 'debug: ${DateTime.now()} getString $key');
    return value;
  }

  //设置bool缓存
  static void setBool(String key, bool val) {
    lStorage.setBool('$key', val);
    LogUtil.v(val, tag: 'debug: ${DateTime.now()} setBool $key');
  }

  //获取bool缓存
  static bool getBool(String key) {
    final value = lStorage.getBool('$key');
    LogUtil.v(value, tag: 'debug: ${DateTime.now()} getBool $key');
    return value;
  }

  //设置int缓存
  static void setInt(String key, int val) {
    lStorage.setInt('$key', val);
    LogUtil.v(val, tag: 'debug: ${DateTime.now()} setInt $key');
  }

  //获取int缓存
  static int getInt(String key) {
    final value = lStorage.getInt('$key');
    LogUtil.v(value, tag: 'debug: ${DateTime.now()} getInt $key');
    return value;
  }

  //设置字符串数组
  static void setStringList(String key, List<String> lists) {
    lStorage.setStringList(key, lists);
    LogUtil.v(lists, tag: 'debug: ${DateTime.now()} setStringList $key');
  }

  //获取字符串数组
  static List<String> getStringList(String key) {
    final List<String> lists = lStorage.getStringList(key);
    LogUtil.v(lists, tag: 'debug: ${DateTime.now()} getStringList $key');
    return lists;
  }
}
