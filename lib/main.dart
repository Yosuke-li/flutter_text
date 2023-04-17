// import 'package:flutter_doraemonkit/flutter_doraemonkit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_text/assembly_pack/desktop_list/desktop_sys_manager.dart';
import 'package:flutter_text/splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:self_utils/init.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:self_utils/utils/shortcuts/quick_actions_method.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'init.dart';
import 'index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SecurityKeyboardCenter.register();
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((value) async {
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
      await windowManager.setSize(const Size(1080, 700));
      await windowManager.setTitle('flutter学习组件');
      await windowManager.setMinimumSize(const Size(1080, 700));
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
        type: 'charts',
        localizedTitle: 'charts',
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
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      GlobalStore.isMobile = false;
      setState(() {});
    }
    Future<void>.delayed(Duration.zero, () async {
      ShortCutsQuick(shortCutsAction: list);
      await init();
    });
    super.initState();
  }

  Future<void> init() async {
    await LocateStorage.init().whenComplete(
      () => getTodayShow(),
    );
    _listenTheme();
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

  void _listenTheme() {
    EventBusHelper.listen<EventBusM>((EventBusM event) {
      if (event.theme != '') {
        setState(() {});
      }
    });
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
                  title: 'Flutter study',
                  theme: GlobalStore.theme == 'light'
                      ? ThemeData.light()
                      : ThemeData.dark(),
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: const <
                      LocalizationsDelegate<dynamic>>[
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  locale: GlobalStore.locale,
                  supportedLocales: S.delegate.supportedLocales,
                  navigatorObservers: <NavigatorObserver>[
                    BotToastNavigatorObserver()
                  ],
                  routes: {
                    'home': (BuildContext context) => MainIndexPage(),
                  },
                  home: GestureDetector(
                    onLongPress: () {
                      // setState(() {
                      //   GlobalStore.isShowOverlay = !GlobalStore.isShowOverlay;
                      // });
                      // FlutterDoraemonkit.toggle();
                    },
                    child: todayShowAd != null
                        ? (todayShowAd == true
                            ? GlobalStore.isShowGary
                                ? ColorFiltered(
                                    colorFilter: GlobalStore.greyScale,
                                    child: GlobalStore.isMobile
                                        ? MainIndexPage()
                                        : ManagementPage(),
                                  )
                                : GlobalStore.isMobile
                                    ? MainIndexPage()
                                    : ManagementPage()
                            : SplashPage())
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
