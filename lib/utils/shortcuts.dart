import 'package:flutter_shortcuts/flutter_shortcuts.dart';
import 'package:flutter_text/assembly_pack/other_charts/list_group.dart';
import 'package:flutter_text/init.dart';
import 'package:flutter_text/utils/toast_utils.dart';

class ShortCutsInit {
  static ShortCutsInit _init;

  static final FlutterShortcuts _flutterShortcuts = FlutterShortcuts();

  factory ShortCutsInit() => _init ?? ShortCutsInit.init();

  ShortCutsInit.init() {
    _flutterShortcuts.initialize(debug: true);
    _flutterShortcuts.listenAction((String key) {
      _getShortcuts(key);
    });
    _init = this;
    _setShortcuts();
  }

  //处理shortcuts
  static void _getShortcuts(String key) async {
    ToastUtils.showToast(msg: '正在前往$key...');
    await Future<void>.delayed(const Duration(seconds: 3));
    switch (key) {
      case 'charts':
        final NavigatorState navigatorHelper =
            await NavigatorHelper.navigatorState;
        navigatorHelper.push(
          MaterialPageRoute(
              builder: (BuildContext context) => ListGroupPage()),
        );
      break;
    }
  }

  //设置shortcuts
  static void _setShortcuts() {
    _flutterShortcuts.setShortcutItems(shortcutItems: <FlutterShortcutItem>[
      const FlutterShortcutItem(
        id: '1',
        action: 'charts',
        shortLabel: 'charts',
      ),
    ]);
  }
}