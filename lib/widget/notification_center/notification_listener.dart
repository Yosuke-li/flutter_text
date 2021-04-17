import 'dart:async';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_text/utils/utils.dart';

import 'notification_helper.dart';
import 'notification_model.dart';


class NotificationCenterListener {
  static StreamController<NotificationModel> controller;

  static void init() {
    controller = StreamController<NotificationModel>.broadcast();
  }

  static CancelCallBack listenModel() {
    final CancelCallBack callBack =
        controller.stream.listen((NotificationModel event) {
          NotificationHelper.initEvent(event);
        })?.cancel;
    return callBack;
  }

  static void setListener(NotificationModel model) {
    controller?.add(model);
  }

  static void dispose() {
    controller?.close();
  }
}
