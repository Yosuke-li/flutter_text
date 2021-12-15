import 'dart:io';

import 'package:flutter/material.dart';

import 'notification_controller.dart';
import 'notification_helper.dart';
import 'notification_listener.dart';

class NotificationListenPage extends StatefulWidget {
  NotificationListenPage({@required this.child});

  Widget child;

  @override
  NotificationListenPageState createState() => NotificationListenPageState();
}

class NotificationListenPageState extends State<NotificationListenPage> {
  NotificationController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid == true) {
      NotificationCenterListener();
      NotificationHelper.init(context);
      _controller = NotificationController.listen();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
