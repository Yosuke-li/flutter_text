import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class UserRegisterPage extends StatefulWidget {
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final UserRegisterLogic logic = Get.put(UserRegisterLogic());
  final UserRegisterState state = Get.find<UserRegisterLogic>().state;

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('注册'),
        ),
        body: Form(
          key: state.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                    controller: state.nameController,
                    decoration: const InputDecoration(helperText: '请输入名字'),
                    onSubmitted: (String value) {
                      state.nameController.text = value;
                    }),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                    controller: state.imageController,
                    decoration: const InputDecoration(helperText: '上传网络头像'),
                    onSubmitted: (String value) {
                      state.imageController.text = value;
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
                          '注册',
                        ),
                        onPressed: () {
                          logic.onRegister();
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
    Get.delete<UserRegisterLogic>();
    super.dispose();
  }
}