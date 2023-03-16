import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/management/home_page/tool.dart';
import 'package:flutter_text/assembly_pack/management/utils/navigator.dart';
import 'package:flutter_text/init.dart';

import 'editor.dart';

class ManagementPage extends StatefulWidget {
  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  final EditorController editorController = EditorController();

  @override
  void initState() {
    super.initState();
    WindowsNavigator.init(editorController);
    PostgresUser.init();
    Request.init();
    FileUtils();
    Log.init(isDebug: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Tool(
            controller: editorController,
          ),
          Expanded(
            child: Editor(
              controller: editorController,
            ),
          )
        ],
      ),
    );
  }
}
