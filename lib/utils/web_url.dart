import 'package:flutter_text/utils/toast_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'log_utils.dart';

class WebUrl {
  //判断链接的可用性
  static Future<String?> checkUrl(String value,
      {bool enable = true, String errorMsg = '该链接不可用'}) async {
    if (!enable) return null;
    return await canLaunch(value) ? null : errorMsg;
  }

  //跳转链接
  static Future<void> launchUrl(String url) async {
    final String? result = await checkUrl(url);
    if (result == null) {
      await launch(url);
    } else {
      ToastUtils.showToast(msg: result);
      return;
    }
  }

  //scheme跳转
  static Future<void> launchSchemeUrl(String url) async {
    try {
      await launch(url);
    } catch (error, stack) {
      Log.error(error, stackTrace: stack);
      rethrow;
    }
  }
}
