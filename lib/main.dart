// import 'package:flutter_doraemonkit/flutter_doraemonkit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_text/assembly_pack/desktop_list/desktop_sys_manager.dart';
import 'package:flutter_text/splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:self_utils/init.dart';
import 'package:flutter_shortcuts/flutter_shortcuts.dart';
import 'package:window_manager/window_manager.dart';

import 'init.dart';
import 'index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SecurityKeyboardCenter.register();
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((value) async {
      // await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
      await windowManager.setSize(const Size(1250, 800));
      await windowManager.setTitle('flutter学习组件');
      await windowManager.setMinimumSize(const Size(1250, 800));
      await windowManager.center();
      await windowManager.show();
    });
  }
  SecurityKeyboardCenter.register();
  runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = _errorHandler;
    runApp(ProviderScope(child: Assembly()));
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
  bool? todayShowAd;

  List<ShortCutsModel> list = <ShortCutsModel>[
    ShortCutsModel(
      shortcutItem: const ShortcutItem(
        id: '1',
        action: 'charts',
        shortLabel: 'charts',
        icon: 'images/sun.jpg',
      ),
      callBackFunc: () async {
        final NavigatorState navigatorHelper =
            await NavigatorHelper.navigatorState;
        navigatorHelper.push(
          MaterialPageRoute<void>(
              builder: (BuildContext context) => ListGroupPage()),
        );
      },
    )
  ];

  @override
  void initState() {
    Future<void>.delayed(Duration.zero, () async {
      if (Platform.isAndroid == true) {
        ShortCutsInit(shortCutList: list);
      }
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
    final bool? splashShow = LocateStorage.getBoolWithExpire('SplashShow');
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
              child: DesktopSysManager(
                child: GetMaterialApp(
                  builder: BotToastInit(),
                  showPerformanceOverlay: GlobalStore.isShowOverlay,
                  title: 'Flutter Study',
                  navigatorObservers: <NavigatorObserver>[
                    BotToastNavigatorObserver()
                  ],
                  routes: {
                    'home': (BuildContext context) => MainIndexPage(),
                  },
                  home: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        GlobalStore.isShowOverlay = !GlobalStore.isShowOverlay;
                      });
                      // FlutterDoraemonkit.toggle();
                    },
                    child: todayShowAd != null
                        ? (todayShowAd == true ? MainIndexPage() : SplashPage())
                        : Container(
                            color: Colors.white,
                          ),
                  ),
                ),
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
  LocalLog.setLog(
      '${LogLevel.ERROR.toString()} -- ${DateTime.now().toString()} -- ${details.exception}');

  if (ReportError().isInDebugMode) {
    FlutterError.dumpErrorToConsole(details);
  } else {
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  }

  if (details.exception != null) {
    if (details.exception is ApiException) {
      final ApiException e = details.exception as ApiException;
      final int code = e.code;
      final String? message = e.message;
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
          ToastUtils.showToast(msg: message ?? '');
          break;
      }
    } else if (details.exception is SocketException) {
      ToastUtils.showToast(msg: '网络不可用');
    } else if (details.exception is TimeoutException) {
      ToastUtils.showToast(
          msg: (details.exception as TimeoutException).message ?? '');
    }
  }
}
