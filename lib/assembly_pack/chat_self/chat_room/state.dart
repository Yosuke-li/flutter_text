import 'package:get/get_rx/get_rx.dart';

class ChatRoomState {
  late RxString topic;

  ChatRoomState() {
    topic = ''.obs;
  }
}
