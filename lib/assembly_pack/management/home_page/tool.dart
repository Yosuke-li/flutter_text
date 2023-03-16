import 'package:flutter_text/assembly_pack/management/function_page/windows_main_page.dart';
import 'package:flutter_text/index.dart';
import 'package:flutter_text/init.dart';
import 'package:self_utils/widget/management/common/view_key.dart';
import 'package:self_utils/widget/management/widget/custom_expansion_tile.dart';
import 'dart:math' as math;

import 'editor.dart';

class ContViewKey {
  static const ViewKey mainPage =
      ViewKey(namespace: 'mainPage', id: 'mainPage');
  static const ViewKey media = ViewKey(namespace: 'media', id: 'media');
  static const ViewKey search = ViewKey(namespace: 'search', id: 'search');
}

enum ToolType {
  hide,
  normal,
  small,
}

class Tool extends StatefulWidget {
  final EditorController controller;

  const Tool({Key? key, required this.controller}) : super(key: key);

  @override
  _ToolState createState() => _ToolState();
}

class _GroupItem {
  ViewKey? key;
  final Widget icon;
  final String title;
  final VoidCallback callback;

  _GroupItem(ViewKey key,
      {required this.title, required this.callback, required this.icon});
}

class _ToolState extends State<Tool> implements EditorListener {
  final Map<String, bool> expanded = <String, bool>{};
  final List<void> mediaList = [];
  ToolType type = ToolType.small;

  void _mainPage() {
    widget.controller.tabs.clear();
    widget.controller.open(
        key: ContViewKey.mainPage,
        tab: '主页',
        contentIfAbsent: (_) => const WindowsMainPage());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _mainPage();
    });
    widget.controller.addListener(this);
  }

  @override
  void didUpdateWidget(covariant Tool oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(this);
      widget.controller.addListener(this);
    }
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: type == ToolType.normal
          ? 200
          : type == ToolType.small
          ? 70
          : 0,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: buildToolGroup(
                      key: ContViewKey.mainPage,
                      groupName: '主页',
                      icon: Icon(
                        Icons.home,
                        size: 25,
                        color:
                            widget.controller.current?.key == ContViewKey.mainPage
                                ? Colors.red
                                : Colors.black,
                      ),
                      callback: () {
                        _mainPage();
                      },
                    ),
                  ),
                  Column(
                    children: page4.map(
                      (e) {
                        return Material(
                          type: MaterialType.transparency,
                          child: buildToolGroup(
                            key: ViewKey(
                                namespace: e.hashCode.toString(),
                                id: e.hashCode.toString()),
                            groupName: e.title,
                            icon: Icon(
                              e.icon.icon,
                              size: 25,
                              color: widget.controller.current?.key ==
                                      ViewKey(
                                          namespace: e.hashCode.toString(),
                                          id: e.hashCode.toString())
                                  ? Colors.red
                                  : Colors.black,
                            ),
                            callback: () {
                              if (e.route != null) {
                                widget.controller.open(
                                    key: ViewKey(
                                        namespace: e.hashCode.toString(),
                                        id: e.hashCode.toString()),
                                    tab: e.title,
                                    contentIfAbsent: (_) => e.route!);
                              }
                            },
                          ),
                        );
                      },
                    ).toList(),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (type == ToolType.normal) {
                  type = ToolType.small;
                } else if (type == ToolType.small) {
                  type = ToolType.normal;
                }
                setState(() {});
              },
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(left: 24),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.settings),
                    if (type == ToolType.normal) const Text(' 设置'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildToolGroup(
      {required ViewKey key,
      required String groupName,
      List<_GroupItem>? groupItems,
      VoidCallback? callback,
      VoidCallback? longPressCallBack,
      Widget? icon}) {
    ViewKey? lastKey;
    for (int i = 0; i < widget.controller.tabs.length; i++) {
      final String title = widget.controller.tabs[i].tab;
      if (page4.any((val) => val.title == title)) {
        lastKey = widget.controller.tabs[i].key;
      }
    }
    return CustomExpansionTile(
      value: expanded[groupName] == true,
      customHead: (_, animation) => InkWell(
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Container(
                width: 4,
                color: lastKey == key
                    ? Colors.red
                    : const Color(0x00000000),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 20, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    icon ??
                        Transform.rotate(
                          angle: math.pi * (1.5 + animation.value / 2),
                          child: const Icon(
                            Icons.expand_more,
                            size: 16,
                          ),
                        ),
                    if (groupName.isNotEmpty && type == ToolType.normal)
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          groupName,
                          style: TextStyle(
                            color: lastKey == key
                                ? Colors.red
                                : const Color(0xff000000),
                          ),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
        onLongPress: () {
          longPressCallBack?.call();
        },
        onTap: () {
          if (callback != null) {
            callback.call();
          } else {
            if (expanded[groupName] == null) {
              expanded[groupName] = true;
            } else {
              expanded[groupName] = !expanded[groupName]!;
            }
          }
          setState(() {});
        },
      ),
      children: groupItems
              ?.map(
                (e) => InkWell(
                  onTap: e.callback,
                  child: Container(
                    padding: const EdgeInsets.all(8.0).copyWith(left: 32),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          color: lastKey == e.key
                              ? const Color(0xff50A250)
                              : const Color(0x00000000),
                        ),
                        e.icon,
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          e.title,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(growable: false) ??
          [],
    );
  }

  @override
  void onClose(ViewKey key) {
    setState(() {});
  }

  @override
  void onOpen(
      {required ViewKey key,
      required String tab,
      required WidgetBuilder contentIfAbsent,
      VoidCallback? onTapTab}) {
    setState(() {});
  }
}
