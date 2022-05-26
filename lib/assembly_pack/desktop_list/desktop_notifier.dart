import 'package:flutter/material.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:win_toast/win_toast.dart';
import 'package:path/path.dart' as path;

class DesktopNotifierPage extends StatefulWidget {
  const DesktopNotifierPage({Key? key}) : super(key: key);

  @override
  _DesktopNotifierPageState createState() => _DesktopNotifierPageState();
}

class _DesktopNotifierPageState extends State<DesktopNotifierPage> {
  final LocalNotifier _notifier = LocalNotifier.instance;
  Toast? _toast;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await WinToast.instance().initialize(
        appName: 'flutter_text',
        productName: 'flutter_text',
        companyName: 'self');
  }

  void _toastImageWithText() async {
    final String image = path.join(path.current, 'assets/banner/back.png');
    Log.info(image);
    _toast = await WinToast.instance().showToast(
        type: ToastType.imageAndText01,
        title: '桌面弹窗测试01',
        imagePath: image,
        actions: ['确定', '取消']);

    _toast?.eventStream.listen((Event event) {
      Log.info('点击index: ${(event as ActivatedEvent).actionIndex}');
      WinToast.instance().bringWindowToFront(); //点击之后关闭弹窗通知
    });
    setState(() {});
  }

  void _toastJustText() async{
    _toast = await WinToast.instance().showToast(
        type: ToastType.text01,
        title: '桌面弹窗测试02',
        actions: ['确定', '取消']);

    _toast?.eventStream.listen((Event event) {
      Log.info('点击index: ${(event as ActivatedEvent).actionIndex}');
      WinToast.instance().bringWindowToFront(); //点击之后关闭弹窗通知
    });
    setState(() {});
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
                  final LocalNotification notification =
                      LocalNotification(title: '测试');
                  _notifier.notify(notification);
                },
                child: const Text('发送通知'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('other'),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _toastImageWithText();
                        },
                        child: const Text('发送image with text消息推送'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _toastJustText();
                        },
                        child: const Text('发送text消息通知'),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
