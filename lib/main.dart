// import 'package:flutter_doraemonkit/flutter_doraemonkit.dart';
import 'package:flutter_text/splash.dart';
import 'package:flutter_text/widget/api_call_back.dart';

import 'init.dart';

import 'package:flutter_text/utils/api_exception.dart';
import 'package:flutter_text/utils/toast_utils.dart';
import 'package:flutter_text/widget/keyboard/security_keyboard.dart';
import 'package:flutter_text/widget/navigator_helper.dart';
import 'assembly_pack/event_bus/event_util.dart';
import 'index.dart';
import 'utils/init.dart';

Future<void> main() async {
  SecurityKeyboardCenter.register();
  runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = _errorHandler;
    runApp(Assembly());
  }, (Object error, StackTrace stackTrace) async {
    _errorHandler(FlutterErrorDetails(exception: error, stack: stackTrace));
  });
}

///BotToastInit BotToastNavigatorObserver toast弹窗初始化
class Assembly extends StatefulWidget {
  @override
  AssemblyState createState() => AssemblyState();
}

class AssemblyState extends State<Assembly> {
  bool todayShowAd;

  @override
  void initState() {
    Future<void>.delayed(Duration.zero, () async {
      await init();
    });
    super.initState();
  }

  Future<void> init() async {
    await LocateStorage.init().whenComplete(
      () => getTodayShow(),
    );
  }

  void getTodayShow() {
    final bool splashShow = LocateStorage.getBoolWithExpire('SplashShow');
    if (splashShow == true) {
      todayShowAd = true;
    } else {
      todayShowAd = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      child: NavigatorInitializer(
        child: NotificationListenPage(
          child: AppLifecycleWidget(
            child: ModalStyleWidget(
              child: MaterialApp(
                builder: BotToastInit(),
                navigatorObservers: <NavigatorObserver>[
                  BotToastNavigatorObserver()
                ],
                home: GestureDetector(
                  onLongPress: () {
                    // FlutterDoraemonkit.toggle();
                  },
                  child: KeyboardRootWidget(
                    child: todayShowAd != null
                        ? (todayShowAd ? MainIndexPage() : SplashPage())
                        : Container(
                      color: Colors.white,
                    ),
                    // child: MainIndexPage(),
                  ),
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//错误信息处理
void _errorHandler(FlutterErrorDetails details) async {
  await ReportError().reportError(details.exception, details.stack);

  if (ReportError().isInDebugMode) {
    FlutterError.dumpErrorToConsole(details);
  } else {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  }

  if (details.exception != null) {
    if (details.exception is ApiException) {
      final ApiException e = details.exception as ApiException;
      final int code = e.code;
      final String message = e.message;
      switch (code) {
        case 401:
          final NavigatorState navigatorHelper =
              await NavigatorHelper.navigatorState;
          ToastUtils.showToast(msg: '401错误');
          navigatorHelper.popUntil((Route route) => route.isFirst);
          break;
        case 403:
          final NavigatorState navigatorHelper =
              await NavigatorHelper.navigatorState;
          ToastUtils.showToast(msg: '403错误');
          navigatorHelper.popUntil((Route route) => route.isFirst);
          break;
        default:
          ToastUtils.showToast(msg: message);
          break;
      }
    } else if (details.exception is SocketException) {
      ToastUtils.showToast(msg: '网络不可用');
    } else if (details.exception is TimeoutException) {
      ToastUtils.showToast(
          msg: (details.exception as TimeoutException).message);
    }
  }
}
