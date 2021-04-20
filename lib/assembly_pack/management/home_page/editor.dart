import 'package:flutter/material.dart';
import 'package:flutter_text/widget/management/common/listenable.dart';
import 'package:flutter_text/widget/management/common/view_key.dart';
import 'package:flutter_text/widget/management/widget/stack_view.dart';



abstract class EditorListener {
  void onOpen(
      {@required ViewKey key,
        @required String tab,
        @required WidgetBuilder contentIfAbsent,
        VoidCallback onTapTab});

  void onClose(ViewKey key);
}

class EditorController with GenericListenable<EditorListener> {
  void open(
      {@required ViewKey key,
        @required String tab,
        @required WidgetBuilder contentIfAbsent,
        VoidCallback onTapTab}) {
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
}

class Editor extends StatefulWidget {
  final EditorController controller;

  const Editor({Key key, this.controller}) : super(key: key);

  @override
  _EditorState createState() => _EditorState();
}

class _TabPage {
  final String tab;
  final WidgetBuilder builder;
  final ViewKey key;
  final VoidCallback onTapTab;

  _TabPage(
      {@required this.tab,
        @required this.builder,
        @required this.key,
        this.onTapTab});
}

class _EditorState extends State<Editor> implements EditorListener {
  final StackController controller = StackController();
  List<_TabPage> _tabs = <_TabPage>[];
  _TabPage current;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(this);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(this);
  }

  @override
  void didUpdateWidget(covariant Editor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(this);
      widget.controller?.addListener(this);
    }
  }

  @override
  void onClose(ViewKey key) {
    _close(key);
  }

  @override
  void onOpen(
      {@required ViewKey key,
        @required String tab,
        @required WidgetBuilder contentIfAbsent,
        VoidCallback onTapTab}) {
    _open(
        key: key,
        tab: tab,
        contentIfAbsent: contentIfAbsent,
        onTapTab: onTapTab);
  }

  void _open(
      {@required ViewKey key,
        @required String tab,
        @required WidgetBuilder contentIfAbsent,
        VoidCallback onTapTab}) {
    if (_tabs.any((element) => element.key == key)) {
      if (current.key != key) {
        controller.open(key, contentIfAbsent);
      }
    } else {
      _tabs.add(_TabPage(
          tab: tab, builder: contentIfAbsent, key: key, onTapTab: onTapTab));
      controller.open(key, contentIfAbsent);
    }
    setState(() {});
  }

  void _close(ViewKey key) {
    int index = _tabs.indexWhere((element) => element.key == key);
    if (index == -1) {
      return;
    }
    controller.close(key);
    _tabs.removeAt(index);
    setState(() {});
  }

  void _onCurrentIndexChanged(ViewKey key) {
    if (key == null) {
      current = null;
    } else {
      current =
          _tabs.firstWhere((element) => element.key == key, orElse: () => null);
      assert(current != null);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(top: 12),
      child: Column(
        children: [
          if (_tabs.isNotEmpty)
            Container(
              padding: EdgeInsets.only(left: 8,bottom: 4),
              alignment: Alignment.topLeft,
              child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  children: _tabs.map((e) => _buildButton(e)).toList()),
            ),
          if (_tabs.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Divider(
                height: 2,
                thickness: 5,
              ),
            ),
          Expanded(
              child: StackView(
                controller: controller,
                onCurrentIndexChanged: _onCurrentIndexChanged,
              ))
        ],
      ),
    );
  }

  Widget _buildButton(_TabPage page) {
    return Container(
      key: ValueKey(page),
      child: ElevatedButton(
          style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: MaterialStateProperty.all(
                  current == page ? Colors.blueAccent : Colors.grey)),
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
                    icon: Icon(
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
