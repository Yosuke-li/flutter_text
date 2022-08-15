import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/utils/toast_utils.dart';
import 'package:tray_manager/tray_manager.dart' as tray;
import 'package:window_manager/window_manager.dart' as win;

/// 系统托盘
class DesktopSysManager extends StatefulWidget {
  Widget child;

  DesktopSysManager({Key? key, required this.child}) : super(key: key);

  @override
  _DesktopSysManagerState createState() => _DesktopSysManagerState();
}

class _DesktopSysManagerState extends State<DesktopSysManager>
    with tray.TrayListener {
  final tray.TrayManager _trayManager = tray.TrayManager.instance;

  @override
  void initState() {
    super.initState();
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      _trayManager.addListener(this);
      _show();
    }
  }

  /// 系统托盘里显示图标
  void _show() async {
    await _trayManager.setIcon('images/favicon.ico');
    await _trayManager.setToolTip('flutter_text');
    _generateContextMenu();
  }

  /// 设置菜单项
  void _generateContextMenu() async {
    List<tray.MenuItem> items = [
      tray.MenuItem(label: '语文'),
      tray.MenuItem(label: '数学', toolTip: '躲不掉的'),
      tray.MenuItem(label: '英语', disabled: false),
      tray.MenuItem.separator(),
      tray.MenuItem(
        key: 'science',
        label: '理科',
        type: 'submenu',
        submenu: tray.Menu(items: <tray.MenuItem>[
          tray.MenuItem(label: '物理'),
          tray.MenuItem(label: '化学'),
          tray.MenuItem(label: '生物'),
        ]),
      ),
      tray.MenuItem.separator(),
      tray.MenuItem(
        key: 'arts',
        label: '文科',
        type: 'submenu',
        submenu: tray.Menu(items: <tray.MenuItem>[
          tray.MenuItem(label: '物理'),
          tray.MenuItem(label: '化学'),
          tray.MenuItem(label: '生物'),
        ]),
      ),
    ];
    await _trayManager.setContextMenu(tray.Menu(items: items));
  }

  @override
  void onTrayIconMouseDown() async {
    await win.windowManager.show();
    Log.info('鼠标左键点击');
  }

  @override
  void onTrayIconRightMouseDown() async {
    await _trayManager.popUpContextMenu();
    Log.info('鼠标右键点击');
  }

  @override
  void onTrayMenuItemClick(tray.MenuItem menuItem) {
    ToastUtils.showToast(msg: '你选择了${menuItem.label}');
  }

  @override
  void dispose() {
    if (mounted) {
      return;
    }
    _trayManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
