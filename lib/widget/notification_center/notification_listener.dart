import 'dart:async';
import 'package:flutter_text/utils/utils.dart';

import 'notification_helper.dart';
import 'notification_model.dart';

//单例
class NotificationCenterListener {
  static NotificationCenterListener _notificationCenterListener;

  static StreamController<NotificationModel> _controller;

  factory NotificationCenterListener() =>
      _notificationCenterListener ?? NotificationCenterListener._init();

  NotificationCenterListener._init() {
    _controller = StreamController<NotificationModel>.broadcast();
    _notificationCenterListener = this;
  }

  static CancelCallBack listenModel() {
    final CancelCallBack callBack =
        _controller.stream.listen((NotificationModel event) {
      NotificationHelper.initEvent(event);
    })?.cancel;
    return callBack;
  }

  static void setListener(NotificationModel model) {
    _controller?.add(model);
  }

  static void dispose() {
    _controller?.close();
  }
}
