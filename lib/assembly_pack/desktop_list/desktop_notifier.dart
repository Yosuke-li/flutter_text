import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:path/path.dart' as path;

class DesktopNotifierPage extends StatefulWidget {

  const DesktopNotifierPage({Key? key}) : super(key: key);

  @override
  _DesktopNotifierPageState createState() => _DesktopNotifierPageState();
}

class _DesktopNotifierPageState extends State<DesktopNotifierPage> {
  late LocalNotification notification;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    notification = LocalNotification(
      title: '消息更新',
      body: '有新的点价单！点击查看',
    );
    notification.onShow = () {
      print('onShow ${notification.identifier}');
    };
    notification.onClose = (closeReason) {
      // Only supported on windows, other platforms closeReason is always unknown.
      switch (closeReason) {
        case LocalNotificationCloseReason.userCanceled:
        // do something
          break;
        case LocalNotificationCloseReason.timedOut:
        // do something
          break;
        default:
      }
    };
    notification.onClick = () {
      print('onClick ${notification.identifier}');
    };
    notification.onClickAction = (actionIndex) {
      print('onClickAction ${notification.identifier} - $actionIndex');
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('发送本地推送 桌面版'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('normal'),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  notification.show();
                },
                child: const Text('发送通知'),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
