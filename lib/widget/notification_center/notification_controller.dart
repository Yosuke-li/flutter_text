import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:self_utils/utils/utils.dart';

import 'notification_listener.dart';

class NotificationController extends ChangeNotifier {
  CancelCallBack? cancelCallBack;

  NotificationController.listen() {
    cancelCallBack = NotificationCenterListener.listenModel();
  }

  @override
  void dispose() {
    cancelCallBack?.call();
    super.dispose();
  }
}
