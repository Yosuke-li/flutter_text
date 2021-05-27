import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';

import 'state.dart';

class GetxTextLogic extends GetxController {
  final state = GetxTextState();

  void increase() => state.count++;

  @override
  void onReady() {
    final Map<String, dynamic> map = Get.arguments;
    state.count.value = map['count'];
    super.onReady();
  }
}
