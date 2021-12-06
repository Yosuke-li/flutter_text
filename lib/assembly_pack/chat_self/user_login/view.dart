import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/chat_self/user_register/view.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/utils/screen.dart';
import 'package:flutter_text/widget/keyboard/security_keyboard.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final UserLoginLogic logic = Get.put(UserLoginLogic());
  final UserLoginState state = Get.find<UserLoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登陆'),
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: const Text('注册'),
                onTap: () {
                  Get.to(() => UserRegisterPage());
                },
              ),
            ),
          )
        ],
      ),
      body: Form(
        key: state.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  keyboardType: TextInputType.number,
                  controller: state.idController,
                  decoration: const InputDecoration(helperText: '请输入id'),
                  onSubmitted: (String value) {
                    state.idController.text = value;
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  controller: state.nameController,
                  decoration: const InputDecoration(helperText: '请输入名字'),
                  onSubmitted: (String value) {
                    state.nameController.text = value;
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: const Text(
                        '登陆',
                      ),
                      onPressed: () {
                        logic.onLogin();
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<UserLoginLogic>();
    super.dispose();
  }
}
