import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/init.dart';
import 'package:self_utils/utils/navigator.dart';
import 'package:self_utils/utils/toast_utils.dart';
import 'package:flutter_text/widget/chat/helper/user/user.dart';
import 'package:flutter_text/widget/chat/helper/user/user_db.dart';
import 'package:get/get.dart';

import 'state.dart';

class UserLoginLogic extends GetxController {
  final state = UserLoginState();

  void onLogin() async {
    final FormState? from = state.formKey.currentState;
    if (from!= null && from.validate()) {
      from.save();
      final User user = User()
        ..id = int.tryParse(state.idController.text)!
        ..name = state.nameController.text;
      final User? result = await PostgresUser.checkUser(user);
      if (result != null) {
        GlobalStore.user = result;
        LocateStorage.setString('user', jsonEncode(result));
        ToastUtils.showToast(msg: '登陆成功');
        NavigatorUtils.pop(Get.context!, results: true);
      } else {
        ToastUtils.showToast(msg: '请输入正确的id和名称');
      }
    }
  }
}
