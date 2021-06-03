import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GetxTextState {
  RxInt count;
  RxString select;
  List<String> servers;

  GetxTextState() {
    count = 0.obs;
    select = ''.obs;
    servers = <String>[].obs;
  }
}
