import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/layout_teach/material/action/m_float_button.dart';
import 'package:flutter_text/assembly_pack/layout_teach/material/action/m_icon_button.dart';
import 'package:flutter_text/assembly_pack/layout_teach/material/communication/badge.dart';
import 'package:flutter_text/assembly_pack/layout_teach/material/nagivator/m_appBar.dart';
import 'package:flutter_text/assembly_pack/management/utils/navigator.dart';
import 'package:flutter_text/model/AComponent.dart';
import 'package:self_utils/init.dart';

import 'action/m_common_button.dart';
import 'action/m_segment_button.dart';
import 'communication/m_progress.dart';
import 'communication/m_snackbar.dart';
import 'containment/m_alertdialog.dart';
import 'containment/m_card.dart';
import 'containment/m_divider.dart';
import 'containment/m_listtile.dart';
import 'inputs/m_textInputs.dart';
import 'nagivator/m_bottom_bar.dart';
import 'nagivator/m_nagivator_bar.dart';
import 'nagivator/m_navigation_drawer.dart';
import 'nagivator/m_navigation_rail.dart';
import 'nagivator/m_tab_bar.dart';
import 'selection/m_date_picker.dart';
import 'selection/m_menu.dart';
import 'selection/m_switch.dart';
import 'selection/m_timer_picker.dart';

class MaterialThreeMain extends StatefulWidget {
  const MaterialThreeMain({super.key});

  @override
  State<MaterialThreeMain> createState() => _MaterialThreeMainState();
}

class _MaterialThreeMainState extends State<MaterialThreeMain> {
  List<PageModel> _page = [];
  List<PageModel> _page2 = [];
  List<PageModel> _page3 = [];
  List<PageModel> _page4 = [];
  List<PageModel> _page5 = [];
  List<PageModel> _page6 = [];

