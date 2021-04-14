import 'package:flutter/material.dart';
import 'package:flutter_text/utils/notification_center/notification_listener.dart';
import 'package:flutter_text/utils/notification_center/notification_model.dart';
import 'package:flutter_text/utils/screen.dart';
import 'package:move_to_background/move_to_background.dart';

class LocalNotificationList extends StatefulWidget {
  @override
  LocalNotificationListState createState() => LocalNotificationListState();
}

class LocalNotificationListState extends State<LocalNotificationList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本地消息推送'),
      ),
      body: RepaintBoundary(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                NotificationCenterListener.setListener(
                    NotificationModel()
                      ..type = NotificationType.Message.enumToString
                      ..id = 0
                      ..title = '测试用标题'
                      ..msg = '测试用内容');
              },
              child: Container(
                height: screenUtil.adaptive(200),
                child: Text('测试demo1'),
              ),
            ),
            InkWell(
              onTap: () async {
                MoveToBackground.moveTaskToBack();
                await Future<void>.delayed(const Duration(seconds: 5));
                NotificationCenterListener.setListener(
                    NotificationModel()
                      ..type = NotificationType.Message.enumToString
                      ..id = 1
                      ..title = '后台隐藏发送推送标题'
                      ..msg = '后台隐藏发送内容');
              },
              child: Container(
                height: screenUtil.adaptive(200),
                child: Text('测试demo2 -- 后台隐藏发送'),
              ),
            ),
            InkWell(
              onTap: () {

              },
              child: Container(
                height: screenUtil.adaptive(200),
                child: Text('测试demo3'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
