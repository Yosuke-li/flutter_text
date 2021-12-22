import 'package:flutter/material.dart';
import 'package:flutter_text/widget/popup_widget.dart';

class PopupTextPage extends StatefulWidget {
  @override
  _PopupTextState createState() => _PopupTextState();
}

class _PopupTextState extends State<PopupTextPage> {
  final Key _textKey = GlobalKey<_PopupTextState>();
  final Key _textKey2 = GlobalKey<_PopupTextState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('popup_text'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.only(right: 20, left: 20),
            child: GestureDetector(
              key: _textKey,
              onTap: () {
                PopupToastWindow.showPopWindow(
                  context,
                  '啊，被点了',
                  _textKey,
                  spaceMargin: 0,
                );
              },
              child: const Text('点击下'),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(right: 20, left: 20),
            child: GestureDetector(
              key: _textKey2,
              onTap: () {
                PopupToastWindow.showPopWindow(
                  context,
                  '啊，被点了2',
                  _textKey2,
                  spaceMargin: 0,
                );
              },
              child: const Text('点击下2'),
            ),
          ),
        ],
      ),
    );
  }
}
