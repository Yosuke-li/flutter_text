import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RealTimeListState {
  VoidCallback? voidCallback;
  late RxList<String> realDatas;

  RealTimeListState() {
    voidCallback = null;
    realDatas = <String>[].obs;
  }
}
