import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/chat_self/user_login/view.dart';
import 'package:flutter_text/assembly_pack/management/function_page/windows_search_page.dart';
import 'package:flutter_text/assembly_pack/paint/music_amplitude.dart';
import 'package:flutter_text/init.dart';
import 'package:self_utils/widget/management/common/listenable.dart';
import 'package:self_utils/widget/management/common/view_key.dart';
import 'package:self_utils/widget/management/widget/stack_view.dart';

import 'theme.dart';
import 'tool.dart';

abstract class EditorListener {
  void onOpen(
      {required ViewKey key,
      required String tab,
      required WidgetBuilder contentIfAbsent,
      VoidCallback? onTapTab});

  void onClose(ViewKey key);
}

class EditorController with GenericListenable<EditorListener> {
  void open(
      {required ViewKey key,
      required String tab,
      required WidgetBuilder contentIfAbsent,
      VoidCallback? onTapTab}) {
    foreach((entry) {
      entry.onOpen(
          key: key,
          contentIfAbsent: contentIfAbsent,
          tab: tab,
          onTapTab: onTapTab);
    });
  }

  void close(ViewKey key) {
    foreach((entry) {
      entry.onClose(key);
    });
  }

  List<TabPage> tabs = <TabPage>[];

  TabPage? current;

  void dispose() {
    current = null;
    tabs = <TabPage>[];
  }
}

class Editor extends StatefulWidget {
  final EditorController controller;

  const Editor({Key? key, required this.controller}) : super(key: key);

  @override
  _EditorState createState() => _EditorState();
}

class TabPage {
  final String tab;
  final WidgetBuilder builder;
  final ViewKey key;
  final VoidCallback? onTapTab;

  TabPage(
      {required this.tab,
      required this.builder,
      required this.key,
      this.onTapTab});
}

class _EditorState extends State<Editor> implements EditorListener {
  final StackController controller = StackController();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(this);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(this);
  }

  @override
  void didUpdateWidget(covariant Editor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(this);
      widget.controller.addListener(this);
    }
  }

  @override
  void onClose(ViewKey key) {
    _close(key);
  }

  @override
  void onOpen(
      {required ViewKey key,
      required String tab,
      required WidgetBuilder contentIfAbsent,
      VoidCallback? onTapTab}) {
    _open(
        key: key,
        tab: tab,
        contentIfAbsent: contentIfAbsent,
        onTapTab: onTapTab);
  }

  void _open(
      {required ViewKey key,
      required String tab,
      required WidgetBuilder contentIfAbsent,
      VoidCallback? onTapTab}) {
    if (widget.controller.tabs.any((TabPage element) => element.key == key)) {
      if (widget.controller.current?.key != key) {
        widget.controller.tabs
            .removeWhere((TabPage element) => element.key == key);
        widget.controller.tabs.add(TabPage(
            tab: tab, builder: contentIfAbsent, key: key, onTapTab: onTapTab));
        controller.open(key, contentIfAbsent);
      }
    } else {
      widget.controller.tabs.add(TabPage(
          tab: tab, builder: contentIfAbsent, key: key, onTapTab: onTapTab));
      controller.open(key, contentIfAbsent);
    }
    setState(() {});
  }

  void _close(ViewKey key) {
    int index =
        widget.controller.tabs.indexWhere((element) => element.key == key);
    if (index == -1) {
      return;
    }
    controller.close(key);
    widget.controller.tabs.removeAt(index);
    setState(() {});
  }

  void _onCurrentIndexChanged(ViewKey? key) {
    if (key == null) {
      widget.controller.current = null;
    } else {
      widget.controller.current =
          widget.controller.tabs.firstWhere((element) => element.key == key);
      assert(widget.controller.current != null);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          // if (widget.controller.tabs.isNotEmpty)
          //   Container(
          //     padding: const EdgeInsets.only(left: 3, top: 4),
          //     alignment: Alignment.topLeft,
          //     child: Wrap(
          //         alignment: WrapAlignment.start,
          //         spacing: 0,
          //         children: widget.controller.tabs.map((e) => _buildButton(e)).toList()),
          //   ),
          // if (widget.controller.tabs.isNotEmpty)
          //   const SizedBox(
          //     child: Divider(
          //       height: 1,
          //       thickness: 0,
          //     ),
          //   ),
          Container(
            height: 50,
            color: GlobalStore.theme == 'light'
                ? HomeTheme.lightBgColor
                : HomeTheme.darkBgColor,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: widget.controller.tabs.length > 1
                        ? Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Utils.debounce(() {
                                    final TabPage lastOne =
                                        widget.controller.tabs.last;
                                    widget.controller.close(lastOne.key);
                                  }, delay: const Duration(milliseconds: 180));
                                },
                                child: const Icon(
                                  Icons.chevron_left,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                child: Text(
                                    '${widget.controller.current?.tab ?? ''}'),
                              ),
                            ],
                          )
                        : null,
                  ),
                ),
                Visibility(
                  visible: widget.controller.current?.key != ContViewKey.search,
                  child: InkWell(
                    onTap: () {
                      widget.controller.open(
                          key: ContViewKey.search,
                          tab: '搜索',
                          contentIfAbsent: (_) => const WindowsSearchPage());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                right: 30, left: 30, top: 1, bottom: 1),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25.0)),
                              border:
                                  Border.all(color: GlobalStore.theme == 'light'
                                      ? HomeTheme.lightBorderLineColor
                                      : HomeTheme.darkBorderLineColor, width: 1.0),
                            ),
                            child: Text(
                              '搜索内部组件',
                              style: TextStyle(
                                  color: GlobalStore.theme == 'light'
                                      ? HomeTheme.lightBorderTxColor
                                      : HomeTheme.darkBorderTxColor, fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.search,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (GlobalStore.user != null) {
                    } else {
                      WindowsNavigator()
                          .pushWidget(context, UserLoginPage(), title: '登陆');
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: GlobalStore.user != null
                        ? Row(
                            children: [
                              Container(
                                width: 30,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      GlobalStore.user?.image ?? ''),
                                ),
                              ),
                            ],
                          )
                        : Container(
                            width: 30,
                            child: const Icon(Icons.person),
                          ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: StackView(
              controller: controller,
              onCurrentIndexChanged: _onCurrentIndexChanged,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButton(TabPage page) {
    return Container(
      margin: const EdgeInsets.only(left: 2),
      color: widget.controller.current == page
          ? Colors.grey[200]
          : const Color(0x0000000),
      key: ValueKey(page),
      child: InkWell(
          onTap: () {
            _open(
                key: page.key,
                tab: page.tab,
                contentIfAbsent: page.builder,
                onTapTab: page.onTapTab);
            page.onTapTab?.call();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(page.tab),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    iconSize: 14,
                    constraints: BoxConstraints(),
                    splashRadius: 16,
                    icon: const Icon(
                      Icons.close_sharp,
                    ),
                    onPressed: () {
                      _close(page.key);
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
