import 'dart:async';
import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/date_format.dart';
import 'package:flutter_text/utils/worker/worker.dart';
import 'package:get/get.dart';

import 'state.dart';


class worker implements IWorker<int> {
  @override
  StreamSubscription<int> listen(void Function(int event) onData, {Function onError, void Function() onDone, bool cancelOnError}) {
    // TODO: implement listen
    throw UnimplementedError();
  }

}

class GetxTextLogic extends GetxController {
  final state = GetxTextState();

  void increase() {
    state.count++;
    // debounce(state.count.value, callback)
  }

  @override
  void onReady() {
    loadData();
    // state.worker = antiShake<int>(state.count.value, (int value) => print('callback: $value'));
    super.onReady();
  }

  @override
  void dispose() {
    state.worker.dispose();
    super.dispose();
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