  @override
  void initState() {
    super.initState();
    _page = [
      PageModel()
        ..name = 'Common Button'
        ..desc = '普通常见的点击按钮'
        ..pageUrl = const MCommonButton(),
      PageModel()
        ..name = 'Float Action Button'
        ..desc = 'Flutter里FloatingActioningButton'
        ..pageUrl = const MFloatButton(),
      PageModel()
        ..name = 'Icon Button'
        ..desc = 'Material3版本下的icon Button'
        ..pageUrl = const MIconButton(),
      PageModel()
        ..name = 'Segmented Button'
        ..desc = '单选多选选择器'
        ..pageUrl = const MSegmentedButton(),
    ];
    _page2 = [
      PageModel()
        ..name = 'Badge'
        ..desc = '消息红点组件'
        ..pageUrl = const MBadge(),
      PageModel()
        ..name = 'linearProgressIndicator'
        ..desc = '进度条'
        ..pageUrl = const MProgress(),
      PageModel()
        ..name = 'snackBar'
        ..desc = '底部拦弹框'
        ..pageUrl = const MSnackBar(),
    ];
    _page3 = [
      PageModel()
        ..name = 'AlertDialog'
        ..desc = '弹窗组件'
        ..pageUrl = const MAlertDialog(),
      PageModel()
        ..name = 'card'
        ..desc = '卡片视图'
        ..pageUrl = const MCard(),
      PageModel()
        ..name = 'divider'
        ..desc = '分割线'
        ..pageUrl = const MDivider(),
      PageModel()
        ..name = 'ListTile'
        ..desc = 'ListTile展示'
        ..pageUrl = const MListTile(),
    ];
    _page4 = [
      PageModel()
        ..name = 'AppBar'
        ..desc = 'Appbar展示'
        ..pageUrl = const MAppBar(),
      PageModel()
        ..name = 'BottomBar'
        ..desc = '底部bar拦展示'
        ..pageUrl = const MBottomBar(),
      PageModel()
        ..name = 'MNavigationBar'
        ..desc = '底部导航拦展示'
        ..pageUrl = const MNavigationBar(),
      PageModel()
        ..name = 'MNavigationDrawer'
        ..desc = '抽屉导航拦'
        ..pageUrl = const MNavigationDrawer(),
      PageModel()
        ..name = 'MNavigationRail'
        ..desc = '侧边导航拦'
        ..pageUrl = const MNavigationRail(),
      PageModel()
        ..name = 'MTabBar'
        ..desc = 'material3样式的tabbar'
        ..pageUrl = const MTabBar(),
    ];
    _page5 = [
      PageModel()
        ..name = 'MDatePicker'
        ..desc = 'material3样式的时间选择器'
        ..pageUrl = const MDatePicker(),
      PageModel()
        ..name = 'MSwitch'
        ..desc = 'material3样式的switch'
        ..pageUrl = const MSwitch(),
      PageModel()
        ..name = 'MMenuAnchor'
        ..desc = '菜单栏'
        ..pageUrl = const MMenuAnchor(),
      PageModel()
        ..name = 'MShowTimePicker'
        ..desc = '时间选择器--timer'
        ..pageUrl = const MShowTimePicker(),
    ];
    _page6 = [
      PageModel()
        ..name = 'MTextInput'
        ..desc = '表单样式'
        ..pageUrl = const MTextFieldExamples(),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            child: const Text(
              'Action',
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          GridView.custom(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                child: GestureDetector(
                  onTap: () {
                    WindowsNavigator().pushWidget(
                      context,
                      ArrayHelper.get(_page, index)?.pageUrl,
                      title: ArrayHelper.get(_page, index)?.name,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${ArrayHelper.get(_page, index)?.name}'),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('${ArrayHelper.get(_page, index)?.desc}'),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: _page.length),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            child: const Text(
              'Communication',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          GridView.custom(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                child: GestureDetector(
                  onTap: () {
                    WindowsNavigator().pushWidget(
                      context,
                      ArrayHelper.get(_page2, index)?.pageUrl,
                      title: ArrayHelper.get(_page2, index)?.name,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${ArrayHelper.get(_page2, index)?.name}'),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('${ArrayHelper.get(_page2, index)?.desc}'),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: _page2.length),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            child: const Text(
              'Containment',
              style: TextStyle(
                fontSize: 18,
                color: Colors.orange,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          GridView.custom(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                child: GestureDetector(
                  onTap: () {
                    WindowsNavigator().pushWidget(
                      context,
                      ArrayHelper.get(_page3, index)?.pageUrl,
                      title: ArrayHelper.get(_page3, index)?.name,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${ArrayHelper.get(_page3, index)?.name}'),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('${ArrayHelper.get(_page3, index)?.desc}'),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: _page3.length),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            child: const Text(
              'Navigator',
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          GridView.custom(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                child: GestureDetector(
                  onTap: () {
                    WindowsNavigator().pushWidget(
                      context,
                      ArrayHelper.get(_page4, index)?.pageUrl,
                      title: ArrayHelper.get(_page4, index)?.name,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${ArrayHelper.get(_page4, index)?.name}'),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('${ArrayHelper.get(_page4, index)?.desc}'),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: _page4.length),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            child: const Text(
              'Selection',
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          GridView.custom(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                child: GestureDetector(
                  onTap: () {
                    WindowsNavigator().pushWidget(
                      context,
                      ArrayHelper.get(_page5, index)?.pageUrl,
                      title: ArrayHelper.get(_page5, index)?.name,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${ArrayHelper.get(_page5, index)?.name}'),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('${ArrayHelper.get(_page5, index)?.desc}'),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: _page5.length),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            child: const Text(
              'Text input',
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          GridView.custom(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                child: GestureDetector(
                  onTap: () {
                    WindowsNavigator().pushWidget(
                      context,
                      ArrayHelper.get(_page6, index)?.pageUrl,
                      title: ArrayHelper.get(_page6, index)?.name,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${ArrayHelper.get(_page6, index)?.name}'),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('${ArrayHelper.get(_page6, index)?.desc}'),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: _page6.length),
          ),
        ],
      ),
    );
  }
}
