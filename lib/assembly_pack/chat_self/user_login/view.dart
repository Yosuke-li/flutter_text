import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/chat_self/user_register/view.dart';
import 'package:flutter_text/global/global.dart';
import 'package:self_utils/utils/navigator.dart';
import 'package:self_utils/utils/screen.dart';
import 'package:self_utils/widget/keyboard/security_keyboard.dart';
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
      appBar: GlobalStore.isMobile ? AppBar(
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
      ) : null,
      body: Center(
        child: Form(
          key: state.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   child: Text('logo'),
              // ),
              Container(
                width: 500,
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
                width: 500,
                padding: const EdgeInsets.all(20),
                child: TextField(
                    controller: state.nameController,
                    decoration: const InputDecoration(helperText: '请输入名字'),
                    onSubmitted: (String value) {
                      state.nameController.text = value;
                    }),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            color: Theme.of(context).primaryColorDark,
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
                  ),
                  Container(
                    width: 250,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            color: Theme.of(context).primaryColorDark,
                            child: const Text(
                              '注册',
                            ),
                            onPressed: () {
                              Get.to(() => UserRegisterPage());
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
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
