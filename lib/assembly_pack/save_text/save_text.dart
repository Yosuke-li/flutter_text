import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text/widget/double_tap_collect.dart';

void main() => runApp(TextT());

class TextT extends StatefulWidget {
  TextState createState() => TextState();
}

class TextState extends State<TextT> {
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return TikTokVideoGesture(
      onAddFavorite: () {},
      child: Scaffold(
        appBar: AppBar(
          title: Text("text"),
        ),
        body: Center(
          child: Text('你好'),
        ),
      ),
    );
  }
}
