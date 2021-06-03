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
    loadData();
    super.onReady();
  }

  void loadData() async {
    rootBundle.loadString('assets/data/car_models.json').then((String value) {
      final List<String> list = [];
      json.decode(value).forEach((v) {
        list.add(v['name'] as String);
      });
      state.servers = list;
      state.select.value = ArrayHelper.get(state.servers, 100);
    });
  }
}
