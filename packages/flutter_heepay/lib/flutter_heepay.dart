
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterHeepay {
  static const MethodChannel _channel = MethodChannel('flutter_heepay');

  ///调取原生方法
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///传参数进原生
  static Future<String>? init(String key) async {
    final String initMsg = await _channel.invokeMethod('init', key);
    return initMsg;
  }

  ///
}
