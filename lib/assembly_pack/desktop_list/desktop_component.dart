import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/desktop_list/desktop_drop_text.dart';
import 'package:flutter_text/assembly_pack/desktop_list/desktop_notifier.dart';
import 'package:flutter_text/assembly_pack/desktop_list/desktop_picker.dart';
import 'package:flutter_text/assembly_pack/desktop_list/download.dart';
import 'package:flutter_text/assembly_pack/management/utils/navigator.dart';
import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/model/AComponent.dart';
import 'package:self_utils/utils/array_helper.dart';

import '../rich_text/rich_test.dart';
import 'desktop_sys_manager.dart';
import 'keyborard_listener.dart';

class DesktopComponentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DesktopComponentPageState();
}

class DesktopComponentPageState extends State<DesktopComponentPage> {
  List<PageModel> _page = [];

  @override
  void initState() {
    super.initState();
    _page = [
      PageModel()
        ..name = 'desktop_drop_text'
        ..pageUrl = const DesktopDropText(),
      PageModel()
        ..name = 'desktop_notifier_text'
        ..pageUrl = const DesktopNotifierPage(),
      PageModel()
        ..name = 'desktop_picker_text'
        ..pageUrl = const DesktopPickerPage(),
      PageModel()
        ..name = 'download'
        ..pageUrl = const DownLoadPage(),
      PageModel()
        ..name = 'KeyBoardListenerPage'
        ..pageUrl = const KeyBoardListenerPage(),
      // PageModel()
      //   ..name = 'RichTestPage'
      //   ..pageUrl = const RichTestPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalStore.isMobile ? AppBar(
        title: const Text('Desktop_list'),
      ) : null,
      body: Center(
        child: GridView.custom(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          childrenDelegate: SliverChildBuilderDelegate((context, index) {
            return GestureDetector(
              onTap: () {
                WindowsNavigator().pushWidget(
                  context,
                  ArrayHelper.get(_page, index)?.pageUrl,
                  title: ArrayHelper.get(_page, index)?.name,
                );
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 1)),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('${ArrayHelper.get(_page, index)?.name}'),
              ),
            );
          }, childCount: _page.length),
        ),
      ),
    );
  }
}
