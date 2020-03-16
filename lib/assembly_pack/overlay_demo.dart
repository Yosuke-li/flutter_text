import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/widget/float_box.dart';

void main() => runApp(overlayDemo());

class overlayDemo extends StatefulWidget {
  overlayDemoState createState() => overlayDemoState();
}

class overlayDemoState extends State<overlayDemo> {
  static OverlayEntry entry;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("开启悬浮按钮"),
            onPressed: () {
              entry?.remove();
              entry = null;
              entry = OverlayEntry(builder: (context) {
                return FloatBox();
              });
              Overlay.of(context).insert(entry);
            },
          ),
          RaisedButton(
            child: Text("关闭悬浮按钮"),
            onPressed: () {
              entry?.remove();
            },
          )
        ],
      ),
    );
  }
}