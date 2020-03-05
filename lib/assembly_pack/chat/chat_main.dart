import 'package:flutter/material.dart';

void main() => runApp(chatPackApp());

class chatPackApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "聊天",
      home: chatScene(),
    );
  }
}

class chatScene extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("聊天"),
      ),
    );
  }
}
