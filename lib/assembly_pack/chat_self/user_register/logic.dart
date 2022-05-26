import 'package:flutter/material.dart';
import 'package:flutter_text/utils/datetime_utils.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/utils/toast_utils.dart';
import 'package:flutter_text/widget/chat/helper/user/user.dart';
import 'package:flutter_text/widget/chat/helper/user/user_db.dart';
import 'package:get/get.dart';

import 'state.dart';

class UserRegisterLogic extends GetxController {
  final state = UserRegisterState();

  void onRegister() async {
    final FormState? from = state.formKey.currentState;
    if (from !=null && from.validate()) {
      from.save();
      final int id = await PostgresUser.getMapList();
      final User user = User()
        ..id = id + 1
        ..image = state.imageController.text
        ..name = state.nameController.text
        ..createTime = DateTimeHelper.getLocalTimeStamp() ~/ 1000
        ..updateTime = DateTimeHelper.getLocalTimeStamp() ~/ 1000;

      try {
        await PostgresUser.addUser(user);
        ToastUtils.showToast(msg: '注册成功，正在跳转中');
        int i = 2;
        Navigator.popUntil(Get.context!, (_) => i-- == 0);
      } catch (error, stack) {
        Log.error(error, stackTrace: stack);
        rethrow;
      }
    }
  }
}
