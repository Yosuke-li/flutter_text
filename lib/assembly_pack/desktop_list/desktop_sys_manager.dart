import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/utils/toast_utils.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

/// 系统托盘
class DesktopSysManager extends StatefulWidget {
  Widget child;

  DesktopSysManager({Key key, this.child}) : super(key: key);

  @override
  _DesktopSysManagerState createState() => _DesktopSysManagerState();
}

class _DesktopSysManagerState extends State<DesktopSysManager>
    with TrayListener {
  final TrayManager _trayManager = TrayManager.instance;

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
    List<MenuItem> items = [
      MenuItem(label: '语文'),
      MenuItem(label: '数学', toolTip: '躲不掉的'),
      MenuItem(label: '英语', disabled: false),
      MenuItem.separator(),
      MenuItem(
        key: 'science',
        label: '理科',
        type: 'submenu',
        submenu: Menu(items: <MenuItem>[
          MenuItem(label: '物理'),
          MenuItem(label: '化学'),
          MenuItem(label: '生物'),
        ]),
      ),
      MenuItem.separator(),
      MenuItem(
        key: 'arts',
        label: '文科',
        type: 'submenu',
        submenu: Menu(items: <MenuItem>[
          MenuItem(label: '物理'),
          MenuItem(label: '化学'),
          MenuItem(label: '生物'),
        ]),
      ),
    ];
    await _trayManager.setContextMenu(Menu(items: items));
  }

  @override
  void onTrayIconMouseDown() async {
    await windowManager.show();
    Log.info('鼠标左键点击');
  }

  @override
  void onTrayIconRightMouseDown() async {
    await _trayManager.popUpContextMenu();
    Log.info('鼠标右键点击');
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
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
