import 'package:flutter/material.dart';
import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/utils/toast_utils.dart';
import 'package:flutter_text/widget/api_call_back.dart';
import 'package:flutter_text/widget/chat/helper/user/user.dart';
import 'package:flutter_text/widget/chat/helper/user/user_cache.dart';
import 'package:flutter_text/widget/chat/helper/user/user_db.dart';
import 'package:get/get.dart';

import 'state.dart';

class UserChangeLogic extends GetxController {
  final UserChangeState state = UserChangeState();

  @override
  void onReady() {
    super.onReady();
    state.nameController.text = GlobalStore.user?.name??'';
    state.imageController.text = GlobalStore.user?.image??'';
  }

  void onUpdate() async {
    final FormState? from = state.formKey.currentState;
    if (from != null && from.validate()) {
      from.save();
      final User? user = GlobalStore.user;
      user?.name = state.nameController.text;
      user?.image = state.imageController.text;

      try {
        await loadingCallback(() => PostgresUser.updateUser(user!));
        GlobalStore.user = user;
        await UserCache().deleteCache(user!.id!);
        await UserCache().setCache(user);
        ToastUtils.showToast(msg: '更新成功');
        NavigatorUtils.pop(Get.context!);
      } catch (error, stack) {
        Log.error(error, stackTrace: stack);
        rethrow;
      }
    }
  }
}
