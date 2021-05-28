import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GetxTextState {
  RxInt count;
  RxString select;
  RxList<RxString> list;

  GetxTextState() {
    count = 0.obs;
    select = ''.obs;
    list = <RxString>[].obs;
  }
}
