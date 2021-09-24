

import 'package:flutter_text/widget/chat/helper/user/user.dart';

class GlobalStore {
  static bool isShowOverlay = false; //flutter自带的性能监听 控制
  static String homeIp = '192.168.9.138';
  static String companyIp = '172.31.172.83'; //todo ipconfig 因为非公司内网所以无法使用
  static bool isUserFiddle = true; //是否使用fiddle

  static User user;
}

class EventCache {
  bool isRoute;
  String realTimeData;
}
