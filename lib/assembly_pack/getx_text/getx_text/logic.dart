import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:get/get.dart';

import 'state.dart';

class GetxTextLogic extends GetxController {
  final state = GetxTextState();

  void increase() => state.count++;

  @override
  void onReady() {
    // final Map<String, dynamic> map = Get.arguments;
    // state.count.value = map['count'];
    state.count.value = 100;
    loadData();
    super.onReady();
  }

  void loadData() async {
    rootBundle.loadString('assets/data/car_models.json').then((String value) {
      final List<RxString> list = [];
      json.decode(value).forEach((v) {
        list.add(RxString(v['name'] as String));
      });
      state.list.value = list;
      state.select.value = ArrayHelper.get(state.list.map((RxString element) => element.value).toList(), 100);
      state.list.refresh();
    });
  }
}
