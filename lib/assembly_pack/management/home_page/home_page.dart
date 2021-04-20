import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/management/home_page/tool.dart';

import 'editor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EditorController editorController = EditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('展览宝后台管理'),
      ),
      body: Row(
        children: [
          Tool(
            controller: editorController,
          ),
          Expanded(
              child: Editor(
            controller: editorController,
          ))
        ],
      ),
    );
  }
}
