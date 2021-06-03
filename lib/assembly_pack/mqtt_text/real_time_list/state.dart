import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RealTimeListState {
  VoidCallback voidCallback;
  RxList<String> realDatas;

  RealTimeListState() {
    voidCallback = null;
    realDatas = <String>[].obs;
  }
}
