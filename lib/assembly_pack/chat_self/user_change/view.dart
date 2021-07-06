import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class UserChangePage extends StatefulWidget {
  @override
  _UserChangePageState createState() => _UserChangePageState();
}

class _UserChangePageState extends State<UserChangePage> {
  final UserChangeLogic logic = Get.put(UserChangeLogic());
  final UserChangeState state = Get.find<UserChangeLogic>().state;

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('修改信息'),
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
                    decoration: const InputDecoration(helperText: '请输入新的名字'),
                    onSubmitted: (String value) {
                      state.nameController.text = value;
                    }),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                    controller: state.imageController,
                    decoration: const InputDecoration(helperText: '上传新的网络头像'),
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
                          '修改信息',
                        ),
                        onPressed: () {
                          logic.onUpdate();
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
    Get.delete<UserChangeLogic>();
    super.dispose();
  }
}