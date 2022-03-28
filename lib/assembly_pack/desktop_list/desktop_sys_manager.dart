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

class _DesktopSysManagerState extends State<DesktopSysManager> with TrayListener {
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
      MenuItem(title: '语文'),
      MenuItem(title: '数学', toolTip: '躲不掉的'),
      MenuItem(title: '英语', isEnabled: false),
      MenuItem.separator,
      MenuItem(
        key: 'science',
        title: '理科',
        items: [
          MenuItem(title: '物理'),
          MenuItem(title: '化学'),
          MenuItem(title: '生物'),
        ],
      ),
      MenuItem.separator,
      MenuItem(
        key: 'arts',
        title: '文科',
        items: [
          MenuItem(title: '政治'),
          MenuItem(title: '历史'),
          MenuItem(title: '地理'),
        ],
      ),
    ];
    await _trayManager.setContextMenu(items);
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
    ToastUtils.showToast(msg: '你选择了${menuItem.title}');
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
