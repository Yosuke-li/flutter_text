import 'package:flutter/material.dart';
import 'package:self_utils/widget/management/common/listenable.dart';
import 'package:self_utils/widget/management/common/view_key.dart';
import 'package:self_utils/widget/management/widget/stack_view.dart';

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
    current == null;
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
    if (widget.controller.tabs.any((element) => element.key == key)) {
      if (widget.controller.current?.key != key) {
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
    int index = widget.controller.tabs.indexWhere((element) => element.key == key);
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
      widget.controller.current = widget.controller.tabs.firstWhere((element) => element.key == key);
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
          //     padding: const EdgeInsets.only(left: 8, bottom: 4),
          //     alignment: Alignment.topLeft,
          //     child: Wrap(
          //         alignment: WrapAlignment.start,
          //         spacing: 8,
          //         children: widget.controller.tabs.map((e) => _buildButton(e)).toList()),
          //   ),
          // if (widget.controller.tabs.isNotEmpty)
          //   const Padding(
          //     padding: EdgeInsets.only(top: 6),
          //     child: Divider(
          //       height: 2,
          //       thickness: 5,
          //     ),
          //   ),
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
      key: ValueKey(page),
      child: ElevatedButton(
          style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: MaterialStateProperty.all(
                  widget.controller.current == page ? Colors.blueAccent : Colors.grey)),
          onPressed: () {
            _open(
                key: page.key,
                tab: page.tab,
                contentIfAbsent: page.builder,
                onTapTab: page.onTapTab);
            page.onTapTab?.call();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
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
