import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_text/assembly_pack/chat_self/chat_room/view.dart';
import 'package:flutter_text/init.dart';
import 'package:flutter_text/utils/toast_utils.dart';

import 'notification_model.dart';


class NotificationHelper {
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static late BuildContext _context;

  //初始化
  static void init(BuildContext context) {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings android =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings =
    InitializationSettings(android: android);
    _context = context;
    flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: _onSelectNotification);
  }

  //触发相应的事件
  static Future<void> _onSelectNotification(String? payload) async {
    if (payload != null) {
      final NotificationModel event = NotificationModel.fromJson(jsonDecode(payload));
      if (event.type == NotificationType.Message.enumToString) {
        ToastUtils.showToast(msg: event.msg??'');
        return;
      } else if (event.type == NotificationType.SelfChat.enumToString) {
        NavigatorUtils.getXOfPush(_context, ChatRoomPage(),
            arguments: {'topic': event.title});
        return;
      }
    }
  }

  //触发监听
  static void initEvent(NotificationModel event) async{
    const AndroidNotificationDetails android = AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    const IOSNotificationDetails iOS =  IOSNotificationDetails();
    const NotificationDetails platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        event.id??0, event.title, event.msg, platform,
        payload: jsonEncode(event));
  }
}