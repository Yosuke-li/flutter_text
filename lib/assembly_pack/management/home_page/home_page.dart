import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/management/home_page/tool.dart';
import 'package:flutter_text/assembly_pack/management/utils/navigator.dart';
import 'package:flutter_text/init.dart';
import 'package:flutter_text/widget/chat/helper/user/user.dart';

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
    PostgresUser.init().then((value) => _checkUser());
    Request.init();
    FileUtils();
    Log.init(isDebug: true);
  }

  void _checkUser() async {
    try {
      final String? res = LocateStorage.getString('user');
      if (res != null) {
        User user = User.fromJson(jsonDecode(res));
        final User? result = await PostgresUser.checkUser(user);
        if (result != null) {
          GlobalStore.user = user;
          ToastUtils.showToast(msg: '自动登录MQTT成功');
          setState(() {});
        }
      }
    } catch (err) {
      rethrow;
    }
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
