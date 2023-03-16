

import 'package:flutter/material.dart';
import 'package:flutter_text/widget/chat/helper/user/user.dart';

class GlobalStore {
  static bool isShowOverlay = false; //flutter自带的性能监听 控制
  static bool isShowGary = false; //灰度屏
  static Locale locale = const Locale('zh');
  static String homeIp = '192.168.9.138';
  static String companyIp = '172.31.172.83'; //todo ipconfig 因为非公司内网所以无法使用
  static bool isUserFiddle = false; //是否使用fiddle
  static bool isMobile = true; // 判断是否是桌面端

  static User? user;

  static ColorFilter greyScale = const ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
  ]);
}


