import 'package:shared_preferences/shared_preferences.dart';

class LocateStorage {
  static SharedPreferences lStorage;

  //初始化
  Future<SharedPreferences> init() async {
    lStorage = await SharedPreferences.getInstance();
    return lStorage;
  }
}
